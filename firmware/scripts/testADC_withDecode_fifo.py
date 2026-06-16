#
# Script to exercise MAROC ADC test firmware
#

# subprocess for quick hack...
from subprocess import call

# NB. binstr isn't a standard Python library. Install from
# https://pypi.python.org/pypi/binstr/1.3
import binstr

from PyChipsUser import *

import sys
from optparse import OptionParser

import MarocSC

import time

def int2bin(n):
	'From positive integer to list of binary bits, msb at index 0'
	if n:
		bits = []
		while n:
			n,remainder = divmod(n, 2)
			bits.insert(0, remainder)
		return bits
	else: return [0]
  
def bin2int(bits):
	'From binary bits, msb at index 0 to integer'
	i = 0
	for bit in bits:
		i = i * 2 + bit
	return i

def gray2bin(bits):
	b = [bits[0]]
	for nextb in bits[1:]: b.append(b[-1] ^ nextb)
	return b

def greyIntToInt(greyInt):
        greyBin = int2bin(greyInt)
        normalBin = gray2bin(greyBin)
        return bin2int(normalBin)

####################################################################################################
parser = OptionParser()
parser.add_option("-i", dest = 'ipAddress' , default="192.168.200.16")
parser.add_option("-a", dest = 'boardAddressTable' , default="./pc049aAddrTable_marocdemo.txt")

(options, args) = parser.parse_args()
print("IP address = " + options.ipAddress)
print("Board address table " + options.boardAddressTable)
        
bAddrTab = AddressTable(options.boardAddressTable)

board = ChipsBusUdp(bAddrTab,options.ipAddress,50001)

firmwareID=board.read("FirmwareId")
print("Firmware = " , hex(firmwareID))

# Set up slow control
marocSC = MarocSC.MarocSC()
marocSC.setParameterValue("DAC",[650,450])
marocSC.setFlagValue("d1_d2",0)
marocSC.setFlagValue("cmd_fsb_fsu",1) # Select FSU 
marocSC.setParameterValue("mask_OR",0x3,54) # Mask hot channel
SCData = marocSC.getWordArray()
print(SCData)
marocSC.writeConfigFile("testADC_marocSC.csv")

# Should write to output data buffer
board.blockWrite("scSrDataOut",SCData)
board.write("scSrCtrl" , 0x00000000)

# Set up which triggers are active. 
#board.write("trigSourceSelect",0x00000001) # Just set internal triggers active
board.write("trigSourceSelect",0x0000000D) # Set OR1,OR2 and internal triggers active

trigSource = board.read("trigSourceSelect")
print("Trigger source select register = " , hex(trigSource))

print("Resetting timestamp and trigger counters")
board.write("trigStatus",0x00000001) 

useSoftwareTrigger = False
conversionOnly = False
resetWritePointer = True
sleepBeforeReadout = True

if resetWritePointer:
        # Should trigger an ADC conversion
        print("Resetting write pointer")
        board.write("adcCtrl",0x00000002)

if useSoftwareTrigger:
        print("Firing manual trigger (should also trigger ADC conversion)")
        board.write("trigManualTrigger",0x00000001)

if conversionOnly:
        # Should trigger an ADC conversion
        print("Starting ADC conversion")
        board.write("adcCtrl",0x00000001)

adcStatus = board.read("adcCtrl")
print("ADC Status before conversion = " , hex(adcStatus))

if sleepBeforeReadout:
        sleepTime = 5
        print("Sleeping for ",sleepTime, " seconds. Press manual trigger")
        time.sleep(sleepTime)

# Set usePing=1 if running with simulated hardware. Set to zero if running with real hardware.
usePing = 0
if usePing:
        # use for Modelsim with DMN fake hardware to allow sim to run....
        call(["ping", "-c" , "26" , "192.168.200.16"])

adcStatus = board.read("adcCtrl")
print("ADC Status after conversion = " , hex(adcStatus))

bitCount = board.read("adcBitCount")
print("ADC bit count = " , bitCount , "(should be 64*12 = 768 bits)")

adcWritePointer = board.read("adcWritePointer")
print("ADC write pointer = ", hex(adcWritePointer))


#adcDataSize = 1024
print("Reading ADC data referenced to write pointer")
adcDataSize = 26
adcData = board.blockRead("adcData", adcDataSize , 
                          (adcWritePointer - adcDataSize))

print("Trigger Number = " , hex(adcData[0]))
print("Timestamp = " , hex(adcData[1]))

hexAdcData = [ hex(x) for x in adcData]
#print adcData
print(hexAdcData)

nBits = 12
busWidth = 32
nADC = 64
for adcNumber in range(0 , nADC) :
	lowBit = adcNumber*nBits
	lowWord = (adcDataSize-1) - (lowBit /busWidth)  # rounds to integer
	lowBitPos = lowBit % busWidth
	
	if adcNumber > (nADC-3): # for adc's 62,63
		longWord = adcData[lowWord]
	else:
		longWord = adcData[lowWord] + (adcData[lowWord-1] << busWidth)

	adcValue = 0x0FFF & (longWord >> lowBitPos)

        adcValueBin = greyIntToInt(adcValue)

	print("nADC, lowBit , lowWord , lowBitPos , hex(longWord) , hex(adcValue)" , adcNumber , lowBit , lowWord , lowBitPos , hex(longWord) , hex(adcValue), hex( adcValueBin ))




 

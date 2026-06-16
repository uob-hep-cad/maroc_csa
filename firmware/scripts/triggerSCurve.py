#
# Script to read out Trigger counters looping over DAC values
#


from PyChipsUser import *

import sys , time
from optparse import OptionParser
import logging
import MarocSC

import matplotlib.pyplot as plt

###################################################################
# Define function to set DAC value
def setDAC ( marocSC , DACVal ):
	marocSC.setParameterValue("DAC",[DACVal,DACVal])
	SCData = marocSC.getWordArray()
	board.blockWrite("scSrDataOut",SCData)
	board.write("scSrCtrl" , 0x00000000)
	board.write("scSrCtrl" , 0x00000001)

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

marocSC = MarocSC.MarocSC(debugLevel=logging.INFO)
marocSC.setFlagValue("d1_d2",0) # Select FSU / FSB1 for trigger
marocSC.setFlagValue("cmd_fsb_fsu",1) # Select FSU 
marocSC.setParameterValue("mask_OR",0x3,54) # Mask hot channel


nChan = 64
oldTriggerCounterVals = nChan*[0]

triggerSCurveValues = [ [] for _ in range(nChan)] # stores an array of arrays. Each element is an S-Curve. Initialize to a list of empty lists.

print(triggerSCurveValues) 

looping = True
tSleep = 1.0

DACVals = list(range(0,1024,20))

for DACVal in DACVals:

	print("Setting DACVal = " , DACVal)

	setDAC ( marocSC , DACVal )
	oldTrigCounterVals = board.blockRead("trigCounterBase", nChan )
	time.sleep(tSleep)
	trigCounterVals = board.blockRead("trigCounterBase", nChan )

#	print delta
	for idx in range(len(trigCounterVals)):
		delta = trigCounterVals[idx] - oldTrigCounterVals[idx]
		# print "DACVal , idx, delta" , DACVal, idx,delta
		triggerSCurveValues[idx].append(delta)


# After loop we have an array of values with each element being a separate DAC value. 
# Reshape to have an array with 64 entries with each entry being an array of counts for a given DAC value.
print(triggerSCurveValues)

plt.plot(DACVals,triggerSCurveValues[27])
plt.ylabel("Trigger Counts (OR1/FSU)")
plt.xlabel("DAC0 value")
plt.show()

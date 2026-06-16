#
# Script to exercise MAROC ADC test firmware
#
from PyChipsUser import *

bAddrTab = AddressTable("./pc049aAddrTable_marocdemo.txt")

board = ChipsBusUdp(bAddrTab,"192.168.200.16",50001)

firmwareID=board.read("FirmwareId")

print("Firmware = " , hex(firmwareID))

adcSpecial = board.read("adcTestLocation")
print("ADC special value = " , hex(adcSpecial))

adcStatus = board.read("adcCtrl")
print("ADC Status before reset = " , hex(adcStatus))

# Should reset ADC

resetADC=0
if (resetADC):
    print("Resetting ADC")
    board.write("adcCtrl",0x00000002)

adcStatus = board.read("adcCtrl")
print("ADC Status before conversion = " , hex(adcStatus))

# Should trigger an ADC conversion
board.write("adcCtrl",0x00000001)

adcStatus = board.read("adcCtrl")
print("ADC Status after conversion = " , hex(adcStatus))

#adcDataSize = 1024
adcDataSize = 26
adcData = board.blockRead("adcData", adcDataSize)
print("ADC data = ")
print(adcData)

bitCount = board.read("adcBitCount")
print("ADC bit count = " , bitCount)

adcWritePointer = board.read("adcWritePointer")
print("ADC write pointer = ", hex(adcWritePointer))

#print "ADC data referenced to write pointer"
#adcData = board.blockRead("adcData", adcDataSize , adcWritePointer - adcDataSize )
#print adcData

print("Trigger Number = " , adcData[0])
print("Timestamp = " , adcData[1])

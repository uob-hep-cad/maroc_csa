#
# Script to write to MAROC configuration ( slow control ) shift register
# Specify a set of bits to write high..
#
import sys
from optparse import OptionParser

from PyChipsUser import *

import MarocSC

parser = OptionParser()
parser.add_option("-i", dest = 'ipAddress' , default="192.168.200.16")
parser.add_option("-a", dest = 'boardAddressTable' , default="./pc049aAddrTable_marocdemo.txt")

(options, args) = parser.parse_args()
print "IP address = " + options.ipAddress
print "Board address table " + options.boardAddressTable
        
bAddrTab = AddressTable(options.boardAddressTable)

board = ChipsBusUdp(bAddrTab,options.ipAddress,50001)

firmwareID=board.read("FirmwareId")
print "Firmware = " , hex(firmwareID)

marocSC = MarocSC.MarocSC()

#marocSC.setFlagValue("ON/OFF_dac",1)
marocSC.setParameterValue("DAC",[650,450])
marocSC.setFlagValue("d1_d2",0)
marocSC.setFlagValue("cmd_fsb_fsu",1) # Select FSU 
marocSC.setParameterValue("mask_OR",0x3,54) # Mask hot channel

SCData = marocSC.getWordArray()

print SCData

# Should write to output data buffer
board.blockWrite("scSrDataOut",SCData)

scdata0 = board.blockRead("scSrDataOut",len(SCData))
print "SC SR words to write = " , scdata0

writeWithReset = 1
writeNoReset = 1

if writeWithReset:


    scdata1 = board.blockRead("scSrDataIn",len(SCData))
    print "Returned data (before write) = " , scdata1

    # Trigger writing of control register
    board.write("scSrCtrl" , 0x00000000)
    print "Written data (with reset)"
    scdata1 = board.blockRead("scSrDataIn",len(SCData))
    print "Returned data (after write with reset = " , scdata1

if writeNoReset:

    # Trigger writing of control register
    board.write("scSrCtrl" , 0x00000001)
    print "Written data (no reset)"
    scdata1 = board.blockRead("scSrDataIn",len(SCData))
    print "Returned data (after write no reset = " , scdata1



 

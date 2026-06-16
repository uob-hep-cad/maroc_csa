#
# Script to exercise AIDA mini-TLU
#
# David Cussans, December 2012
# 
# Modified by Alvaro Dosil, January 2013

from PyChipsUser import *
from pc049a_i2c.py import *
from ROOT import *

import sys
import time


def mean(TS):
    val=0
    for i in range(1,len(TS)):
        val+=TS[i]-TS[i-1]
    return val/(len(TS)-1)



bAddrTab = AddressTable("./aida_mini_tlu_addr_map.txt")

# Assume DIP-switch controlled address. Switches at 1 
board = ChipsBusUdp(bAddrTab,"192.168.200.16",50001)



firmwareID=board.read("FirmwareId")

print("Firmware = " , hex(firmwareID))

# Check the bus for I2C devices
boardi2c = FmcTluI2c(board)

print("Scanning I2C bus:")
scanResults = boardi2c.i2c_scan()
print(scanResults)

boardId = boardi2c.get_serial_number()
print("serial number = " , boardId)


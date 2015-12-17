#
# Script to read board ID from MAROC board
#
from PyChipsUser import *

bAddrTab = AddressTable("./pc049aAddrTable_marocdemo.txt")

board = ChipsBusUdp(bAddrTab,"192.168.200.16",50001)

adcData=board.blockRead("adcData",50)

print "adcData = " , adcData

#
# Script to read board ID from MAROC board
#
from PyChipsUser import *

bAddrTab = AddressTable("./pc049aAddrTable_marocdemo.txt")

board = ChipsBusUdp(bAddrTab,"192.168.200.16",50001)

firmwareID=board.read("FirmwareId")

print(("Firmware ID = " , hex(firmwareID)))

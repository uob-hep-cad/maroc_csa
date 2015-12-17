#
# Script to read board ID from MAROC board
#
from PyChipsUser import *

bAddrTab = AddressTable("./pc049aAddrTable.txt")

#board = ChipsBusUdp(bAddrTab,"192.168.201.8",50001)
board = ChipsBusUdp(bAddrTab,"192.168.200.16",50001)

board.write("Ram",0xDEADBEEF)
#board.write("Ram",0xFEADDEAD)

ramContents = board.read("Ram")

print "ram contents = " , hex(ramContents )

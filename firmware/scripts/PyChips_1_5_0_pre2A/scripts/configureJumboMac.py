# Configures the Ethernet MAC to use jumbo frames, when using Dave Newbold's default firmware.
#
#  Robert Frazier, Oct 2011

from PyChipsUser import *
#chipsLog.setLevel(logging.DEBUG)   # Uncomment for debug output!

# ******************************************************
# ****  Set IP and port number of board in question ****
boardIpAddr = "192.168.200.32"   # TODO: make this a command line parameter...
boardPortNum = 50001
# ******************************************************


if __name__ == '__main__':

    addrTable = AddressTable("../addressTables/davesFirmwareSoakTestAddrTable.txt")
    board = ChipsBusUdp(addrTable, boardIpAddr, boardPortNum)

    board.write("MacHostBusPtr", 0x240)
    result = board.read("MacHostBusReg")
    print "Receiver register is set to:", hex(result)
    print "Writing back previous value with bit 30 set high..."
    board.write("MacHostBusReg", (result | 0x40000000))
    print "...done."

    board.write("MacHostBusPtr", 0x280)
    result = board.read("MacHostBusReg")
    print "Transmitter register is set to:", hex(result)
    print "Writing back previous value with bit 30 set high..."
    board.write("MacHostBusReg", (result | 0x40000000))
    print "...done."

#  Import the PyChips code - PYTHONPATH must be set to the PyChips installation src folder!
from PyChipsUser import *

##################################################################################################
### Uncomment one of the following two lines to turn on verbose or very-verbose debug modes.   ###
### These debug modes allow you to see the packets being sent and received.                    ###
##################################################################################################
#chipsLog.setLevel(logging.DEBUG)    # Verbose logging (see packets being sent and received)


# Read in an address table by creating an AddressTable object (Note the forward slashes, not backslashes!)
addrTable = AddressTable("../addressTables/davesFirmwareSoakTestAddrTable.txt")

# Create a ChipsBus bus to talk to your board.
# These require an address table object, an IP address and a port number
myBoard = ChipsBusUdp(addrTable, "localhost", 50001)  # Change "localhost" to an IP address like "192.168.10.1", etc

# Perform some basic single-register reads and writes.
# Note that single-register reads and writes can be done on registers with a mask.
# See:  help(ChipsBusUdp.read)  and  help(ChipsBusUdp.write) for more info on the below.
myBoard.write("Test", 0xdeadbeef)
print "'Test' register value is:", hex(myBoard.read("Test"))
myBoard.write("Test", 0xcafebabe)
print "'Test' register value is now:", hex(myBoard.read("Test"))

# Perform some block reads/writes:
# See:  help(ChipsBusUdp.blockWrite) and help(ChipsBusUdp.blockRead) for more info
myBoard.blockWrite("BigTestRam", [0xdeadbeef, 0xcafebabe, 0x0ddba115, 0xbeefcafe])
blockReadResult = myBoard.blockRead("BigTestRam", 4)    # 4 is the read depth.
print "\nBlock read result is:", uInt32HexListStr(blockReadResult)


# For further details on the basic API, please see:  help(ChipsBusUdp)

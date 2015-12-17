#
# Script to read out Trigger counters
#


from PyChipsUser import *

import sys
from optparse import OptionParser


####################################################################################################
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


nChan = 64

#trigCounters = board.blockRead("trigCounterBase", nChan )
for chan in range(0 , nChan) :
	trigCounterVal = board.read("trigCounterBase", nChan )
	print "chan, count = " , chan , trigCounterVal

#board.blockWrite("trigCounterBase", nChan*[0] )

#trigCounters = board.blockRead("trigCounterBase", nChan )
#for chan in range(0 , nChan) :
#	print "chan, count = " , chan , trigCounters[chan]

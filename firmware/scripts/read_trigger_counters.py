#
# Script to read out Trigger counters
#


from PyChipsUser import *

import sys , time
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
oldTriggerCounterVals = nChan*[0]

looping = True
tSleep = 1.0

while looping:
	trigCounterVals = board.blockRead("trigCounterBase", nChan )
	for chan in range(0 , nChan) :
		delta = trigCounterVals[chan] - oldTriggerCounterVals[chan]
		print "chan, count , delta = " , chan , trigCounterVals[chan] , delta
	oldTriggerCounterVals = trigCounterVals
	time.sleep(tSleep)

#board.blockWrite("trigCounterBase", nChan*[0] )


#
# Script setup MAROC and take data.
#

import sys
import time
from optparse import OptionParser
import csv

import MarocReadoutThread
import MarocUnpackingThread
import MarocHistogrammingThread

from PyChipsUser import *

import Queue

parser = OptionParser()
parser.add_option("-i", dest = 'ipAddress' , default="192.168.200.16")

parser.add_option("-a", dest = 'boardAddressTable' , default="./pc049aAddrTable.txt")

parser.add_option("-o", dest = 'outputFile' , default = 'marocTimeStamps.dat' )

parser.add_option("-n" , dest = 'numTriggers' , default = 600 )

(options, args) = parser.parse_args()

print "IP address = " + options.ipAddress
print "Board address table " + options.boardAddressTable
        
bAddrTab = AddressTable(options.boardAddressTable)

board = ChipsBusUdp(bAddrTab,options.ipAddress,50001)

firmwareID = board.read("FirmwareId")

print "Firmware ID = " , hex(firmwareID)

rawDataQueue = Queue.Queue()
unpackedDataQueue = Queue.Queue()

readoutThread = MarocReadoutThread.MarocReadoutThread(1,"readoutThread",board,rawDataQueue,debugLevel=logging.INFO)

unpackerThread = MarocUnpackingThread.MarocUnpackingThread(2,"unpackingThread",rawDataQueue,unpackedDataQueue,debugLevel=logging.INFO)

histogramThread = MarocHistogrammingThread.MarocHistogrammingThread(3,"histogrammingThread",unpackedDataQueue,debugLevel=logging.INFO)

readoutThread.start()
unpackerThread.start()
histogramThread.start()


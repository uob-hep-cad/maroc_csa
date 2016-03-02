#
# Script setup MAROC and take data.
#

import sys
import time
from optparse import OptionParser
import csv

from marocLogging import marocLogging
import logging

import MarocReadoutThread
import MarocUnpackingThread
import MarocRecordingThread
import MarocHistogrammingThread
import MarocRunControlThread

import MarocConfiguration

from PyChipsUser import *

import Queue

logger = logging.getLogger(__name__)
marocLogging(logger,logging.DEBUG)

parser = OptionParser()
parser.add_option("-i", dest = 'ipAddress' , default="192.168.200.16")

parser.add_option("-a", dest = 'boardAddressTable' , default="./pc049aAddrTable.txt")

parser.add_option("-o", dest = 'outputFile' , default = 'marocTimeStamps.root' )

parser.add_option("-n" , dest = 'numTriggers' , default = 1000 )

(options, args) = parser.parse_args()

logger.info("IP address = %s"%( options.ipAddress))
logger.info("Board address table %s"%( options.boardAddressTable))

numTriggers = int(options.numTriggers)

logger.info("Event limit = %i "%( numTriggers))

bAddrTab = AddressTable(options.boardAddressTable)

board = ChipsBusUdp(bAddrTab,options.ipAddress,50001)

firmwareID = board.read("FirmwareId")

print "Firmware ID = " , hex(firmwareID)

# Create object with configuration information - in the long run this should be done in a separate thread with a GUI
marocConfiguration = MarocConfiguration.MarocConfiguration(board,debugLevel=logging.DEBUG)


rawDataQueue = Queue.Queue()
recordingDataQueue = Queue.Queue()

histogramQueueSize = 100
histogramDataQueue = Queue.Queue(histogramQueueSize)

# Create a readout thread. Pass down an event limit. When the event limit is reached the readout thread will pass a message along chain and threads will terminate.

readoutThread = MarocReadoutThread.MarocReadoutThread(1,"readoutThread",board,rawDataQueue,numTriggers,debugLevel=logging.INFO)

unpackerThread = MarocUnpackingThread.MarocUnpackingThread(2,"unpackingThread",rawDataQueue,recordingDataQueue,histogramDataQueue,debugLevel=logging.INFO)

histogramThread = MarocHistogrammingThread.MarocHistogrammingThread(3,"histogrammingThread",histogramDataQueue,debugLevel=logging.INFO)

recordingThread = MarocRecordingThread.MarocRecordingThread(3,"recordingThread",recordingDataQueue,fileName=options.outputFile, debugLevel=logging.DEBUG)


# Send configuration to board. 
marocConfiguration.configure()

# Having created the threads, now start them running
readoutThread.start()
unpackerThread.start()
histogramThread.start()
recordingThread.start()

# Wait for threads to exit
readoutThread.join()
unpackerThread.join()
histogramThread.join()
recordingThread.join()

logger.info("All threads terminated. Exiting main programme")

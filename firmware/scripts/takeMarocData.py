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

#import Queue
from Queue import Queue
#from multiprocessing import Queue

#debugLevel = logging.DEBUG
debugLevel = logging.INFO

logger = logging.getLogger(__name__)
marocLogging(logger,debugLevel)

parser = OptionParser()
parser.add_option("-i", dest = 'ipAddress' , default="192.168.200.16")

parser.add_option("-a", dest = 'boardAddressTable' , default="./pc049aAddrTable.txt")

parser.add_option("-o", dest = 'outputFile' , default = 'marocTimeStamps.root' )

parser.add_option("-n" , dest = 'numTriggers' , default = 1000 )

parser.add_option("-t" , dest = 'numInternalTriggers' , default = 0 )

parser.add_option("-c" , dest = 'configFile' , default = 'testADC_marocSC.csv' )

(options, args) = parser.parse_args()

logger.info("IP address = %s"%( options.ipAddress))
logger.info("Board address table %s"%( options.boardAddressTable))

numTriggers = int(options.numTriggers)

numInternalTriggers = int(options.numInternalTriggers)

logger.info("Event limit = %i "%( numTriggers))

bAddrTab = AddressTable(options.boardAddressTable)

board = ChipsBusUdp(bAddrTab,options.ipAddress,50001)

firmwareID = board.read("FirmwareId")

logger.info("Firmware ID = %s" % (hex(firmwareID)))

# Create object with configuration information - in the long run this should be done in a separate thread with a GUI
marocConfiguration = MarocConfiguration.MarocConfiguration(board,configurationFile = options.configFile , debugLevel=debugLevel)


rawDataQueue = Queue()
recordingDataQueue = Queue()

histogramQueueSize = 100
histogramDataQueue = Queue(histogramQueueSize)



# Create a readout thread. Pass down an event limit. When the event limit is reached the readout thread will pass a message along chain and threads will terminate.

readoutThread = MarocReadoutThread.MarocReadoutThread(1,"readoutThread",board,rawDataQueue,numTriggers,numInternalTriggers,debugLevel=debugLevel)

unpackerThread = MarocUnpackingThread.MarocUnpackingThread(2,"unpackingThread",rawDataQueue,recordingDataQueue,histogramDataQueue,debugLevel=debugLevel)

histogramThread = MarocHistogrammingThread.MarocHistogrammingThread(3,"histogrammingThread",histogramDataQueue,debugLevel=debugLevel)

recordingThread = MarocRecordingThread.MarocRecordingThread(3,"recordingThread",recordingDataQueue,fileName=options.outputFile, debugLevel=debugLevel)


# Send configuration to board.
#marocConfiguration.slowControlObject.setParameterValue("DAC",[650,450])
#marocConfiguration.slowControlObject.setFlagValue("d1_d2",0)
#marocConfiguration.slowControlObject.setFlagValue("cmd_fsb_fsu",1) # Select FSU
#marocConfiguration.slowControlObject.setParameterValue("mask_OR",0x3,54) # Mask hot channel

# Send configuration to the board ( read from configuration file)
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

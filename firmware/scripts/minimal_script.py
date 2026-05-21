# -*- coding: utf-8 -*-
from PyChipsUser import *
import MarocConfiguration
from optparse import OptionParser
import csv
from marocLogging import marocLogging

logger = logging.getLogger(__name__)
debugLevel = logging.INFO
marocLogging(logger,debugLevel)

parser = OptionParser()
parser.add_option("-i", dest = 'ipAddress' , default="192.168.200.16")		#set ip
parser.add_option("-a", dest = 'boardAddressTable' , default="./pc049aAddrTable.txt")   #set the table
parser.add_option("-o", dest = 'outputFile' , default = './datafolder/marocTimeStamps_minimal.root' )   #where I want save the data
parser.add_option("-n" , dest = 'numTriggers' , default = 1000 )			#how many triggers I want, can be in time
parser.add_option("-t" , dest = 'numInternalTriggers' , default = 0 )
parser.add_option("-c" , dest = 'configFile' , default = './datafolder/testADC_marocSC.csv' )   #the file uses for all settings

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

# Define instance to configure MAROC board. Read the CSV file and then send it to the board using IPBus
marocConfiguration = MarocConfiguration.MarocConfiguration(board,configurationFile = options.configFile , debugLevel=debugLevel)
marocConfiguration.configure()
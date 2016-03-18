#
# Python class to read ADC data from readout thread and unpack into ADC values.
#
import logging
from marocLogging import marocLogging

# NB. binstr isn't a standard Python library. Install from
# https://pypi.python.org/pypi/binstr/1.3
import binstr

from PyChipsUser import *

#import threading
from threading import Thread
#from multiprocessing import Process as Thread

import time

#import Queue
from Queue import Queue
#from multiprocessing import Queue

import array

class MarocUnpackingThread(Thread):
    """Class with functions that can read unpack raw MAROC3 ADC data and pack into an array of integers. Inherits from threading class, so has a 'start' method"""
    def __init__(self, threadID, name , rawDataQueue , recordingDataQueue, histogramDataQueue , debugLevel=logging.DEBUG ):
        Thread.__init__(self)
        self.threadID = threadID
        self.name = name
        self.rawDataQueue = rawDataQueue
        self.recordingDataQueue = recordingDataQueue
        self.histogramDataQueue = histogramDataQueue
        self.debugLevel = debugLevel
        self.logger = logging.getLogger(__name__)

    def run(self):

        marocLogging(self.logger,self.debugLevel)

        self.logger.info( "Starting thread" )

        unpack_maroc_data(self.name, self.rawDataQueue , self.recordingDataQueue , self.histogramDataQueue , self.logger)

        self.logger.info( "Ending thread" )



def int2bin(n):
	'From positive integer to list of binary bits, msb at index 0'
	if n:
		bits = []
		while n:
			n,remainder = divmod(n, 2)
			bits.insert(0, remainder)
		return bits
	else: return [0]
  
def bin2int(bits):
	'From binary bits, msb at index 0 to integer'
	i = 0
	for bit in bits:
		i = i * 2 + bit
	return i

def gray2bin(bits):
	b = [bits[0]]
	for nextb in bits[1:]: b.append(b[-1] ^ nextb)
	return b

def greyIntToInt(greyInt):
        greyBin = int2bin(greyInt)
        normalBin = gray2bin(greyBin)
        return bin2int(normalBin)


def unpack_maroc_data(name, rawDataQueue , recordingDataQueue, histogramDataQueue , logger):

    exitFlag = False
    while not exitFlag:
        adcData = rawDataQueue.get()
        logger.debug("Read data from raw data queue = \n%s"%( '  , '.join([format(i,'08x') for i in adcData ]) ))

        if len(adcData) == 1:
            logger.info("Swallowed poison pill from readout thread.")
            exitFlag = True
            continue
        
        nBits = 12
        busWidth = 32
        nADC = 64
        adcDataSize = 26
        logger.info("event number , time-stamp , event size = %i %i %i"%( adcData[0],adcData[1],len(adcData)))
                      
        #assert adcDataSize == len(adcData)
        unpackedAdcData = array.array('H')
        eventNumber = adcData[0]
        eventTimeStamp = adcData[1]
                
        for adcNumber in range(0 , nADC) :
	    lowBit = adcNumber*nBits
	    lowWord = (adcDataSize-1) - (lowBit /busWidth)  # rounds to integer
	    lowBitPos = lowBit % busWidth
	
	    if adcNumber > (nADC-3): # for adc's 62,63
	        longWord = adcData[lowWord]
	    else:
	        longWord = adcData[lowWord] + (adcData[lowWord-1] << busWidth)

	    adcValue = 0x0FFF & (longWord >> lowBitPos)

            adcValueBin = greyIntToInt(adcValue)

            unpackedAdcData.append(adcValueBin)

        logger.debug("Event number, timestamp, Unpacked ADC data = %i %i \n%s"%( eventNumber, eventTimeStamp , '  , '.join([format(i,'08x') for i in unpackedAdcData ]) ))

        unpackedData = [eventNumber, eventTimeStamp, unpackedAdcData]

        # Push the data to histogramming
        # only push data if the queue has space in it
        if not histogramDataQueue.full():
            histogramDataQueue.put(unpackedData)

        # Push data to recording.
        recordingDataQueue.put(unpackedData)

    poisonPill = [-1]
    histogramDataQueue.put(poisonPill)
    logger.info("Fed poison pill to histogrammer")

    # Bodge - give time for histogrammer to fill the last histogram before sending poison pill to data recorder.
    # If the ROOT file is closed the histograms become undefined....
    time.sleep(2.0)

    recordingDataQueue.put(poisonPill)
    logger.info("Fed poison pill to data recorder")
    

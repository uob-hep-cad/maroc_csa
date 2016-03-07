#
# Python class to read ADC data from readout thread and unpack into ADC values.
#
import logging

from PyChipsUser import *

#import threading
from threading import Thread

import time

#import Queue
from Queue import Queue

import MarocHistograms

from marocLogging import marocLogging

class MarocHistogrammingThread(Thread):
    """Class with functions that can read unpacked MAROC3 ADC data histogramme the results. Inherits from threading class, so has a 'start' method"""
    def __init__(self, threadID, name , unpackedDataQueue , debugLevel=logging.DEBUG ):
        Thread.__init__(self)
        self.threadID = threadID
        self.name = name
        self.unpackedDataQueue = unpackedDataQueue
        self.debugLevel = debugLevel
        self.histogramObject = MarocHistograms.MarocHistograms(debugLevel=debugLevel)
        self.logger = logging.getLogger(__name__)

    def run(self):
        exitFlag = 0
        marocLogging(self.logger,self.debugLevel)

        self.logger.info( "Starting thread" )

        self.histogramObject.createHistograms()

        while not exitFlag:

            unpackedData = self.unpackedDataQueue.get()
            if len(unpackedData) == 1:
                self.logger.info("Swallowed poison pill from readout thread.")
                exitFlag = True
                continue

        
            [ eventNumber , timeStamp , AdcData ] = unpackedData

            self.logger.info("Event number , timestamp = %i %i "%(eventNumber, timeStamp))
            self.logger.debug("Read ADC data from unpacked data queue = \n%s"%( '  , '.join([format(i,'08x') for i in AdcData ]) ))

            self.logger.debug("event size = %i"%( len(AdcData)))
                      
            #eventNumber = unpackedAdcData.pop(0)
            #timeStamp =  unpackedAdcData.pop(0)

            self.histogramObject.fillHistograms(eventNumber,timeStamp,AdcData)
        
        self.logger.info( "Ending thread" )


        

        

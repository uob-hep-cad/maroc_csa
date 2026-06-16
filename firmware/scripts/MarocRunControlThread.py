
# Python class to read ADC data from readout thread and unpack into ADC values.
#
import logging

from PyChipsUser import *

import threading

import time

import queue

import MarocRecording

from marocLogging import marocLogging

class MarocRecordingThread(threading.Thread):
    """Class with functions that can store data from MAROC3 into a ROOT file as a TTree. Inherits from threading class, so has a 'start' method"""
    def __init__(self, threadID, name , unpackedDataQueue , fileName="marocData.root" , debugLevel=logging.DEBUG ):
        threading.Thread.__init__(self)
        self.threadID = threadID
        self.name = name
        self.unpackedDataQueue = unpackedDataQueue
        self.debugLevel = debugLevel
        self.fileName = fileName
        self.fileObject = MarocRecording.MarocRecording(fileName=fileName,debugLevel=debugLevel)
        self.logger = logging.getLogger(__name__)

    def run(self):
        exitFlag = 0
        marocLogging(self.logger,self.debugLevel)

        self.logger.info( "Starting thread" )

        while not exitFlag:

            unpackedData = self.unpackedDataQueue.get()
            [ eventNumber , timeStamp , unpackedAdcData ] = unpackedData

            self.logger.debug("Read ADC data from unpacked data queue event number , timestamp, ADC-data = %i %i \n%s"%( (eventNumber, timeStamp , '  , '.join([format(i,'08x') for i in AdcData ]) )))

            #self.logger.debug("Read unpacked data from unpacked data queue = \n%s"%( '  , '.join([format(i,'08x') for i in unpackedAdcData ]) ))

            self.logger.debug("event size = %i"%( len(unpackedAdcData)))
                      
            self.fileObject.writeEvent(eventNumber,timeStamp,unpackedAdcData)

        self.logger.info( "Ending thread" )


# Python class to read ADC data from readout thread and unpack into ADC values.
#
import logging

from PyChipsUser import *

import threading

import time

import Queue

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

            unpackedAdcData = self.unpackedDataQueue.get()
            self.logger.debug("Read data from unpacked data queue = \n%s"%( '  , '.join([format(i,'08x') for i in unpackedAdcData ]) ))

            self.logger.debug("event size = %i"%( len(unpackedAdcData)))
                      
            eventNumber = unpackedAdcData.pop(0)
            timeStamp =  unpackedAdcData.pop(0)

            self.logger.info("Event number , timestamp = %i %i "%(eventNumber, timeStamp))

            self.fileObject.writeEvent(eventNumber,timeStamp,unpackedAdcData)
        
        print "Exiting " + self.name

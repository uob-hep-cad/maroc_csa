# -*- coding: utf-8 -*-

# Python class to read ADC data from readout thread and unpack into ADC values.
#
import logging

from PyChipsUser import *

#import threading
from threading import Thread
#from multiprocessing import Process as Thread

import time

#import Queue
from Queue import Queue
#from multiprocessing import Queue

import MarocRecording

from marocLogging import marocLogging

class MarocRecordingThread(Thread):
    """Class with functions that can store data from MAROC3 into a ROOT file as a TTree. Inherits from threading class, so has a 'start' method"""
    def __init__(self, threadID, name , unpackedDataQueue , fileName="marocData.root" , debugLevel=logging.DEBUG, timeLenght= 10 ):
        Thread.__init__(self)
        self.threadID = threadID
        self.name = name
        self.unpackedDataQueue = unpackedDataQueue
        self.debugLevel = debugLevel
        self.fileName = fileName
        self.fileObject = MarocRecording.MarocRecording(fileName=fileName,debugLevel=debugLevel)
        self.logger = logging.getLogger(__name__)
	self.start_time = time.time()
	self.runTimeLenght= timeLenght
	

    def run(self):
        exitFlag = 0
        marocLogging(self.logger,self.debugLevel)

        self.logger.info( "Starting thread" )
	#self.logger.info( "Will record for", self.runTimeLenght, " seconds" )
        while not exitFlag:
	    elapsed_time = time.time() - self.start_time
	    if ((elapsed_time > self.runTimeLenght) & (self.runTimeLenght > 0)):
		exitFlag = True
		self.logger.info("Elapsed required time. Exiting.")
            unpackedData = self.unpackedDataQueue.get()
            
            if len(unpackedData) == 1:
                self.logger.info("Swallowed poison pill from unpacking thread.")
                exitFlag = True
                continue
        
            [ eventNumber , timeStamp , unpackedAdcData ] = unpackedData

            self.logger.debug("Read ADC data from unpacked data queue event number , timestamp, ADC-data = %i %i \n%s"%( (eventNumber, timeStamp , '  , '.join([format(i,'08x') for i in unpackedAdcData ]) )))

            self.logger.debug("event size = %i"%( len(unpackedAdcData)))
                      
            self.fileObject.writeEvent(eventNumber,timeStamp,unpackedAdcData)

        self.fileObject.closeFile()
        
        self.logger.info( "Ending thread" )

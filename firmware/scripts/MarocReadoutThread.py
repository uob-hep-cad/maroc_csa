#
# Python class to read data from MAROC board
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

import MarocDAQ

from marocLogging import marocLogging

class MarocReadoutThread(Thread):
    """Class with functions that can read out MAROC3 using IPBus. Inherits from threading class, so has a 'start' method"""
    def __init__(self, threadID, name, board , rawDataQueue , numTriggers, debugLevel=logging.DEBUG ):
        Thread.__init__(self)
        self.threadID = threadID
        self.board = board
        self.name = name
        self.rawDataQueue = rawDataQueue
        self.numTriggers = numTriggers
        self.debugLevel = debugLevel
        self.logger = logging.getLogger(__name__)
        self.lastEventRead = -1

    def run(self):

        marocLogging(self.logger,self.debugLevel)

        self.logger.info( "Starting thread. Event limit = %i" %(self.numTriggers) )

        self.readout_maroc(self.name, self.board , self.rawDataQueue , self.numTriggers , self.logger , self.debugLevel)

        self.logger.info( "Exiting thread" )


    def readout_maroc(self, name, board , rawDataQueue , numTriggers , logger , debugLevel):

        exitFlag = False

        # Create pointer to MAROC board and set up structures.
        marocData = MarocDAQ.MarocDAQ(board,debugLevel)

        # BODGE - wait for histogram thread to book histograms.
        time.sleep(5)

        # Reset pointers
        marocData.resetCounters()
        marocData.resetADCPointers()

        while not exitFlag:

            # Read data from MAROC
            events = marocData.readADCData()

            # fill the queue
            for event in events:
                eventNumber = event[0]

                # Try to detect and recover from buffer over-run
                if (eventNumber != self.lastEventRead +1) and (self.lastEventRead != -1) :
                    logger.warn("Buffer over-run detected! Event read = %i , previous event = %i . Resetting read and write pointers " %(eventNumber,self.lastEventRead))
                    marocData.resetADCPointers()
                    self.lastEventRead = -1
                    break # break out of loop and read another block of data.

                self.lastEventRead = eventNumber

                logger.info("Read event %i",eventNumber)

                if ( eventNumber > numTriggers):
                    exitFlag = True
                    logger.info("Setting exitFlag = True")
                logger.debug("Pushing data into raw data queue = \n%s"%( '  , '.join([format(i,'08x') for i in event ]) ))
                rawDataQueue.put(event)



        # TODO - set exit flag when told to by run control. Start and stop run when told to by run control.

        poisonPill = [-1]
        rawDataQueue.put(poisonPill)
        logger.info("Fed poison pill to unpacker")


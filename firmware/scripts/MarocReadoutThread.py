#
# Python class to read data from MAROC board
#
import logging

from PyChipsUser import *

import threading

import time

import Queue

import MarocDAQ

from marocLogging import marocLogging

class MarocReadoutThread(threading.Thread):
    """Class with functions that can read out MAROC3 using IPBus. Inherits from threading class, so has a 'start' method"""
    def __init__(self, threadID, name, board , rawDataQueue , debugLevel=logging.DEBUG ):
        threading.Thread.__init__(self)
        self.threadID = threadID
        self.board = board
        self.name = name
        self.rawDataQueue = rawDataQueue
        self.debugLevel = debugLevel
        self.logger = logging.getLogger(__name__)

    def run(self):

        marocLogging(self.logger,self.debugLevel)

        self.logger.info( "Starting thread" )

        readout_maroc(self.name, self.board , self.rawDataQueue , self.logger , self.debugLevel)

        self.logger.info( "Exiting thread" )

exitFlag = 0
def readout_maroc(name, board , rawDataQueue , logger , debugLevel):

    # Create pointer to MAROC board and set up structures.
    marocData = MarocDAQ.MarocDAQ(board,debugLevel)

    while not exitFlag:
        
        # Read data from MAROC
        events = marocData.readADCData()
        
        # fill the queue
        for event in events:
            logger.debug("Pushing data into raw data queue = \n%s"%( '  , '.join([format(i,'08x') for i in event ]) ))
            rawDataQueue.put(event)

    # TODO - set exit flag when told to by run control. Start and stop run when told to by run control.
        

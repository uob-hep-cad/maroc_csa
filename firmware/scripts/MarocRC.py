#
#
# Python class to set up MAROC-3 dynamic ("R") control register.
#
#
import ConfigParser

import logging
from marocLogging import marocLogging

from itertools import imap

class MarocRC(object):
    """Sets up an array of 32-bit words that can be written to MAROC-3 dynamic ("R") control register via a block write to IPBus-based firmware."""

    def __init__(self, hold1, hold2, debugLevel=logging.DEBUG):
        
        self.numRCbits = 128   # number of bits in dynamic control register. 2 x number of channels           
        self.busWidth = 32
        self.numWords =  self.numRCbits/ self.busWidth
        self.debugLevel = debugLevel

        self.logger = logging.getLogger(__name__)
        marocLogging(self.logger,debugLevel)

        self.hold1 = hold1
        self.hold2 = hold2



    def setRCData(self,hold1,hold2):

        self.hold1 = hold1
        self.hold2 = hold2


    def getWordArray(self):
        RCData = self.numWords * [   0x0 ]
        
        hold1Word = self.hold1 / self.busWidth
        hold1Bit  = self.hold1 % self.busWidth

        RCData[hold1Word] = 1 << hold1Bit

        hold2Word = 2 + (self.hold2 / self.busWidth)
        hold2Bit  = self.hold2 %  self.busWidth

        RCData[hold2Word] = 1 << hold2Bit

        self.logger.info("RC hold1Word , hold1Bit = %i , %i" %( hold1Word,hold1Bit))
        self.logger.info("RC hold2Word , hold2Bit = %i , %i" %( hold2Word,hold2Bit))
        self.logger.info("RC array =  %i , %i %i %i " %( RCData[0] , RCData[1] ,RCData[2] ,RCData[3] ,) )
        
        return(RCData)

    def readConfigFile(self,fName):
        """Reads a configuration file with 'windows-INI' like syntax.
        Expects one section , RC , with entries hold1 , hold2
        hold1 , hold2 is which output should be active
        """
        
        self.logger.info("Reading Configuration from %s" %(fName))
        
        config = ConfigParser.SafeConfigParser()
        config.optionxform = str # stop parser from changing to lower case.
        config.read(fName)
        self.hold1 = config.getint('RC',"hold1")
        self.hold2 = config.getint('RC',"hold2")

        self.logger.info("RC register values from config file: hold1 , hold2 = %i , %i " %(self.hold1,self.hold2) )



        



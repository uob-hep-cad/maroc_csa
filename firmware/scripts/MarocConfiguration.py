# -*- coding: utf-8 -*-
#
# Python class to configure single Maroc board pc049a
#

import logging
from marocLogging import marocLogging

import MarocSC

class MarocConfiguration(object):

    def __init__(self,board,configurationFile = "marocConfig.csv" , debugLevel = logging.DEBUG):
        """Class to configure MAROC and FPGA registers for pc049a"""
    
        self.board = board # pointer to PyChips object

        self.logger = logging.getLogger(__name__)
        marocLogging(self.logger,debugLevel)

        self.slowControlObject = MarocSC.MarocSC(debugLevel=debugLevel)

        self.configurationFile = configurationFile 

        self.slowControlObject.readConfigFile(configurationFile )
                
    def configure(self):
        self.logger.info("Configuring board")

        SCData = self.slowControlObject.getWordArray() # Get data to write
        
        self.logger.debug("Slow control data = %s"%( '  , '.join([format(i,'08x') for i in SCData ]) ))

        # write to slow control output data buffer
        self.board.blockWrite("scSrDataOut",SCData)
        self.board.write("scSrCtrl" , 0x00000000)

        # set up the registers.
        for regName in list(self.slowControlObject.registers.keys()):
            regValue = self.slowControlObject.getRegisterValue(regName)
            self.logger.info("Writing %i to register %s"%( int(regValue) , regName ))
            self.board.write(regName,regValue)
            regReadValue = self.board.read(regName)
            self.logger.info("Read back %i from %s"%( int(regReadValue) , regName ))
            

#        self.logger.debug( "Resetting timestamp and trigger counters")
#        self.board.write("trigStatus",0x00000001) 

#        # Reset ADC buffer write buffer
#        self.board.write("adc0Ctrl",0x00000002)

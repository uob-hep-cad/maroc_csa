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

        self.slowControlObject = MarocSC.MarocSC()

    def configure(self):

        self.logger.info("Configuring board")
        
        self.slowControlObject.setParameterValue("DAC",[650,450])
        self.slowControlObject.setFlagValue("d1_d2",0)
        self.slowControlObject.setFlagValue("cmd_fsb_fsu",1) # Select FSU 
        self.slowControlObject.setParameterValue("mask_OR",0x3,54) # Mask hot channel
        SCData = self.slowControlObject.getWordArray() # Get data to write
        
        self.logger.debug("Slow control data = %s"%( '  , '.join([format(i,'08x') for i in SCData ]) ))

        # write to slow control output data buffer
        self.board.blockWrite("scSrDataOut",SCData)
        self.board.write("scSrCtrl" , 0x00000000)

        # set up triggers
        #triggerSource = 0x0000000D
        triggerSource = 0x00000008
        self.board.write("trigSourceSelect",triggerSource) # Set OR1,OR2 and internal triggers active

        trigSourceReadback = self.board.read("trigSourceSelect")
        self.logger.debug( "Trigger source select register = %s" % (hex(trigSourceReadback)))

        self.logger.debug( "Resetting timestamp and trigger counters")
        self.board.write("trigStatus",0x00000001) 

        # Reset ADC buffer write buffer
        self.board.write("adc0Ctrl",0x00000002)

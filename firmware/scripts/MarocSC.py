#
#
# Python class to set up MAROC-3 serial control register.
#
#
import ConfigParser

import logging

class MarocSC(object):
    """Sets up an array of 32-bit words that can be written to MAROC-3 serial slow control register via a block write to IPBus-based firmware."""

    def __init__(self,debugLevel=logging.DEBUG):

        # Data structure to store the name of each MAROC flag (as the key) and the [bit-location , default]
        # e.g. "swb_buf_1p":[183 ,1] means that flag swb_buf_1p is at position 183 and is should be set to 1 by default
        self.flagLocation = { 
            "ON/OFF_otabg":[0 ,1, "power pulsing bit for bandgap","not active on MAROC3 test board  because power pulsing pin is connected to vdd"]    ,
            "ON/OFF_dac":[1 ,1, "power pulsing bit for all DACs","not active on MAROC3 test board  because power pulsing pin is connected to vdd"]         ,
            "small_dac":[2 ,0, "to decrease the slope of DAC0 -> better accuracy","small dac OFF: threshold VTH0  min= and max=  / small dac ON: threshold VTH0 min=   and max="] ,
            "enb_outADC":[23 ,0, "wilkinson ADC parameter: enable data output","In order use the wilkinson ADC this bit should be OFF"]     ,
            "inv_startCmptGray":[24 ,0, "wilkinson ADC parameter:  the start compteur polarity switching","In order to use the wilkinson ADC should be OFF"] ,
            "ramp_8bit":[25 ,0, "wilkinson ADC parameter: ramp slope change to have quickly conversion on 8 bits","Set ON for 8-bit Wilkinson conversion"] , 
            "ramp_10bit":[26 ,0, "wilkinson ADC parameter: ramp slope change to have quickly conversion on 10 bits","Set ON for 10-bit Wilkinson conversion"] ,
            "cmd_CK_mux":[155 ,0, "Should be OFF" , ""]       ,
            "d1_d2":[156 ,1,"trigger output choice","d1_d2='0' -> trigger from FSB1 and DAC0 ;  d1_d2='1' -> trigger from FSB2 and DAC1"] , 
            "inv_discriADC":[157 ,0,"Invert ADC discriminator output","Should be OFF"] ,
            "polar_discri":[158, 0 ,"polarity of trigger output" , "polar_discri='0' ->High polarity ; polar_discri='1' -> Low polarity"],
            "Enb_tristate":[159 ,1,"enable all trigger outputs","Should be ON to see trigger outputs"]     ,
            "valid_dc_fsb2":[160 ,0,"enable FSB2 DC measurements",""] , 
            "sw_fsb2_50f":[161  ,1,"Feedback capacitor for FSB2" ,"better if ON"]   ,
            "sw_fsb2_100f":[162 ,0,"Feedback capacitor for FSB2" ,""]     ,
            "sw_fsb2_100k":[163 ,1,"Feedback resistor for FSB2" ,""] , 
            "sw_fsb2_50k":[164  ,0,"Feedback resistor for FSB2" ,""]   ,
            "valid_dc_fs":[165  ,0,"enable FSB and FSU DC measurements",""]      ,
            "cmd_fsb_fsu":[166  ,1,"Choice between FSB1 or FSU for the first discri input (with DAC0)","cmd_fsb_fsu='1'-> FSU ; cmd_fsb_fsu='0'-> FSB"] , 
            "sw_fsb1_50f":[167 ,1,"Feedback capacitor for FSB1" ,"better if ON"]   ,
            "sw_fsb1_100f":[168 ,1,"Feedback capacitor for FSB1" ,"better if ON"]     ,
            "sw_fsb1_100k":[169 ,1,"Feedback resistor for FSB1" ,""] ,
            "sw_fsb1_50k":[170 ,0,"Feedback resistor for FSB1" ,""]   ,
            "sw_fsu_100k":[171 ,1, "Feedback resistor for FSU" , ""]     ,
            "sw_fsu_50k":[172 ,1, "Feedback resistor for FSU" , ""] ,
            "sw_fsu_25k":[173 ,1, "Feedback resistor for FSU" , ""]    ,
            "sw_fsu_40f":[174 ,1, "Feedback capacitor for FSU" , "better if ON"]       ,
            "sw_fsu_20f":[175 ,1, "Feedback capacitor for FSU" , "better if ON"] ,
            "H1H2_choice":[176 ,1,"ADC wilkinson: choice between the first or the second track and hold for the input of the ADC",""]   ,
            "EN_ADC":[177 ,1,"ADC wilkinson: enable ADC conversion inside the asic ","Should be ON to enable ADC"]           ,
            "sw_ss_1200f":[178 ,1,"Feedback capacitor for Slow Shaper",""] ,
            "sw_ss_600f":[179 ,1,"Feedback capacitor for Slow Shaper",""]    ,
            "sw_ss_300f":[180 ,1,"Feedback capacitor for Slow Shaper",""]       ,
            "ON/OFF_ss":[181 ,1,"Power supply of Slow Shaper",""]    ,
            "swb_buf_2p":[182 ,1,"capacitor for the buffer before the slow shaper",""]    ,
            "swb_buf_1p":[183 ,1,"capacitor for the buffer before the slow shaper",""]       ,
            "swb_buf_500f":[184 ,1,"capacitor for the buffer before the slow shaper",""]   ,
            "swb_buf_250f":[185 ,1,"capacitor for the buffer before the slow shaper",""]  ,
            "cmd_fsb":[186 ,1,"enable signal at the FSB inputs","Should be ON if we want to use FSB1 or FSB2"]          ,
            "cmd_ss":[187 ,1,"enable signal at the SS inputs","Should be ON if we want to do charge measurement"]   ,
            "cmd_fsu":[188 ,1,"enable signal at the FSU inputs","Should be ON if we want to use FSU"]  
            } 
        
        # Data structure to store the name of each MAROC parameter (as the key) and the [parameter-location , parameter-width , default ]
        # parameter-location is the bit-location of the lowest SC bit ( most significant bit of highest indexed parameter )
        # size of parameter array is deduced from array of default values
        self.parameterLocation = {
            "DAC":[      3 , 10  , 2*[0x000,0x150], "DAC values for the discriminators. DAC[1]= second discriminator (with the fast shaper FSB2). DAC[0]=first discriminator (with the fast shaper FSB1 or FSU)","" ] , # The most significant bit of DAC2, 
            "mask_OR":[ 27 , 0   , 64*[0x0] ,"mask the discriminator outputs.","MSB of mask_OR[N] = OR2 = mask for second disriminator output ( FSB2) of channel N. LSB of mask_OR[N] = OR1 = mask for first discriminator output ( FSB1 / FSU ). Set bit ON to generate a trigger" ] ,
            "GAIN":[   189 , 9   , 64*[0x40] ,"Preamplifier gain (8-bits) and sum-enable for channels","Set sum-enable high for channel to contribute to analogue sum"],
            "Ctest_ch":[765 , 1   , 64*[0x1] ,"Enable signal in Ctest input" ,"" ]
            }

        self.numSCbits = 829   # number of bits in slow control register            
        self.numWords = 26
        self.busWidth = 32
        self.bitArray=self.numSCbits*[0]
        self.SCData = self.numWords*[0x00000000]
        self.debugLevel = debugLevel
        logging.basicConfig(level=debugLevel)
        # Call method to set up defaults...
        self.setDefaults()


    def getLocalBitArray(self):
        """Returns list of bits representing data to write to SC register. 
        ( N.B. This is the contents of the local data structure that will be transmitted to the MAROC, *NOT* what is in the MAROC)"""
        return self.bitArray

    def printLocalBitArray(self):
        """ Prints out the value of each bit in the list"""
        for bitNumber in range(0 , len(self.bitArray) ):
            print "bit %i = %i" %( bitNumber , self.bitArray[bitNumber] )

    def getLocalWordArray(self):
        """Return an array of 32-bit numbers to write to SC register. 
        ( N.B. This is the contents of the local data structure that will be transmitted to the MAROC, *NOT* what is in the MAROC)"""
        self.SCData = self.numWords*[0x00000000] # clear contents of array
        for bitNumber in range(0 , len(self.bitArray) ):
            bitNum = self.numSCbits  - bitNumber -1
            wordBitPos = bitNum % self.busWidth
            wordNum    = bitNum / self.busWidth
            logging.debug("setting bit number = %i (reversed = %i )  => bit %i of word %i to %i" %( bitNumber , bitNum , wordBitPos , wordNum, self.bitArray[bitNumber]))
            self.SCData[wordNum] += self.bitArray[bitNumber] << wordBitPos
        return self.SCData
    
    def setFlagValue(self,flagName,bitValue):
        """Write to the flag with name flagName. 
        ( Inside the code, the location of flag in the serial data stream is given by the hash flagLocation)"""
        [bitPosition , default , description, comment] = self.flagLocation[flagName]
        logging.debug("Setting flag %s , bit location %i to %i " %( flagName , bitPosition , int(bitValue) ) )
        self.bitArray[bitPosition] = bitValue

    def getFlagValue(self,flagName):
        """Read from internal data-structure the contents of flagName."""
        [bitLocation , default, description, comment ] = self.flagLocation[flagName]
        return self.bitArray[bitLocation]

    def getFlagLocations(self):
        """Return the list of flags, positions and defaults"""
        return self.flagLocation

    def setParameter(self,paramName,index,paramValue):
        """Writes to the parameter array with name paramName at index the value n"""
        [ paramLocation , paramWidth , paramDefault, description, comment ] = self.parameterLocation[paramName]
        arraySize = len(paramDefault)
        assert index < arraySize
        logging.debug("setting parameter = %s  , base location = %i , index = %i . Value(s) = %i . Number of values = %i" %( paramName , paramLocation,  index ,  int(paramValue) , arraySize) )
        #print "setting parameter = %s  , index = %i to %i . Number of values = %i" %( paramName ,  index ,  int(paramValue) , arraySize)
        logging.debug("setting parameter = %s  , index = %i to %i . Number of values = %i" %( paramName ,  index ,  int(paramValue) , arraySize))
        for paramBitPos in range(0,paramWidth):  # Loop over the bits in the parameter.
            bitValue = (int(paramValue) >> paramBitPos) & 0x00000001
            bitLocation = paramLocation+ (paramWidth*( (arraySize-1) -index)) + ( (paramWidth - 1) - paramBitPos)
            # print "value of bit %i is %i , writen to position %i" %( paramBitPos , bitValue , bitLocation)
            logging.debug("value of bit %i is %i , writen to position %i" %( paramBitPos , bitValue , bitLocation))
            self.bitArray[bitLocation] = bitValue

    def getParameter(self,paramName,index):
        """Gets parameter(index)"""
        [ paramLocation , paramWidth , default, description, comment ] = self.parameterLocation[paramName]
        arraySize = len(default)
        assert index < arraySize
        logging.debug("reading parameter = %s  , index = %i  . Number of values = %i" %( paramName ,  index  , arraySize) )
        paramValue = 0
        for paramBitPos in range(0,paramWidth):  # Loop over the bits in the parameter.
            bitLocation = paramLocation+ (paramWidth*(arraySize-index)) + (paramWidth - paramBitPos)
            bitValue = self.bitArray[bitLocation]
            paramValue = paramValue + (bitValue << paramBitPos) 
            logging.debug("value of bit %i is %i , writen to position %i" %( paramBitPos , bitValue , bitLocation))
        return paramValue

    def getParameterLocations(self):
        """Returns the list of parameters , positions, array sizes and defaults"""
        return self.parameterLocation
        
    def setDefaults(self):
        """Loop through defaults and write to data structure"""
        # First loop through the flags -
        for flagName in self.flagLocation.keys():
            [ bit , default , description , comment ] =  self.flagLocation[flagName]
            logging.debug("Setting defaults. Flag name = %s , flag location = %i , default = %i , description = %s , comment = %s" % ( flagName , bit , default , description , comment))
            self.setFlagValue(flagName,default)
        # now loop through the parameters 
        # (could be done in either order ... )
        for parameterName in self.parameterLocation.keys():
            [ bit , width , default , description , comment ] = self.parameterLocation[parameterName]
            for index in range(0, len(default)):
                self.setParameter(parameterName , index , default[index])

    def readConfigFile(self,fName):
        """Reads a configuration file with 'windows-INI' like syntax.
        Expects two sections - 
        flags , where the flag entries are ( fName: fVal ) are
        parameters , where the parameter entries are ( pName: p(1),p(2),....,p(N) . N.B. no bounds checking is done on the parameter indices, so don't add too many to the list
        """
        config = ConfigParser.SafeConfigParser()
        config.optionxform = str # stop parser from changing to lower case.
        config.read(fName)
        flags = config.items("flags")
        parameters = config.items("parameters")
        logging.debug(flags)
        logging.debug(parameters)
        # read the flags...
        for ( flag , value ) in flags:
            self.setFlagValue( flag , int(value) )
        # read the parameters
        for ( parameter , valueList ) in parameters:
            values = valueList.split(",")
            for index in range (0, len(values)):
                self.setParameter( parameter , index , values[index] )

    def writeConfigFile(self,fName):
        """Writes a configuration file with window-INI like syntax. Warning - will overwrite existing files"""
        cfgFile = open(fName,'w')
        config = ConfigParser.SafeConfigParser()
        config.optionxform = str # stop parser from changing to lower case
        config.add_section('flags')
        config.add_section('parameters')

        # Set flag values
        for flagName in self.flagLocation.keys():
            bitValue  =  self.getFlagValue(flagName)
            logging.debug("Setting Flag name %s in config file to %i " %(flagName,bitValue))
            config.set('flags',flagName,str(bitValue))

        #for paramName in self.paramLocation.keys():
        #    paramValues = self.getParameters

        # Write out configuration
        config.write(cfgFile)
        cfgFile.close()

#    def configure(self,board):
#        """Writes contents of local data-structure to MAROC slow control.
#        board      - a PyChips object pointing to correct MAROC board"""
#
#        SCData = self.getLocalWordArray()
#        # write data into buffer
#        board.blockWrite("scSrDataOut",SCData)
#        # trigger writing of buffer to slow control shift register
#        board.write("scSrCtrl" , 0x00000001)


        



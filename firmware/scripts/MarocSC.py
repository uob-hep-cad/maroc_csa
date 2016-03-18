#
#
# Python class to set up MAROC-3 serial control register.
#
#
import ConfigParser

import logging
from marocLogging import marocLogging

from itertools import imap

class MarocSC(object):
    """Sets up an array of 32-bit words that can be written to MAROC-3 serial slow control register via a block write to IPBus-based firmware."""

    def __init__(self,debugLevel=logging.DEBUG):

        # Data structure to store the name of each MAROC flag (as the key) and the [bit-location , default, description, comment]
        # e.g. "swb_buf_1p":[183 ,1] means that flag swb_buf_1p is at position 183 and is should be set to 1 by default
        self.flagLocation = { 
            'ON/OFF_otabg':[0 ,1, 'power pulsing bit for bandgap','not active on MAROC3 test board  because power pulsing pin is connected to vdd']    ,
            'ON/OFF_dac':[1 ,1, 'power pulsing bit for all DACs','not active on MAROC3 test board  because power pulsing pin is connected to vdd']         ,
            'small_dac':[2 ,0, 'to decrease the slope of DAC0 -> better accuracy','small dac OFF: threshold VTH0  min= and max=  / small dac ON: threshold VTH0 min=   and max='] ,
            'enb_outADC':[23 ,0, 'wilkinson ADC parameter: enable data output','In order use the wilkinson ADC this bit should be OFF']     ,
            'inv_startCmptGray':[24 ,0, 'wilkinson ADC parameter:  the start compteur polarity switching','In order to use the wilkinson ADC should be OFF'] ,
            'ramp_8bit':[25 ,0, 'wilkinson ADC parameter: ramp slope change to have quickly conversion on 8 bits','Set ON for 8-bit Wilkinson conversion'] , 
            'ramp_10bit':[26 ,0, 'wilkinson ADC parameter: ramp slope change to have quickly conversion on 10 bits','Set ON for 10-bit Wilkinson conversion'] ,
            'cmd_CK_mux':[155 ,0, 'Should be OFF' , '']       ,
            'd1_d2':[156 ,1,'trigger output choice','d1_d2=0 -> trigger from FSB1 and DAC0 ;  d1_d2=1 -> trigger from FSB2 and DAC1'] , 
            'inv_discriADC':[157 ,0,'Invert ADC discriminator output','Should be OFF'] ,
            'polar_discri':[158, 0 ,'polarity of trigger output' , 'polar_discri=0 ->High polarity ; polar_discri=1 -> Low polarity'],
            'Enb_tristate':[159 ,1,'enable all trigger outputs','Should be ON to see trigger outputs']     ,
            'valid_dc_fsb2':[160 ,0,'enable FSB2 DC measurements',''] , 
            'sw_fsb2_50f':[161  ,1,'Feedback capacitor for FSB2' ,'better if ON']   ,
            'sw_fsb2_100f':[162 ,0,'Feedback capacitor for FSB2' ,'']     ,
            'sw_fsb2_100k':[163 ,1,'Feedback resistor for FSB2' ,''] , 
            'sw_fsb2_50k':[164  ,0,'Feedback resistor for FSB2' ,'']   ,
            'valid_dc_fs':[165  ,0,'enable FSB and FSU DC measurements','']      ,
            'cmd_fsb_fsu':[166  ,1,'Choice between FSB1 or FSU for the first discri input (with DAC0)','cmd_fsb_fsu=1-> FSU ; cmd_fsb_fsu=0-> FSB'] , 
            'sw_fsb1_50f':[167 ,1,'Feedback capacitor for FSB1' ,'better if ON']   ,
            'sw_fsb1_100f':[168 ,1,'Feedback capacitor for FSB1' ,'better if ON']     ,
            'sw_fsb1_100k':[169 ,1,'Feedback resistor for FSB1' ,''] ,
            'sw_fsb1_50k':[170 ,0,'Feedback resistor for FSB1' ,'']   ,
            'sw_fsu_100k':[171 ,1, 'Feedback resistor for FSU' , '']     ,
            'sw_fsu_50k':[172 ,1, 'Feedback resistor for FSU' , ''] ,
            'sw_fsu_25k':[173 ,1, 'Feedback resistor for FSU' , '']    ,
            'sw_fsu_40f':[174 ,1, 'Feedback capacitor for FSU' , 'better if ON']       ,
            'sw_fsu_20f':[175 ,1, 'Feedback capacitor for FSU' , 'better if ON'] ,
            'H1H2_choice':[176 ,1,'ADC wilkinson: choice between the first or the second track and hold for the input of the ADC','']   ,
            'EN_ADC':[177 ,1,'ADC wilkinson: enable ADC conversion inside the asic ','Should be ON to enable ADC']           ,
            'sw_ss_1200f':[178 ,1,'Feedback capacitor for Slow Shaper',''] ,
            'sw_ss_600f':[179 ,1,'Feedback capacitor for Slow Shaper','']    ,
            'sw_ss_300f':[180 ,1,'Feedback capacitor for Slow Shaper','']       ,
            'ON/OFF_ss':[181 ,1,'Power supply of Slow Shaper','']    ,
            'swb_buf_2p':[182 ,1,'capacitor for the buffer before the slow shaper','']    ,
            'swb_buf_1p':[183 ,1,'capacitor for the buffer before the slow shaper','']       ,
            'swb_buf_500f':[184 ,1,'capacitor for the buffer before the slow shaper','']   ,
            'swb_buf_250f':[185 ,1,'capacitor for the buffer before the slow shaper','']  ,
            'cmd_fsb':[186 ,1,'enable signal at the FSB inputs','Should be ON if we want to use FSB1 or FSB2']          ,
            'cmd_fsu':[188 ,1,'enable signal at the FSU inputs','Should be ON if we want to use FSU']  ,
            'cmd_ss':[187 ,1,'enable signal at the SS inputs','Should be ON if we want to do charge measurement']   
            } 

        # Copy default flags onto the end of each flag
        # structure = [bit-location , default, description, comment, currentValue]
        for flagName in self.flagLocation.keys():
            self.flagLocation[flagName].append(self.flagLocation[flagName][1])
            
         
        # Data structure to store the name of each MAROC parameter (as the key) and the [parameter-location , parameter-width , default , description , comment ]
        # parameter-location is the bit-location of the lowest SC bit ( most significant bit of highest indexed parameter )
        # size of parameter array is deduced from array of default values
        self.parameterLocation = {
            'DAC':[      3 , 10  , [0x000,0x000], 'DAC values for the discriminators. DAC[1]= second discriminator (with the fast shaper FSB2). DAC[0]=first discriminator (with the fast shaper FSB1 or FSU)','' ] , # The most significant bit of DAC2, 
            'mask_OR':[ 27 , 2   , 64*[0x0] ,'mask the discriminator outputs.','MSB of mask_OR[N] = OR2 = mask for second disriminator output ( FSB2) of channel N. LSB of mask_OR[N] = OR1 = mask for first discriminator output ( FSB1 / FSU ). Set bit OFF to generate a trigger (ON to mask trigger)' ] ,
            'GAIN':[   189 , 9   , 64*[0x40] ,'Preamplifier gain (8-bits) and sum-enable for channels','Set sum-enable high for channel to contribute to analogue sum'],
            'Ctest_ch':[765 , 1   , 64*[0x1] ,'Enable signal in Ctest input' ,'' ]
            }

        # Copy default parameters into dictionary
        # parameterLocation = [parameter-location , parameter-width , default , description , comment , currentValue(s) ]
        for paramName in self.parameterLocation.keys():
            self.parameterLocation[paramName].append(self.parameterLocation[paramName][2])

        # Data structure to store the names of FPGA registers to write into. The key name is the register name value is [default,description,comment]
        self.registers = {
            'trigSourceSelect':[ 0x0000000D , 'Set source of triggers.' , 'There can be more than one trigger input active at the same time. 0xD turns on OR1 , OR2 and internal triggers']  ,
            'trigHold1Delay':[ 0x00000000 , 'Set delay between trigger and Hold1 being asserted' , 'In units of fastClock ticks = 8ns']  
            }
        # Copy default register values into dictionary
        for registerName in self.registers.keys():
            self.registers[registerName].append(self.registers[registerName][0])
 
        
        self.numSCbits = 829   # number of bits in slow control register            
        self.numWords = 26
        self.busWidth = 32
        self.debugLevel = debugLevel
        #logging.basicConfig(format='%(levelname)s:MarocSC:%(message)s',level=debugLevel)
        self.logger = logging.getLogger(__name__)
        marocLogging(self.logger,debugLevel)

        #print "flags = " , self.flagLocation
        #print "parameters = " , self.parameterLocation
        


    def getBitArray(self):
        """Returns list of bits representing data to write to SC register. 
        ( N.B. This is the contents of the local data structure that will be transmitted to the MAROC, *NOT* what is in the MAROC)"""
        bitArray = (self.numSCbits)*[0]
        
        for flagName in self.flagLocation.keys(): # Loop through the flags
            [ bitPosition , default , description , comment , bitValue ] =  self.flagLocation[flagName]
            self.logger.debug("Copying flag to bit-array. Flag name = %s , flag location = %i , default = %i , value = %i , description = %s , comment = %s" % ( flagName , bitPosition , default , bitValue , description , comment))
            bitArray[bitPosition] = bitValue
        
        for paramName in self.parameterLocation.keys(): # Loop through the parameters 
            [ paramLocation , paramWidth , paramDefault , description , comment , paramValue ] = self.parameterLocation[paramName]

            for index in range(0, len(paramDefault)): # Loop over the array values for each parameter
                arraySize = len(paramDefault)
                assert index < arraySize
                self.logger.debug("setting parameter = %s  , base location = %i , index = %i . Value(s) = %i . Number of values = %i" %( paramName , paramLocation,  index ,  int(paramValue[index]) , arraySize) )
                for paramBitPos in range(0,paramWidth):  # Loop over the bits in the parameter.
                    bitValue = (int(paramValue[index]) >> paramBitPos) & 0x00000001
                    bitLocation = paramLocation+ (paramWidth*( (arraySize-1) -index)) + ( (paramWidth - 1) - paramBitPos)
                    # print "value of bit %i is %i , writen to position %i" %( paramBitPos , bitValue , bitLocation)
                    self.logger.debug("value of bit %i is %i , writen to position %i" %( paramBitPos , bitValue , bitLocation))
                    bitArray[bitLocation] = bitValue
            
        #        self.setParameter(paramName , index , default[index])

        return bitArray

    def printBitArray(self):
        """ Prints out the value of each bit in the list"""
        bitArray = self.getBitArray()
        for bitNumber in range(0 , len(bitArray) ):
            print "bit %i = %i" %( bitNumber , bitArray[bitNumber] )

    def getWordArray(self):
        """Return an array of 32-bit numbers to write to SC register. 
        ( N.B. This is the contents of the local data structure that will be transmitted to the MAROC, *NOT* what is in the MAROC)"""
        SCData = self.numWords*[0x00000000] # clear contents of array
        bitArray = self.getBitArray()
        for bitNumber in range(0 , len(bitArray) ):
            bitNum = self.numSCbits  - bitNumber -1
            wordBitPos = bitNum % self.busWidth
            wordNum    = bitNum / self.busWidth
            self.logger.debug("setting bit number = %i (reversed = %i )  => bit %i of word %i to %i" %( bitNumber , bitNum , wordBitPos , wordNum, bitArray[bitNumber]))
            SCData[wordNum] += bitArray[bitNumber] << wordBitPos
        return SCData
    
    def setFlagValue(self,flagName,bitValue):
        """Write to the flag with name flagName. 
        ( Inside the code, the location of flag in the serial data stream is given by the hash flagLocation)"""

        [bitPosition , default , description, comment , currentValue] = self.flagLocation[flagName]
        self.logger.debug("Setting flag %s , bit location %i to %i . Previous value = %i" %( flagName , bitPosition , int(bitValue) , int(currentValue) ) )
        self.flagLocation[flagName][4] = bitValue

    def getFlagValue(self,flagName):
        """Read from internal data-structure the contents of flagName."""
        return self.flagLocation[flagName][4]

    def getFlagLocations(self):
        """Return the list of flags, positions and defaults"""
        return self.flagLocation
        
    def setParameterValue(self,paramName,newParamValue,index=-1):
        """Writes to the parameter array with name paramName at index the value n"""
        [ paramLocation , paramWidth , paramDefault, description, comment ,oldParamValue] = self.parameterLocation[paramName]
        arraySize = len(paramDefault)
        assert index < arraySize
        if index<0: # if index not set ( or set to <0 ) then write all parameters at once.
            paramString = ",".join(imap(str, newParamValue))
            self.logger.debug("setting parameter array = %s  , base location = %i ,  Values = %s . Number of values = %i" %( paramName , paramLocation,   paramString , arraySize) )
            assert len(paramDefault) == len(newParamValue) # Make sure array has the correct number of entries
            self.parameterLocation[paramName][5] = newParamValue
        else:            
            self.logger.debug("setting parameter = %s  , base location = %i , index = %i . Value(s) = %i . Number of values = %i" %( paramName , paramLocation,  index ,  int(newParamValue) , arraySize) )
            self.parameterLocation[paramName][5][index] = newParamValue
        
    def getParameterValue(self,paramName):
        """Gets parameter"""
        [ paramLocation , paramWidth , default, description, comment , paramValue] = self.parameterLocation[paramName]
        arraySize = len(default)
        paramString = ",".join(imap(str, paramValue))
        self.logger.debug("reading parameter = %s  ,  Number of values = %i , values = %s " %( paramName ,  arraySize , paramString) )
        return paramValue

    def getParameterLocations(self):
        """Returns the list of parameters , positions, array sizes and defaults"""
        return self.parameterLocation

    def setRegisterValue(self,registerName,registerValue):
        """Sets value in data structure. *does not* write to registers"""
        [ registerDefault , description, comment , oldRegisterValue ] = self.registers[registerName]
        self.registers[registerName][3] = registerValue

    def getRegisterValue(self,registerName):
        return self.registers[registerName][3]

    def getRegisterValues(self):
        return self.registers
    
    def readConfigFile(self,fName):
        """Reads a configuration file with 'windows-INI' like syntax.
        Expects three sections - 
        flags , where the flag entries are ( fName: fVal ) are
        parameters , where the parameter entries are ( pName: p(1),p(2),....,p(N) . N.B. no bounds checking is done on the parameter indices, so don't add too many to the list
        registers , values to write to FPGA registers
        """
        
        self.logger.info("Reading Configuration from %s" %(fName))
        
        config = ConfigParser.SafeConfigParser()
        config.optionxform = str # stop parser from changing to lower case.
        config.read(fName)
        flags = config.items("flags")
        parameters = config.items("parameters")
        registers = config.items("registers")
        self.logger.debug(flags)
        self.logger.debug(parameters)
        self.logger.debug(registers)
        # read the flags...
        for ( flag , value ) in flags:
            self.setFlagValue( flag , int(value) )
        # read the parameters
        for ( parameter , valueList ) in parameters:
            values = valueList.split(",")
            self.setParameterValue( parameter , values , index=-1)
        # read the register values...
        for ( registerName , value ) in registers:
            self.setRegisterValue( registerName , int(value) )
            
    def writeConfigFile(self,fName):
        """Writes a configuration file with window-INI like syntax. Warning - will overwrite existing files"""
        cfgFile = open(fName,'w')
        config = ConfigParser.SafeConfigParser()
        config.optionxform = str # stop parser from changing to lower case
        config.add_section('flags')
        config.add_section('parameters')
        config.add_section('registers')

        # Set flag values
        for flagName in self.flagLocation.keys():
            bitValue  =  self.getFlagValue(flagName)
            self.logger.debug("Setting Flag name %s in config file to %i " %(flagName,bitValue))
            config.set('flags',flagName,str(bitValue))

        # set parameter values
        for paramName in self.parameterLocation.keys():
            paramValues = self.getParameterValue(paramName)
            paramString = ",".join(imap(str, paramValues))
            self.logger.debug("Setting Parameter name %s in config file to %s " %(paramName,paramString))
            config.set('parameters',paramName,paramString)

        # Set register values
        for registerName in self.registers.keys():
            registerValue  =  self.getRegisterValue(registerName)
            self.logger.debug("Setting Register name %s in config file to %i " %(registerName,registerValue))
            config.set('registers',registerName,str(registerValue))
            
        # Write out configuration
        config.write(cfgFile)
        cfgFile.close()



        



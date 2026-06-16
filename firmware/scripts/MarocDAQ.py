# -*- coding: utf-8 -*-
#
# Python class to perform basic DAQ operations on MAROC readout board.
#
# needs python 2.6

import logging
from marocLogging import marocLogging

numMaroc = 1

class MarocDAQ(object):

    def __init__(self,board,debugLevel,internalTriggers=0):
        """Class to interface to MAROC-3 via IPBus"""
        self.board = board # pointer to PyChips object
        self.internalTriggers = internalTriggers # Set to > 0 to fire internal triggers.
        self.timeStampEventSize = 12
        self.timeStampBufferSize = 512
        self.adcEventSize = 26 # size of each event
        # self.adcEventSize = 32 # size of each event in firmware that rounds up to 2^5
        self.adcBufferSize = 4096 # size of rolling buffer. Be careful - buffer size changes with firmware version.....

        self.numMaroc = 1
        self.timeStampReadPointer = 0
        self.adcReadPointer = self.numMaroc*[0]

        self.timeStampWritePointer = 0
        self.adcWritePointer = self.numMaroc*[0]

        self.logger = logging.getLogger(__name__)
        marocLogging(self.logger,debugLevel)

    def readORCounters(self):
        """Reads the number of pulses on OR1 , OR2 lines"""
        trigOR1_counters = self.board.blockRead("trigOR1_0_Counter",5)
        trigOR2_counters = self.board.blockRead("trigOR2_0_Counter",5)
        return [ trigOR1_counters , trigOR2_counters ]

    # --------------------------------------------------------------------------------------------------------------
    def readTimeStampData(self):
        """Reads the whole timestamp buffer, takes the portion after the read pointer and spits it into events.
        It can cope with wrap-round of circular buffer. Returns an array of 32-bit integers"""
        eventData = []
        # get current write pointer
        self.timeStampWritePointer = self.board.read("trigDPRWritePointer")
        # read out whole buffer
        timeStampData = self.board.blockRead("trigTimestampBuffer",
                                            self.timeStampBufferSize  )
        self.logger.debug( "Timestamp Data = \n%s"%( '  , '.join([format(i,'08x') for i in timeStampData ]) ))
        timeStampEventNumber = timeStampData[ self.timeStampReadPointer ]
        self.logger.debug("Event number from timestamp data  = %i " %(timeStampEventNumber) )
        self.logger.debug("Timestamp read , write pointers = %i , %i " %(self.timeStampReadPointer , self.timeStampWritePointer) )
        if (self.timeStampWritePointer  >= self.timeStampReadPointer ):
            self.logger.debug("No pointer wrap round")
        else:
            # First cope with data from readpointer up to end of buffer
            self.logger.debug("Pointer has wrapped round")

            while ( (self.timeStampReadPointer+self.timeStampEventSize)<self.timeStampBufferSize):
                boardData = timeStampData[ self.timeStampReadPointer:(self.timeStampReadPointer+self.timeStampEventSize)]
                self.timeStampReadPointer += self.timeStampEventSize
                self.logger.debug("self.timeStampReadPointer = %i " %( self.timeStampReadPointer) )
                #print boardData
                eventData.append(boardData)
            
            # glue together the data that wraps round end of buffer
            boardData = timeStampData[ self.timeStampReadPointer: ]
            wordsRead = self.timeStampBufferSize - self.timeStampReadPointer
            self.logger.debug("read pointer just before gluing %i" %(  self.timeStampReadPointer))
            self.logger.debug( "words read at top of buffer = %s" %( wordsRead))
            self.timeStampReadPointer = self.timeStampEventSize - wordsRead
            self.logger.debug( "read pointer set to %i " %( self.timeStampReadPointer))
            boardData = boardData + timeStampData[0:self.timeStampReadPointer]
            self.logger.debug( "glued event data = %s"%( "  ,".join([format(i,'08x') for i in boardData ]) ))
            eventData.append(boardData)

        # Now pack the non wrap-round data into an event structure.
        while ( (self.timeStampReadPointer+self.timeStampEventSize)<=self.timeStampWritePointer):
            boardData = timeStampData[ self.timeStampReadPointer:(self.timeStampReadPointer+self.timeStampEventSize)]
            self.timeStampReadPointer = self.timeStampReadPointer + self.timeStampEventSize
            self.logger.debug( "readPointer = %i " %( self.timeStampReadPointer))
            #print boardData
            eventData.append(boardData)

        return eventData    

    # --------------------------------------------------------------------------------------------------------------
        
    def readADCData(self):
        """Reads the whole ADC buffer for a MAROC, takes the portion after the read pointer and spits it into events.
        It can cope with wrap-round of circular buffer. Returns an array of arrays of 32-bit integers. If self.internalTriggers = N ( N>0) then fires internal trigger N times"""

        for internalTrigger in range(self.internalTriggers):
            self.logger.info("Firing internal trigger , number %i" % internalTrigger )
            self.board.write("trigManualTrigger", 1 )

        # We only have one maroc per board in this type of hardware....
        marocNumber = 0

        eventData = []
        writePointerName= 'adc'+format(marocNumber,'1d')+'WritePointer'
        dataName= 'adc'+format(marocNumber,'1d')+'Data'

        self.logger.debug("Reading ADC data read , write pointers = %i , %i " %(self.adcReadPointer[marocNumber] , self.adcWritePointer[marocNumber]) )
        
        # get current write pointer
        self.adcWritePointer[marocNumber] = self.board.read(writePointerName)
        # read out whole buffer
        adcData = self.board.blockRead(dataName,self.adcBufferSize  )
        self.logger.debug( "Adc Data = \n%s"%( '  , '.join([format(i,'08x') for i in adcData ]) ))
        adcEventNumber = adcData[ self.adcReadPointer[marocNumber] ]
        self.logger.debug("Event number from adc data  = %i " %(adcEventNumber) )

        if (self.adcWritePointer[marocNumber]  >= self.adcReadPointer[marocNumber] ):
            self.logger.debug("No pointer wrap round")
        else:
            # First cope with data from readpointer up to end of buffer
            self.logger.debug("Pointer has wrapped round")

            while ( (self.adcReadPointer[marocNumber]+self.adcEventSize)<self.adcBufferSize):
                boardData = adcData[ self.adcReadPointer[marocNumber]:(self.adcReadPointer[marocNumber]+self.adcEventSize)]
                self.adcReadPointer[marocNumber] += self.adcEventSize
                self.logger.debug("self.adcReadPointer[marocNumber] = %i " %( self.adcReadPointer[marocNumber]) )
                #print boardData
                eventData.append(boardData)
            
            # glue together the data that wraps round end of buffer
            boardData = adcData[ self.adcReadPointer[marocNumber]: ]
            wordsRead = self.adcBufferSize - self.adcReadPointer[marocNumber]
            self.logger.debug("read pointer just before gluing %i" %(  self.adcReadPointer[marocNumber]))
            self.logger.debug( "words read at top of buffer = %s" %( wordsRead))
            self.adcReadPointer[marocNumber] = self.adcEventSize - wordsRead
            self.logger.debug( "read pointer set to %i " %( self.adcReadPointer[marocNumber]))
            boardData = boardData + adcData[0:self.adcReadPointer[marocNumber]]
            self.logger.debug( "glued event data = %s"%( "  ,".join([format(i,'08x') for i in boardData ]) ))
            eventData.append(boardData)

        # Now pack the non wrap-round data into an event structure.
        while ( (self.adcReadPointer[marocNumber]+self.adcEventSize)<=self.adcWritePointer[marocNumber]):
            boardData = adcData[ self.adcReadPointer[marocNumber]:(self.adcReadPointer[marocNumber]+self.adcEventSize)]
            self.adcReadPointer[marocNumber] = self.adcReadPointer[marocNumber] + self.adcEventSize
            self.logger.debug( "readPointer = %i " %( self.adcReadPointer[marocNumber]))
            #print boardData
            eventData.append(boardData)

        return eventData

    def resetADCPointers(self):
        """Resets read and write pointers. Hopefully doesn't reset event counter ...."""
        self.logger.info( "Resetting ADC data read and write pointers")
        self.board.write("adc0Ctrl",0x00000002)
        self.adcReadPointer = self.numMaroc*[0]

    def resetCounters(self):
        """Reset timestamp and trigger counters"""
        self.logger.info( "Resetting timestamp and trigger counters")
        self.board.write("trigStatus",0x00000001) 

    def decodeADCData(self,adcEventData):
        """Takes data from a single ADC, unpacks it into 12-bit words, performs Gray coding and returns an array of 64-ADC values.
        *** NB. This doesn't seem to work correctly at the moment ****"""

        def grayToBinary(num):
            for shift in [1,2,4,8,16]: # assume 32-bit numbers
                num ^= num >> shift
            return num

        def reverseBits(x,width):
            return int(bin(x)[2:].zfill(width)[::-1], 2)
    
        adcValues = []
        nBits=12
        busWidth = 32
        nADC = 64
        assert len(adcEventData) == 26
        adcEventNumber=adcEventData[0]
        adcTimeStamp=adcEventData[1]
        adcData = adcEventData[2:] # strip off event number and timestamp
        for adcNumber in range(0 , nADC) :
            lowBit = adcNumber*nBits
            lowWord = lowBit /busWidth
            lowBitPos = lowBit % busWidth
	
            if adcNumber > (nADC-3):
                longWord = adcData[lowWord]
            else:
                longWord = adcData[lowWord] + (adcData[lowWord+1] << busWidth)

            adcValue = 0x0FFF & (longWord >> lowBitPos)
            
            adcValues.append(grayToBinary(adcValue))
            
            print("nADC, lowBit , lowWord , lowBitPos , hex(longWord) , hex(adcValue), hex(grey) , hex(reverse-gray)" , adcNumber , lowBit , lowWord , lowBitPos , format(longWord,'016x') , format(adcValue,'03x') , format(grayToBinary(adcValue),'03x'), format(grayToBinary(reverseBits(adcValue,12)),'03x'))
        return adcValues
        
        

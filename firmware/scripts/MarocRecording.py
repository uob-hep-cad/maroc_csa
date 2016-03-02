#
# Python class to book histograms for MAROC data.
#


from ROOT import TFile, TTree
from ROOT import gROOT

import logging
from marocLogging import marocLogging

class MarocRecording(object):

    def __init__(self, fileName="marocData.root" , debugLevel=logging.DEBUG ):
        """Class to save MAROC data in ROOT TTree"""
	self.logger = logging.getLogger(__name__)
        marocLogging(self.logger,debugLevel)

        self.logger.info("Opening ROOT file %s"%(fileName))

        self.fileName = fileName
        self.fileHandle = TFile( fileName, 'RECREATE' )

        gROOT.ProcessLine(
            "struct ADCStruct {\
            UInt_t     fMarocEventNumber;\
            UInt_t     fMarocTimeStamp;\
            UShort_t  fMarocAdcData[64];\
            };" );

        from ROOT import ADCStruct
        self.adcStruct = ADCStruct()

        # Create a root "tree"
        self.rootTree = TTree( 'T', 'Maroc ADC Data' )

        self.rootTree.Branch( 'marocEventHeader'  , self.adcStruct  , "EventNumber/I:TimeStamp/I:ADCData[64]/s")
        
    def writeEvent( self, eventNumber, timeStamp , adcData ):
        """Write an event to ROOT file"""

        # copy data into ROOT data-structure
        # This is a Nasty, Nasty hack. Improve when possible. This is just copying data.....
        
        self.adcStruct.fMarocEventNumber = eventNumber
        self.adcStruct.fMarocTimeStamp    = timeStamp
        for idx in range(64):
            self.adcStruct.fMarocAdcData[idx] = adcData[idx]

        self.logger.debug("event number, timestamp = %i %i "%(self.adcStruct.fMarocEventNumber , self.adcStruct.fMarocTimeStamp))
        
        self.rootTree.Fill()


    def closeFile( self ):
        """Flush data to file and close file"""
        
        self.logger.info("Closing ROOT file %s"%(self.fileName))
        self.fileHandle.Write()
        self.fileHandle.Close()
        

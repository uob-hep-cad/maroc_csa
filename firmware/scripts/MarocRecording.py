#
# Python class to book histograms for MAROC data.
#


from ROOT import TFile, TTree
from array import array

from time import sleep , time

import logging
from marocLogging import marocLogging

from array import array

class MarocRecording(object):

    def __init__(self, fileName="marocData.root" , debugLevel=logging.DEBUG ):
        """Class to save MAROC data in ROOT TTree"""
	self.logger = logging.getLogger(__name__)
        marocLogging(self.logger,debugLevel)

        self.logger.info("Opening ROOT file %s"%(fileName))

        self.fileName = fileName
        self.fileHandle = TFile( fileName, 'RECREATE' )
        
        # Create a root "tree"
        self.rootTree = TTree( 'T', 'Maroc ADC Data' )

        self.eventNumber = array( 'l' , [0] )
        self.timeStamp   = array( 'l' , [0] )
        self.adcData     = array( 's' , self.nADC*[0] )
        
        # create a branch for each piece of data
        tree.Branch( 'marocEventNumber'  , self.eventNumber  , "EventNumber/l") 
        tree.Branch( 'marocTimeStamp'    , self.timeStamp    , "TimeStamp/l")
        tree.Branch( 'marcoADCData'      , self.adcData      , "ADCData[64]/s")
        
    def writeEvent( self, eventNumber, timeStamp , ADCData ):
        """Write an event to ROOT file"""
        self.eventNumber = eventNumber
        self.timeStamp = timeStamp
        self.adcData = ADCData

        self.rootTree.Fill()
        self.fileHandle.Write()


    def closeFile( self ):
        
        self.logger.info("Closing ROOT file %s"%(self.fileName))
        self.fileHandle.Close()
        

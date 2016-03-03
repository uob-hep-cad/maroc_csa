#
# Python class to book histograms for MAROC data.
#


from ROOT import TCanvas, TF1 , TH1F , gRandom , gBenchmark 

from time import sleep , time

from math import sqrt

import logging
from marocLogging import marocLogging

class MarocHistograms(object):

    def __init__(self,nBits=12, nPlots=64, nPlotsPerCanvas=4 , histoColour = 42 , histoUpdateInterval = 2.0 , debugLevel=logging.DEBUG ):
        """Class to book ROOT Histograms to store MAROC data"""
        self.nBits=nBits
        self.nPlots=nPlots
        self.nPlotsPerCanvas = nPlotsPerCanvas
        self.debugLevel = debugLevel
        self.histoColour = histoColour
        self.canvases = []
        self.histograms = []
        self.canvasNames = []
        self.canvasTitles = []
        self.canvasList = []
        self.histosLastUpdated = time()
        self.histoUpdateInterval = histoUpdateInterval
        self.logger = logging.getLogger(__name__)
        marocLogging(self.logger,debugLevel)

    def createHistograms(self): #canvases , histograms , nBits , nPlots , nPlotsPerCanvas , debugLevel):
        """Creates a set of ROOT histograms on several different canvasses. Number of canvasses, number of bins etc. taken from arguments"""
        
        assert(self.nPlots%self.nPlotsPerCanvas == 0),"Number of plots per canvas must be a factor of number-of-plots"
        nCanvas = self.nPlots/self.nPlotsPerCanvas
        nPlotsPerDirection = int(sqrt(self.nPlotsPerCanvas))

        nBins = 2**self.nBits

        self.canvasNames = [ "c%s"%canvas for canvas in range(nCanvas) ]
        self.canvasTitles = [ "ADC Value for Channels %s - %s"%(canvas*self.nPlotsPerCanvas , (canvas+1)*self.nPlotsPerCanvas -1) for canvas in range(nCanvas) ]

        #print self.canvasNames
        #print self.canvasTitles

        self.canvasList = [ TCanvas(self.canvasNames[chan],self.canvasTitles[chan],600,400) for chan in range(nCanvas) ]

        self.histograms = []

        # sorry, this next bit isn't very Pythonesque
        for canvasIndex in range(nCanvas):

            canvas = self.canvasList[canvasIndex]
            
            canvas.cd(0) # change to current canvas
            canvas.Divide(nPlotsPerDirection,nPlotsPerDirection)

            for plotIndex in range(self.nPlotsPerCanvas):

                plot = canvasIndex*self.nPlotsPerCanvas + plotIndex # look the other way please....

                self.logger.debug("Booking histogram. Canvas , plot within canvas, plot = %i %i %i "%( canvasIndex , plotIndex , plot))

                canvas.cd(plotIndex+1) # Change current pad. (plotIndex counts from 0. Root expects count from 1 (0 is the parent))

                canvas.SetGrid()

                histo = TH1F("chan%s"%plot,"ADC Counts for channel %s"%plot,nBins,-0.5,nBins-0.5)
                histo.SetFillColor(self.histoColour)

                histo.Draw("elp")
                canvas.Update()

                self.histograms.append( histo )


    def fillHistograms( self, eventNumber, timeStamp , ADCData ):

        assert(len(ADCData) == self.nPlots) , "Number of elements in ADCData array must match number of ADCs in MAROC ..."

        self.logger.debug("Histogramming data = \n%s"%( '  , '.join([format(i,'08x') for i in ADCData ]) ))

        for ADCIndex in range(0,len(ADCData)):
            self.histograms[ADCIndex].Fill(ADCData[ADCIndex])

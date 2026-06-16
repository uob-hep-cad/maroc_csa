
# Test of ROOT updating histograms.

# hsum1.C ( using Root interpreter ) takes 7.1 seconds for 100,000 fills and 200 updates (using gBenchmark).
# hsum.py takes 4.9s (using time).


from ROOT import TCanvas, TF1 , TH1F , gRandom , gBenchmark 

from time import sleep

from math import sqrt

def hsum():

    nPlots=64
    nPlotsPerCanvas = 4
    assert(nPlots%nPlotsPerCanvas == 0),"Number of plots per canvas must be a factor of number-of-plots"
    nCanvas = nPlots/nPlotsPerCanvas
    nPlotsPerDirection = int(sqrt(nPlotsPerCanvas))

    nBits = 12 # number of bits in MAROC ADC
    nBins = 2**nBits
    histoColour = 42

    canvasNames = [ "c%s"%canvas for canvas in range(nCanvas) ]
    canvasTitles = [ "ADC Value for Channels %s - %s"%(canvas*nPlotsPerCanvas , (canvas+1)*nPlotsPerCanvas -1) for canvas in range(nCanvas) ]

    print(canvasNames)
    print(canvasTitles)

    canvasList = [ TCanvas(canvasNames[chan],canvasTitles[chan],200,10,600,400) for chan in range(nCanvas) ]

    histograms = []

    # sorry, this next bit isn't very Pythonesque
    for canvasIndex in range(nCanvas):

        canvas = canvasList[canvasIndex]

        canvas.cd(0) # change to current canvas
        canvas.Divide(nPlotsPerDirection,nPlotsPerDirection)

        for plotIndex in range(nPlotsPerCanvas):

            plot = canvasIndex*nPlotsPerCanvas + plotIndex # look the other way please....

            print(canvasIndex , plotIndex , plot)

            canvas.cd(plotIndex+1) # Change current pad. (plotIndex counts from 0. Root expects count from 1 (0 is the parent))

            canvas.SetGrid()

            histo = TH1F("chan%s"%plot,"ADC Counts for channel %s"%plot,nBins,-0.5,nBins-0.5)
            histo.SetFillColor(histoColour)

            histo.Draw("same")
            canvas.Update()

            histograms.append( histo )



    s1 = histograms[0]
    c1 = canvasList[0]
    c1.cd(1)


    gRandom.SetSeed()

    kUPDATE = 500

    for i in range (0,100000):

        xs1   = gRandom.Gaus(nBins/2,nBins/10)

        s1.Fill(xs1,0.3)


        if (i and ((i%kUPDATE) == 0) ):

#           if (i == kUPDATE):

#                s1.Draw("same")
#                c1.Update()

        

            c1.Modified()
            c1.Update()

    c1.Modified()
    gBenchmark.Show("hsum")

    sleep(100)

hsum()

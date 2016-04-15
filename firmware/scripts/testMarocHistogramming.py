#
# trivial test of MarocRecording class

import MarocHistograms

mr = MarocHistograms.MarocHistograms()

nADC = 64
eventNumber  = 1
timeStamp = 10
adcData = nADC*[100]

mr.createHistograms()


mr.fillHistograms(eventNumber, timeStamp , adcData)

eventNumber  = 3
timeStamp = 20
adcData = nADC*[200]

mr.fillHistograms(eventNumber, timeStamp , adcData)

eventNumber  = 5
timeStamp = 40
adcData = nADC*[300]

mr.fillHistograms(eventNumber, timeStamp , adcData)

eventNumber  = 10
timeStamp = 50
adcData = nADC*[300]

mr.fillHistograms(eventNumber, timeStamp , adcData)


#
# Script to exercise MAROC Timestamp
#

import sys
import time
from optparse import OptionParser
import csv

from PyChipsUser import *

parser = OptionParser()
parser.add_option("-f", dest = 'ipAddress1' , default="192.168.200.208")
parser.add_option("-s", dest = 'ipAddress2' , default="192.168.200.224")
#parser.add_option("-f", dest = 'ipAddress1' , default="192.168.200.16")
#parser.add_option("-s", dest = 'ipAddress2' , default="192.168.200.32")
parser.add_option("-a", dest = 'boardAddressTable' , default="./fiveMarocAddrTable.txt")

parser.add_option("-o", dest = 'outputFile' , default = 'marocTimeStamps.dat' )

parser.add_option("-n" , dest = 'numTriggers' , default = 600 )



(options, args) = parser.parse_args()

csvfile = open( options.outputFile , 'w' )

print "IP addresses = " + options.ipAddress1 , " , " , options.ipAddress2
print "Board address table " + options.boardAddressTable
        
bAddrTab = AddressTable(options.boardAddressTable)

boards = [ ChipsBusUdp(bAddrTab,options.ipAddress1,50001) , ChipsBusUdp(bAddrTab,options.ipAddress2,50001) ]

firmwareIDs=[boards[0].read("FirmwareId") , boards[1].read("FirmwareId") ]

print "Firmware IDs = " , hex(firmwareIDs[0]) , hex(firmwareIDs[1])  

# reset pointers etc.
print "Resetting pointers"
boards[0].write("controlReg",0xFFFF)
boards[1].write("controlReg",0xFFFF)

#sleepVal = 0.05
#print "Sleeping for " , sleepVal , " seconds"
#time.sleep(sleepVal)

SOFTWARE=0x01
HDMI=    0x02
OR1=     0x04
OR2=     0x08
OR1N=    0x10
OR2N=    0x20
GPIO=    0x40

#triggerSourceMask = ( SOFTWARE | OR1 | OR2 )  # software and or1, or2 triggers active
triggerSourceMask = ( GPIO )  # software and or1, or2 triggers active
boards[0].write("trigSourceSelect",triggerSourceMask) # select trigger source()s
boards[1].write("trigSourceSelect",triggerSourceMask) # select trigger source(s)
trigSource = [ boards[0].read("trigSourceSelect") , boards[0].read("trigSourceSelect") ]
print "Trigger source select register = " , hex(trigSource[0]) , hex(trigSource[1])

# write to mask register
maskval = [ boards[0].read("mask") ,  boards[1].read("mask") ] 
print "MAROC Mask = ", hex(maskval[0]) ,hex(maskval[1]) 



internalTriggers = 0

readPointers = [0,0]

eventNumbers = [0,0]

eventData = [ [] , []]

timeStampEventSize = 12
timeStampBufferSize = 512

for iTrig in range(0, int(options.numTriggers) ):
    
    if internalTriggers:
        print "Firing manual trigger"
        boards[0].write("trigManualTrigger",0x00000001)
        boards[1].write("trigManualTrigger",0x00000001)

    for iBoard in range(len(boards)):  

        print "Reading data for trigger , board = " , iTrig , iBoard

        trigConversionCount = boards[iBoard].read("trigConversionCount")
        trigDPRWritePointer = boards[iBoard].read("trigDPRWritePointer")
        
        timeStampData = boards[iBoard].blockRead("trigTimestampBuffer", timeStampBufferSize  )
        #print "Timestamp data (entire buffer)= " , timeStampData
                              
        print "                   Loop number = " , iTrig
        print "Trigger Number (from trigConversionCount) = " , trigConversionCount
        print "DPR write pointer ( trigDPRWritePointer ) = " , trigDPRWritePointer

        trigOR1_0_Counter = boards[iBoard].read("trigOR1_0_Counter")
        print "trigOR1_0_Counter = " , trigOR1_0_Counter
        trigOR1_1_Counter = boards[iBoard].read("trigOR1_1_Counter")
        print "trigOR1_1_Counter = " , trigOR1_1_Counter
        trigOR1_2_Counter = boards[iBoard].read("trigOR1_2_Counter")
        print "trigOR1_2_Counter = " , trigOR1_2_Counter
        trigOR1_3_Counter = boards[iBoard].read("trigOR1_3_Counter")
        print "trigOR1_3_Counter = " , trigOR1_3_Counter
        trigOR1_4_Counter = boards[iBoard].read("trigOR1_4_Counter")
        print "trigOR1_4_Counter = " , trigOR1_4_Counter

        trigOR2_0_Counter = boards[iBoard].read("trigOR2_0_Counter")
        print "trigOR2_0_Counter = " , trigOR2_0_Counter
        trigOR2_1_Counter = boards[iBoard].read("trigOR2_1_Counter")
        print "trigOR2_1_Counter = " , trigOR2_1_Counter
        trigOR2_2_Counter = boards[iBoard].read("trigOR2_2_Counter")
        print "trigOR2_2_Counter = " , trigOR2_2_Counter
        trigOR2_3_Counter = boards[iBoard].read("trigOR2_3_Counter")
        print "trigOR2_3_Counter = " , trigOR2_3_Counter
        trigOR2_4_Counter = boards[iBoard].read("trigOR2_4_Counter")
        print "trigOR2_4_Counter = " , trigOR2_4_Counter



        eventNumbers[iBoard] = timeStampData[ readPointers[iBoard] ] 

        print "Event number from board , iBoard  = " , eventNumbers[iBoard]

        if (trigDPRWritePointer >= readPointers[iBoard]):
            print "No pointer wrap round"
        else:
            print "Pointer has wrapped round"

            while ( (readPointers[iBoard]+timeStampEventSize)<timeStampBufferSize):
                boardData = timeStampData[ readPointers[iBoard]:(readPointers[iBoard]+timeStampEventSize)]
                readPointers[iBoard] = readPointers[iBoard] + timeStampEventSize
                print "timeStampEventSize = " , timeStampEventSize
                #print boardData
                eventData[iBoard].append(boardData)
            
            # glue together the data that wraps round end of buffer
            boardData = timeStampData[ readPointers[iBoard]: ]
            wordsRead = timeStampBufferSize - readPointers[iBoard]
            print "read pointer just before gluing " ,  readPointers[iBoard]
            print "words read at top of buffer = " , wordsRead
            readPointers[iBoard] = timeStampEventSize - wordsRead
            print "read pointer set to " , readPointers[iBoard]
            boardData = boardData + timeStampData[0:readPointers[iBoard]]
            print "glued event data = ",boardData
            eventData[iBoard].append(boardData)

        while ( (readPointers[iBoard]+timeStampEventSize)<=trigDPRWritePointer):
            boardData = timeStampData[ readPointers[iBoard]:(readPointers[iBoard]+timeStampEventSize)]
            readPointers[iBoard] = readPointers[iBoard] + timeStampEventSize
            print "readPointer = " , readPointers[iBoard]
            #print boardData
            eventData[iBoard].append(boardData)



# Loop through and print out a CSV file.
csvwriter = csv.writer(csvfile,delimiter=',')
numEvents = len(eventData[0])
print " Number of Events recorded = " , numEvents

for iEvent in range(numEvents):
    dataWords = []
    for iBoard in range (len(boards)):
        for dataWord in eventData[iBoard][iEvent]:
            dataWords.append(dataWord)

    #print dataWord , ", ",
    print dataWords
    print
    csvwriter.writerow(dataWords)
    

        

        

from PyChipsUser import *
from datetime import datetime
from os import environ
import math

#chipsLog.setLevel(logging.DEBUG)

#######################
### TEST PARAMETERS ###
hostIP         = "localhost"
hostPort       = 50001
hostRamName    = "BigTestRam"
testDepth      = 350
testIterations = 10000
#######################

addrTable = AddressTable("../addressTables/davesFirmwareSoakTestAddrTable.txt")
testBoard = ChipsBusUdp(addrTable, hostIP, hostPort)

# Fill up the host's RAM with something, just so we can see its working correctly
# when in debug mode
writeBuf = []
for iVal in range(testDepth):
  writeBuf.append(iVal)
testBoard.blockWrite(hostRamName, writeBuf)

print "Read-bandwidth test is running..."

# Start the clock
startTime = datetime.now()

# Run the test
for iRead in range(testIterations):
  testBoard.blockRead(hostRamName, testDepth)

# Stop the clock
stopTime = datetime.now()


# Calculate the total IPbus payload actually transferred in kilobytes, excluding all headers, etc
totalPayloadKB = testIterations * testDepth / 256.

# Calculate the total transfer time in seconds
totalTime = stopTime-startTime
totalSeconds = (totalTime.days*86400) + totalTime.seconds + (totalTime.microseconds/1000000.)

dataRateKB_s = totalPayloadKB/totalSeconds

print "\nRead Bandwidth Results:"
print "-----------------------\n"
print "Total IPbus payload transferred = %.2f KB" % totalPayloadKB
print "Total time taken                = %.2f s" % totalSeconds
print "Average read bandwidth          = %.2f KB/s" % dataRateKB_s


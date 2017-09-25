#! /usr/bin/env python

#--------------------------------------------------------------
# Soak-tester for Dave Newbold's default/example IPbus firmware 
#
#  Robert Frazier, March 2011 
#--------------------------------------------------------------

# Python imports
import sys
from optparse import OptionParser
from random import random
from time import asctime
import os

def getRandU32Value():
    """Returns a random unsigned 32-bit value"""
    return int(random()*0xffffffff)

def getRandU32List(listSize):
    """Returns a list of length listSize of random U32 values"""
    result = []
    for i in range(listSize):
        result.append(getRandU32Value())
    return result

def screenAndLog(logFile, msg):
    """Prints a message to both the screen and to a logFile handle"""
    print msg
    logFile.write(msg + "\n")
    logFile.flush()
    os.fsync(logFile)

def findAddrTable():
    """A hacky function that attempts to find and return the soakTestAddrTable.txt file-path.
       Returns False if it can't find it.
    """
    for item in sys.path:
        if item.find("PyChips")  >= 0 or item.find("pychips") >= 0:
            if item.find("src") >= 0:
                file = item + "/../addressTables/soakTestAddrTable.txt"
                if os.path.exists(file) and os.path.isfile(file):
                    return file
    return False
    
if __name__ == '__main__':
    
    # Option parser stuff
    parser = OptionParser(usage = "%prog target_ip_address [options]\n\n"
                                  "IPbus Soak Tester\n"
                                  "-----------------")
    parser.add_option("-i", "--iterations", action="store", type="int", dest="maxIterations", default=10000,
                      help="Number of test iterations  (default = %default) to perform; zero or less indicates the test should run ~indefinitely.")
    parser.add_option("-p", "--port", action="store", type="int", dest="port", default=50001,
                      help="Port number of the target device you wish to soak-test (default = %default)")
    parser.add_option("-f", "--addrTableFile", action="store", type="string", dest="addrTableFile",
                      help="Manually specify the complete filepath to soakTestAddrTable.txt if it can't automatically be found")
    parser.add_option("-v", "--verbose", action="store_true", dest="verbose", default=False,
                      help="turn on verbose mode: prints outgoing/incoming packets to the console")
    (options, args) = parser.parse_args()

    # Find out if they have or haven't supplied an IP address
    if len(args) != 1:
        parser.error("\nYou must supply a target IP address when running this script!\n" \
                     "For example:\n\t./soakTest.py 192.168.200.16\n\t./soakTest.py localhost\n" \
                     "For more help and options, do:\n\t./soakTest.py -h")
    ipAddr = args[0]

    # Open up a log file.
    logName = '/tmp/soakTestLog_' + ipAddr + '.txt'
    log = open(logName, 'w')
    screenAndLog(log, "\nSoak-Test Session Started at " + asctime() + \
                      "\n-----------------------------------------------------\n")

    # Either get the address table filename from the command line option,
    # or try to automatically find it
    if options.addrTableFile != None:
        addrTableFile = options.addrTableFile
    else:
        addrTableFile = findAddrTable()
        if addrTableFile:
            screenAndLog(log, "Using the following automatically located address-table file:\n" + addrTableFile + "\n")
        else:
            screenAndLog(log, "Failed to locate 'soakTestAddrTable.txt' within your PyChips installation.\n" \
                              "Please specify the complete path to this file using the -f option next\n" \
                              "time you run this soak test script.")
            sys.exit()

    # Now import PyChips
    from PyChipsUser import *

    # Set the logger up according to verbosity flag
    if options.verbose: chipsLog.setLevel(logging.DEBUG)
    else: chipsLog.setLevel(logging.INFO)
    
    # Create the UDP IPbus to the target device being soak-tested
    board = ChipsBusUdp(AddressTable(addrTableFile), ipAddr, options.port)

    # If the user specified zero or less iterations, this means run ~indefinitely
    if options.maxIterations < 1: options.maxIterations = 1000000000000

    # Counters
    testIterationCount = 0
    writeReadErrors = 0
    blockWriteReadErrors = 0
    exceptionCount = 0
    
    loop = True

    print "\nLog output also at:", logName
    print "Press ctrl-c to terminate test."
    print "Running...\n"    
    
    while testIterationCount < options.maxIterations:
        try:
            testIterationCount += 1
            if(testIterationCount % 1000 == 0):
                screenAndLog(log, "Iteration " + repr(testIterationCount))
            testVal = getRandU32Value()
            board.write("Test", testVal)
            readResult = board.read("Test")
            if readResult != testVal:
                screenAndLog(log, "Write/Read error occurred! Expected " + hex(testVal) + " but got " + hex(readResult))
                writeReadErrors += 1
            blockTestVal = getRandU32List(16)
            board.blockWrite("BigTestRam", blockTestVal)
            blockReadResult = board.blockRead("BigTestRam", 16)
            if blockTestVal != blockReadResult:
                screenAndLog(log, "Block Write/Read error occurred!" \
                                  "\n\tExpected          Received" \
                                  "\n\t--------          --------" \
                                   + uInt32HexDualListStr(blockTestVal, blockReadResult))
                blockWriteReadErrors += 1
            if writeReadErrors >= 30 or blockWriteReadErrors >= 30:
                screenAndLog(log, "\nToo many errors have occurred - ending test program!")
                break         
        except KeyboardInterrupt:
            screenAndLog(log, "\nKeyboard interrupt (ctrl-c) received - ending test program!")
            break
        except ChipsException, what:
            screenAndLog(log, "An exception occurred at " + asctime() + ":\n\t" + str(what))
            exceptionCount += 1
            if exceptionCount >= 30:
                screenAndLog(log, "\nToo many exceptions have occurred - ending test program!")
                break
            
    screenAndLog(log, "\n\n-----------------\nTest Summary:\n")
    screenAndLog(log, "\tTotal Test Iterations                  = " + repr(testIterationCount))
    screenAndLog(log, "\tTotal Write/Read Errors                = " + repr(writeReadErrors))
    screenAndLog(log, "\tTotal Block Write/Read Errors          = " + repr(blockWriteReadErrors))
    screenAndLog(log, "\tTotal ChipsBus Exceptions during test  = " + repr(exceptionCount)) 

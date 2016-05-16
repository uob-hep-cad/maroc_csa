#! /usr/bin/env python

'''
startDummyHardware.py
---------------------

Starts the IPbus Dummy Hardware.  Use ctrl-c to stop it from running.
By default it runs in UDP mode on port 50001 with a "quiet" amount of logging.
To run in different modes, see the command-line options via:
  
  ./startDummyHardware.py -h
  
Created on Dec 15, 2011

@author: Robert Frazier
'''

# Python imports
from optparse import OptionParser

# Project imports
from DummyHardware import DummyHardwareUdp, DummyHardwareTcp
from ChipsLog import chipsLog, logging

if __name__ == "__main__":
    
    # Option parser stuff
    parser = OptionParser(usage = "%prog [options]\n\n"
                                  "IPbus Dummy Hardware Server help\n"
                                  "--------------------------------")
    parser.add_option("-v", "--verbose", action="store_true", dest="verbose", default=False,
                      help="turn on verbose mode: prints incoming/outgoing packets to the console")
    parser.add_option("-p", "--port", action="store", type="int", dest="port", default=50001,
                      help="port number the dummy hardware will listen to (default = %default)")
    parser.add_option("-u", "--udp", action="store_true", dest="udp", default=True,
                      help="UDP mode (the default): the dummy hardware will listen for UDP packets")
    parser.add_option("-t", "--tcp", action="store_false", dest="udp",
                      help="TCP mode: the dummy hardware will listen for TCP packets")
    (options, args) = parser.parse_args()

    # Print out what is about to happen
    protocol = "UDP"
    if not options.udp:   # If we aren't using UDP, then it must be TCP
        protocol = "TCP"
    print "IPbus Dummy Hardware will listen for", protocol, "packets on 'localhost' port " + str(options.port) + "...\n"

    # Turn on debug mode if the verbose option was selected
    if options.verbose: chipsLog.setLevel(logging.DEBUG)
    else: chipsLog.setLevel(logging.INFO)

    dummyHardware = None
    if options.udp:
        dummyHardware = DummyHardwareUdp(port = options.port)
    else:
        dummyHardware = DummyHardwareTcp(port = options.port)

    dummyHardware.serveForever()  # Ctrl-c will stop it serving forever.
    dummyHardware.closeSockets()  # Tidy up any open sockets we no-longer need.
    del(dummyHardware)

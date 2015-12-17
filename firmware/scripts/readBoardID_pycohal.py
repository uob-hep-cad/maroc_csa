#!/bin/python

import uhal

uri = "ipbusudp-2.0://192.168.200.16:50001"
address_table = "file://pc049aAddrTable_marocdemo.xml"

hw = uhal.getDevice( "pc049a" , uri , address_table  )

# Debugging....
device_id = hw.id()
print hw
# Grab the device's URI
device_uri = hw.uri()
print device_uri

#...................

reg = hw.getNode("FirmwareId").read()

hw.dispatch()

print " REG =", hex(reg)

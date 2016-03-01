#!/usr/bin/python
import MarocSC_old 
marocSC = MarocSC_old.MarocSC_old()
marocSC.getLocalBitArray()
marocWordArray = marocSC.getLocalWordArray()
print marocWordArray
marocSC.writeConfigFile("tmp.cfg")

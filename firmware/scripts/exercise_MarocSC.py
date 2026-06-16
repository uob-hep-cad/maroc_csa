#!/usr/bin/python
import MarocSC 
marocSC = MarocSC.MarocSC()
marocSC.getBitArray()
marocWordArray = marocSC.getWordArray()
print(marocWordArray)
marocSC.writeConfigFile("tmp.cfg")

#
# Script to write to MAROC configuration ( slow control ) shift register
# Specify a set of bits to write high..
#
import sys
from optparse import OptionParser

from PyChipsUser import *

parser = OptionParser()
parser.add_option("-i", dest = 'ipAddress' , default="192.168.200.16")
parser.add_option("-a", dest = 'boardAddressTable' , default="./pc049aAddrTable_marocdemo.txt")

(options, args) = parser.parse_args()
print("IP address = " + options.ipAddress)
print("Board address table " + options.boardAddressTable)
        
bAddrTab = AddressTable(options.boardAddressTable)

board = ChipsBusUdp(bAddrTab,options.ipAddress,50001)

firmwareID=board.read("FirmwareId")
print("Firmware = " , hex(firmwareID))

numSCbits = 829
numWords = 26
busWidth = 32
bits = [ 0, 1, 15, 16, 17, 18, 19, 21, 159, 160, 161, 162, 163, 164, 165, 166, 167, 168, 169, 170, 171, 172, 173, 174, 175, 176, 177, 178, 179, 180, 181, 182, 183, 184, 187, 188, 191, 200, 209, 218, 227, 236, 245, 254, 263, 272, 281, 290, 299, 308, 317, 326, 335, 344, 353, 362, 371, 380, 389, 398, 407, 416, 425, 434, 443, 452, 461, 470, 479, 488, 497, 506, 515, 524, 533, 542, 551, 560, 569, 578, 587, 596, 605, 614, 623, 632, 641, 650, 659, 668, 677, 686, 695, 704, 713, 722, 737, 740, 749, 758 ]
#bits = [ 0 ]
SCData = numWords*[0x00000000]

for bitNumber in bits:
    bitNum = numSCbits - bitNumber -1
    wordBitPos = bitNum % busWidth
    wordNum    = bitNum / busWidth
    print("setting bit number (reversed) " , bitNumber , bitNum , " => bit " , wordBitPos , " of word " , wordNum)
    SCData[wordNum] += 0x00000001 << wordBitPos

print(SCData)

# Should write to output data buffer
board.blockWrite("scSrDataOut",SCData)

scdata0 = board.blockRead("scSrDataOut",numWords)
print("SC SR words = " , scdata0)


# Trigger writing of control register
board.write("scSrCtrl" , 0x00000000)



 

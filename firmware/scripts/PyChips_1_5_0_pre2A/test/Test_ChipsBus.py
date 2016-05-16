'''
Tests for the ChipsBusBase/ChipsBusUdp classes (ChipsBus.py)

@author Robert Frazier

June 2010
'''

import unittest
import os, random

from ChipsBus import ChipsBusBase, ChipsBusUdp
from ChipsException import ChipsException
from AddressTable import AddressTable

#######  IMPORTANT  ######
# NOTE:  The script "startDummyHardware.py" must be already 
# running for this test to complete properly!
##########################


class Test_ChipsBus(unittest.TestCase):


    def setUp(self):
        self.testObj = ChipsBusUdp(AddressTable("../addressTables/simpleTestAddrTable.txt"), "localhost", 50001)
        
        myFile = open("Test_ChipsBus_oversizeAddrTable.txt", 'w')
        for i in range(400):
            myFile.write("Reg" + str(i) + "    " + str(hex(0x00000000+i)) + "    0xffffffff    1    1\n")
        myFile.write("ResetDummyHW   0xffffffff     0xffffffff    1    1\n")
        myFile.close()
        
        self.oversizeTestObj = ChipsBusUdp(AddressTable("Test_ChipsBus_oversizeAddrTable.txt"), "localhost", 50001)

    def tearDown(self):
        del(self.testObj)
        del(self.oversizeTestObj)
        os.remove("Test_ChipsBus_oversizeAddrTable.txt")

    def test__unmaskedRead(self):  # We want this test to come first out of all the tests in this module.
        self.assertEqual(self.testObj.read("UnitTest_ResetDummyHW"), 0)  # Mechanism to reset dummy hardware.
        self.assertEqual(self.testObj.read("UnitTest1"), 0)
        self.testObj.write("UnitTest1_mask1", 0x80)
        self.testObj.write("UnitTest1_mask2", 0x18)
        self.testObj.write("UnitTest1_mask3", 0xff0)
        self.testObj.write("UnitTest1_mask4", 0x1)
        self.assertEqual(self.testObj.read("UnitTest1"), 0x80181fe1)
    
    def test_maskedRead(self):
        self.testObj.read("UnitTest_ResetDummyHW")  # Mechanism to reset dummy hardware.
        self.testObj.write("UnitTest1_mask3", 0xff0)
        self.assertEqual(self.testObj.read("UnitTest1_mask3"), 0xff0)
        
    def test_unmaskedReadWithAddrOffset(self):
        self.testObj.read("UnitTest_ResetDummyHW")  # Mechanism to reset dummy hardware.
        self.testObj.write("UnitTest2", 0xdeadbeef)
        self.assertEqual(self.testObj.read("UnitTest1", 1), 0xdeadbeef)

    def test_maskedReadWithAddrOffset(self):
        self.testObj.read("UnitTest_ResetDummyHW")  # Mechanism to reset dummy hardware.
        self.testObj.write("UnitTest2", 0xdeadbeef)
        self.assertEqual(self.testObj.read("UnitTest1_mask3", 1), 0x5f77)

    def test_blockRead(self):
        self.testObj.read("UnitTest_ResetDummyHW")  # Mechanism to reset dummy hardware.
        result = [0xdeadbeef, 0xffffffff, 0x12345678, 0x87654321,
                  0x89abcdef, 0xfedcba98, 0x81818181, 0x18181818]
        self.testObj.write("UnitTest1", result[0])
        self.testObj.write("UnitTest2", result[1])
        self.testObj.write("UnitTest3", result[2])
        self.testObj.write("UnitTest4", result[3])
        self.testObj.write("UnitTest5", result[4])
        self.testObj.write("UnitTest6", result[5])
        self.testObj.write("UnitTest7", result[6])
        self.testObj.write("UnitTest8", result[7])
        self.assertEqual(self.testObj.blockRead("UnitTest1", 8), result)
        
    def test_blockReadWithAddrOffset(self):
        self.testObj.read("UnitTest_ResetDummyHW")  # Mechanism to reset dummy hardware.
        result = [0xdeadbeef, 0xffffffff, 0x12345678, 0x87654321,
                  0x89abcdef, 0xfedcba98, 0x81818181, 0x18181818]
        self.testObj.write("UnitTest1", result[0])
        self.testObj.write("UnitTest2", result[1])
        self.testObj.write("UnitTest3", result[2])
        self.testObj.write("UnitTest4", result[3])
        self.testObj.write("UnitTest5", result[4])
        self.testObj.write("UnitTest6", result[5])
        self.testObj.write("UnitTest7", result[6])
        self.testObj.write("UnitTest8", result[7])
        self.assertEqual(self.testObj.blockRead("UnitTest1", 5, 2), result[2:-1])

    def test_blockReadZeroDepthIgnored(self):
        self.assertEqual(self.testObj.blockRead("UnitTest1", 0), None)
    
    def test_blockReadNegativeDepthIgnored(self):
        self.assertEqual(self.testObj.blockRead("UnitTest1", -1), None)

    def test_unmaskedWrite(self):
        self.testObj.write("UnitTest1", 0xdeadbeef)
        self.assertEqual(self.testObj.read("UnitTest1"), 0xdeadbeef)

    def test_unmaskedWriteWithAddrOffset(self):
        self.testObj.write("UnitTest1", 0xdeadbeef, 4)
        self.assertEqual(self.testObj.read("UnitTest2"), 0xdeadbeef)

    def test_unmaskedWriteOversizeDataIgnored(self):
        self.testObj.write("UnitTest1", 0xffffdeadbeef)
        self.assertEqual(self.testObj.read("UnitTest1"), 0xdeadbeef)
    
    def test_maskedWrite(self):
        self.testObj.write("UnitTest1_mask2", 0x81)
        self.assertEqual(self.testObj.read("UnitTest1_mask2"), 0x81)

    def test_maskedWriteWithAddrOffset(self):
        self.testObj.read("UnitTest_ResetDummyHW")  # Mechanism to reset dummy hardware.
        self.testObj.write("UnitTest1_mask2", 0xe7, 1)
        self.assertEqual(self.testObj.read("UnitTest2"), 0x00e70000)
        
    def test_oversizeMaskedWriteThrows(self):
        # Want to see if requesting a write that is too large
        # for the mask will throw an exception
        self.assertRaises(ChipsException, self.testObj.write, "UnitTest1_mask3", 0xffff)
        
    def test_blockWrite(self):     
        data = [0xdeadbeef, 0xffffffff, 0x12345678, 0x87654321,
                  0x89abcdef, 0xfedcba98, 0x81818181, 0x18181818]
        self.testObj.blockWrite("UnitTest1", data)
        self.assertEqual(self.testObj.blockRead("UnitTest1", 8), data)

    def test_blockWriteWithAddrOffset(self):
        data = [0xdeadbeef, 0xffffffff, 0x12345678, 0x87654321,
                  0x89abcdef, 0xfedcba98]
        self.testObj.blockWrite("UnitTest1", data, 2)
        self.assertEqual(self.testObj.blockRead("UnitTest3", 6), data)
    
    def test_blockWriteOnMaskedRegisterThrows(self):
        data = [0xdeadbeef, 0xffffffff, 0x12345678, 0x87654321,
                  0x89abcdef, 0xfedcba98]
        self.assertRaises(ChipsException, self.testObj.blockWrite, "UnitTest1_mask1", data)
        
    def test_oversizeBlockRead(self):
        data = []
        
        for i in range(400):
            data.append(int(random.random()*0xffffffff))            
        
        self.oversizeTestObj.blockWrite("Reg0", data[:200])
        self.oversizeTestObj.blockWrite("Reg200", data[200:])
        
        self.assertEqual(self.oversizeTestObj.blockRead("Reg0",400), data)
        
    def test_oversizeBlockWrite(self):
        data = []
        
        for i in range(400):
            data.append(int(random.random()*0xffffffff))            
        
        self.oversizeTestObj.blockWrite("Reg0", data)
        
        self.assertEqual(self.oversizeTestObj.blockRead("Reg0",200)+self.oversizeTestObj.blockRead("Reg200",200), data)
        
    def test_getTransactionId(self):
        previousTransactionId = self.testObj._getTransactionId()
        transactionId = self.testObj._getTransactionId()
        self.assertTrue(previousTransactionId + 1 == transactionId)
        for i in range(ChipsBusBase.MAX_TRANSACTION_ID + 1):
            transactionId = self.testObj._getTransactionId()
            self.assertTrue(transactionId > 0 and transactionId <= ChipsBusBase.MAX_TRANSACTION_ID)
            
    def test_queueRead(self):
        self.testObj.read("UnitTest_ResetDummyHW")  # Mechanism to reset dummy hardware.
        data = [0xdeadbeef, 0xffffffff, 0x12345678, 0x87654321,
                  0x89abcdef, 0xfedcba98]
        self.testObj.blockWrite("UnitTest1", data)
        self.testObj.queueRead("UnitTest1")
        self.testObj.queueRead("UnitTest2")
        self.testObj.queueRead("UnitTest3")
        self.testObj.queueRead("UnitTest4")
        self.testObj.queueRead("UnitTest5")
        self.testObj.queueRead("UnitTest6")
        self.assertEqual(self.testObj.queueRun()[0], data)
        
    def test_queueWrite(self):
        self.testObj.read("UnitTest_ResetDummyHW")  # Mechanism to reset dummy hardware.
        result = [0xdeadbeef, 0xffffffff, 0x12345678, 0x87654321,
                  0x89abcdef, 0xfedcba98, 0x81818181, 0x18181818]
        self.testObj.queueWrite("UnitTest1", result[0])
        self.testObj.queueWrite("UnitTest2", result[1])
        self.testObj.queueWrite("UnitTest3", result[2])
        self.testObj.queueWrite("UnitTest4", result[3])
        self.testObj.queueWrite("UnitTest5", result[4])
        self.testObj.queueWrite("UnitTest6", result[5])
        self.testObj.queueWrite("UnitTest7", result[6])
        self.testObj.queueWrite("UnitTest8", result[7])
        self.testObj.queueRun()
        self.assertEqual(self.testObj.blockRead("UnitTest1", 8), result)
        
    def test_queueReadWrite(self):
        self.testObj.read("UnitTest_ResetDummyHW")  # Mechanism to reset dummy hardware.
        self.testObj.queueWrite("UnitTest1", 0x1234567)
        self.testObj.queueRead("UnitTest1")
        self.testObj.queueWrite("UnitTest2", 0xdeadbeef)
        self.testObj.queueRead("UnitTest2")
        self.assertEqual(self.testObj.queueRun()[0], [0x1234567, 0xdeadbeef])

    def test_readNotAllowed(self):
        self.assertRaises(ChipsException, self.testObj.read, "i2c_reset")
        self.assertRaises(ChipsException, self.testObj.blockRead, "i2c_reset", 1)

    def test_writeNotAllowed(self):
        self.assertRaises(ChipsException, self.testObj.write, "SysId", 0xffffffff)
        self.assertRaises(ChipsException, self.testObj.blockWrite, "SysId", [ 0xffffffff ])
        
    def test_fifoRead(self):
        self.testObj.write("UnitTest1", 0xf0e1d2c3) # The dummy hardware doesn't have a real fifo... just a register
        self.assertEqual(self.testObj.fifoRead("UnitTest1", 4), [0xf0e1d2c3, 0xf0e1d2c3, 0xf0e1d2c3, 0xf0e1d2c3])

    def test_fifoReadWithAddrOffset(self):
        self.testObj.write("UnitTest1", 0x8a7b6c5d, 2)
        self.assertEqual(self.testObj.fifoRead("UnitTest1", 4, 2), [0x8a7b6c5d, 0x8a7b6c5d, 0x8a7b6c5d, 0x8a7b6c5d])
        
    def test_fifoReadOnMaskedRegisterThrows(self):
        self.assertRaises(ChipsException, self.testObj.fifoRead, "UnitTest1_mask1", 2)
    
    def test_oversizeFifoRead(self):
        self.testObj.write("UnitTest1", 0xc4b2ea61)
        
        expectedResult=[]
        for i in range(400):
            expectedResult.append(0xc4b2ea61)            
        
        self.assertEqual(self.testObj.fifoRead("UnitTest1", 400), expectedResult)

    def test_fifoWrite(self):
        self.testObj.fifoWrite("UnitTest1", [0x12345678, 0x90abcdef, 0x8a7b6c5d])
        # Dummy hardware doesn't have a real FIFO. Last value written will be the value the register holds.
        self.assertEqual(self.testObj.read("UnitTest1"), 0x8a7b6c5d)
    
    def test_fifoWriteWithAddrOffset(self):
        self.testObj.fifoWrite("UnitTest1", [0x65748392, 0x91827364, 0xf9e8d7c6, 0xa1b2c3d4], 6)
        self.assertEqual(self.testObj.read("UnitTest7"), 0xa1b2c3d4)
    
    def test_fifoWriteOnMaskedRegisterThrows(self):
        self.assertRaises(ChipsException, self.testObj.fifoWrite, "UnitTest1_mask1", [0x90abcdef, 0x98765432, 0x56473829])
    
    def test_oversizeFifoWrite(self):
        # Reset the dummy hardware
        self.oversizeTestObj.read("ResetDummyHW")

        dataToWrite = []
        expectedBlockReadResult = []
        for i in range(400):
            dataToWrite.append(0xcafebabe)            
            expectedBlockReadResult.append(0)
        expectedBlockReadResult[0] = 0xcafebabe

        # Only Reg1 should have a non-zero value, as this is a FIFO write, not a block write.
        self.oversizeTestObj.fifoWrite("Reg1", dataToWrite)
        # Read back with a blockRead. Reg1 will contain 0xcafebabe, Reg2 to Reg400 will be all zeros.
        self.assertEqual(self.oversizeTestObj.blockRead("Reg1", 400), expectedBlockReadResult)  

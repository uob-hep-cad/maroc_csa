'''
Tests for the AddressTable class

@author Robert Frazier

June 2010
'''

import unittest
from AddressTable import AddressTable
from ChipsException import ChipsException
import os


class Test_AddressTable(unittest.TestCase):

    # Filename for the good address table.
    goodAddressTable_fileName = "Test_AddressTable_goodAddressTable.txt"
    
    # Filenames for malformed address tables
    addressNotValidNumber_fileName = "Test_AddressTable_addressNotValidNumber.txt"
    addressNot32Bit_fileName = "Test_AddressTable_addressNot32Bit.txt"
    addressNegative_fileName = "Test_AddressTable_addressNegative.txt"
    maskNotValidNumber_fileName = "Test_AddressTable_maskNotValidNumber.txt"
    maskNot32Bit_fileName = "Test_AddressTable_maskNot32Bit.txt"
    maskNegative_fileName = "Test_AddressTable_maskNegative.txt"
    maskZero_fileName = "Test_AddressTable_maskZero.txt"
    readNotValidNumber_filename = "Test_AddressTable_readNotValidNumber.txt"
    writeNotValidNumber_filename = "Test_AddressTable_writeNotValidNumber.txt"
    lineTooShort_fileName = "Test_AddressTable_lineTooShort.txt"
    registerNameUsedTwice_fileName = "Test_AddressTable_registerNameUsedTwice.txt"
    

    def setUp(self):

        # Create the good address table
        
        myFile = open(Test_AddressTable.goodAddressTable_fileName, 'w')
        myFile.write("* This line is a comment and should be ignored\n" \
                     "MyRegister1     00000000     ffffffff   1   1   This text is ignored\n" \
                     "MyRegister2   0x00000004   0x0000ffff   1   1   Test we can prepend hex with a '0x'\n" \
                     "* Now we will test if a blank line and a blank line with whitespace are ignored:\n" \
                     "\n" \
                     "            \n" \
                     "* Finally we test to see if a register is picked up even if there is no newline afterwards:\n" \
                     "MyRegister3     f0000000     00ffff00   1   1")
        myFile.close()
        

        # Create all the malformed address tables
         
        myFile = open(Test_AddressTable.addressNotValidNumber_fileName, 'w')
        myFile.write("MyRegister   thisIsNotARealNumberButAString!   0xff000000   1   1\n")
        myFile.close()
        
        myFile = open(Test_AddressTable.addressNot32Bit_fileName, 'w')
        myFile.write("MyRegister   0x100000000   0xff000000   1   1\n")
        myFile.close()

        myFile = open(Test_AddressTable.addressNegative_fileName, 'w')
        myFile.write("MyRegister   -0x12345670   0xff000000   1   1\n")
        myFile.close()

        myFile = open(Test_AddressTable.maskNotValidNumber_fileName, 'w')
        myFile.write("MyRegister   0x00000000   thisIsNotARealNumberButAString!   1   1\n")
        myFile.close()

        myFile = open(Test_AddressTable.maskNot32Bit_fileName, 'w')
        myFile.write("MyRegister   0x00000000   0x100000000   1   1\n")
        myFile.close()

        myFile = open(Test_AddressTable.maskNegative_fileName, 'w')
        myFile.write("MyRegister   0xff000000   -0x12345670   1   1\n")
        myFile.close()

        myFile = open(Test_AddressTable.maskZero_fileName, 'w')
        myFile.write("MyRegister   0x00000000   0x00000000   1   1\n")
        myFile.close()

        myFile = open(Test_AddressTable.readNotValidNumber_filename, 'w')
        myFile.write("MyRegister     0x00000000     0xffffffff   y   1\n")
        myFile.close()

        myFile = open(Test_AddressTable.writeNotValidNumber_filename, 'w')
        myFile.write("MyRegister     0x00000000     0xffffffff   1   -1\n")
        myFile.close()

        myFile = open(Test_AddressTable.lineTooShort_fileName, 'w')
        myFile.write("MyRegister   0x00000000   \n")
        myFile.close()

        myFile = open(Test_AddressTable.registerNameUsedTwice_fileName, 'w')
        myFile.write("MyRegister   0x00000000   0xffffffff   1   1\n" \
                     "MyRegister   0x00000010   0xffffffff   1   1\n")
        myFile.close()       
        

    def tearDown(self):
        # Clean up after the tests are over.
        os.remove(Test_AddressTable.goodAddressTable_fileName)
        os.remove(Test_AddressTable.addressNotValidNumber_fileName)
        os.remove(Test_AddressTable.addressNot32Bit_fileName)
        os.remove(Test_AddressTable.addressNegative_fileName)
        os.remove(Test_AddressTable.maskNotValidNumber_fileName)
        os.remove(Test_AddressTable.maskNegative_fileName)
        os.remove(Test_AddressTable.maskNot32Bit_fileName)
        os.remove(Test_AddressTable.maskZero_fileName)
        os.remove(Test_AddressTable.readNotValidNumber_filename)
        os.remove(Test_AddressTable.writeNotValidNumber_filename)
        os.remove(Test_AddressTable.lineTooShort_fileName)
        os.remove(Test_AddressTable.registerNameUsedTwice_fileName)

    def test_constructionWithGoodFile(self):
        myAddrTable = AddressTable(Test_AddressTable.goodAddressTable_fileName)
        self.assertEqual(len(myAddrTable.items), 3)  # Should be three items in the address table
        self.assertEqual(myAddrTable.fileName, Test_AddressTable.goodAddressTable_fileName)
    
    def test_getItemMethod(self):
        myAddrTable = AddressTable(Test_AddressTable.goodAddressTable_fileName)
        item = myAddrTable.getItem("MyRegister3")
        self.assertEqual(item.getName(), "MyRegister3")
        self.assertEqual(item.getAddress(), 0xf0000000)
        self.assertEqual(item.getMask(), 0x00ffff00)
        self.assertEqual(item.getReadFlag(), 1)
        self.assertEqual(item.getWriteFlag(), 1)

    def test_throwsWhenAddressNotValidNumber(self):
        self.assertRaises(ChipsException, AddressTable, Test_AddressTable.addressNotValidNumber_fileName)

    def test_throwsWhenAddressNot32Bit(self):
        self.assertRaises(ChipsException, AddressTable, Test_AddressTable.addressNot32Bit_fileName)

    def test_throwsWhenAddressNegative(self):
        self.assertRaises(ChipsException, AddressTable, Test_AddressTable.addressNegative_fileName)
    
    def test_throwsWhenMaskNotValidNumber(self):
        self.assertRaises(ChipsException, AddressTable, Test_AddressTable.maskNotValidNumber_fileName)

    def test_throwsWhenMaskNot32Bit(self):
        self.assertRaises(ChipsException, AddressTable, Test_AddressTable.maskNot32Bit_fileName)

    def test_throwsWhenMaskNegative(self):
        self.assertRaises(ChipsException, AddressTable, Test_AddressTable.maskNegative_fileName)

    def test_throwsWhenMaskZero(self):
        self.assertRaises(ChipsException, AddressTable, Test_AddressTable.maskZero_fileName)

    def test_throwsWhenReadNotValidNumber(self):
        self.assertRaises(ChipsException, AddressTable, Test_AddressTable.readNotValidNumber_filename)

    def test_throwsWhenWriteNotValidNumber(self):
        self.assertRaises(ChipsException, AddressTable, Test_AddressTable.writeNotValidNumber_filename)

    def test_throwsWhenLineTooShort(self):
        self.assertRaises(ChipsException, AddressTable, Test_AddressTable.lineTooShort_fileName)
    
    def test_throwsWhenRegisterNameUsedTwice(self):
        self.assertRaises(ChipsException, AddressTable, Test_AddressTable.registerNameUsedTwice_fileName)
        

        

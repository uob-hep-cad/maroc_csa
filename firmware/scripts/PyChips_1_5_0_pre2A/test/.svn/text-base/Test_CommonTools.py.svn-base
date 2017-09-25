'''
Tests for the functions in the CommonTools.py file

@author Robert Frazier

June 2010
'''

import unittest
from CommonTools import *
from ChipsException import ChipsException

class Test_uInt32Compatible(unittest.TestCase):
    def runTest(self):
        self.assertTrue(uInt32Compatible(0xffffffff))
        self.assertTrue(uInt32Compatible(0x00000000))
        self.assertTrue(uInt32Compatible(0x87654321))
        self.assertTrue(uInt32Compatible(0x12345678))
        self.assertFalse(uInt32Compatible(0x100000000))
        self.assertFalse(uInt32Compatible(-0x1))

class Test_uInt32HexStr(unittest.TestCase):
    def runTest(self):
        self.assertEqual(uInt32HexStr(0xffffffff), "ffffffff")
        self.assertEqual(uInt32HexStr(0x0), "00000000")
        self.assertEqual(uInt32HexStr(0x0f1e2d3c), "0f1e2d3c")
        self.assertEqual(uInt32HexStr(-0x1), "ffffffff")
        self.assertEqual(uInt32HexStr(0x1ffffffff), "ffffffff")  # Test input over 32-bit.
        self.assertEqual(uInt32HexStr(-0xfffffff3124158d), "cedbea73")  # Test negative input over 32-bit.
        self.assertRaises(ChipsException, uInt32HexStr, 0x1ffffffff, True)
        self.assertRaises(ChipsException, uInt32HexStr, -1, True)

class Test_uInt32BitFlip(unittest.TestCase):
    def runTest(self):
        # Various tests to see if it's flipping bits correctly
        self.assertEqual(uInt32BitFlip(0xffffffff), 0)
        self.assertEqual(uInt32BitFlip(0x0), 0xffffffff)
        self.assertEqual(uInt32BitFlip(0x12345678), 0xedcba987)
        self.assertEqual(uInt32BitFlip(-0x1), 0)
        self.assertEqual(uInt32BitFlip(-0xdeadbef0), 0xdeadbeef)
        self.assertEqual(uInt32BitFlip(0x123456789abcdef), 0x76543210)  # Test ignores anything other than bits 0-31
        # The below are tests to ensure that the number it returns is a valid uInt32
        # (i.e. not negative, and not ever using more than 32 bits.)
        # The above tests are testing equality but in a pythonic way, 
        # whereby (for example) 0xffffffff and -0x1 are equivalent.  I.e.
        # the above tests don't care if uInt32BitFlip returns a negative
        # number, but we want to ensure that uInt32BitFlip does not return
        # negative numbers.  So, we make use of the uInt32Compatible function.
        self.assertTrue(uInt32Compatible(uInt32BitFlip(0)))
        self.assertTrue(uInt32Compatible(uInt32BitFlip(0xffffffff)))
        self.assertTrue(uInt32Compatible(uInt32BitFlip(0x123456789abcedf))) # Test returns only a 32-bit number.

class Test_uInt32HexListStr(unittest.TestCase):
    def runTest(self):
        testList = [0xdeadbeef, 0xcafebabe, 0x0, 0x1, 0x80000000, 0xffffffff]
        expectedResult = "\n\tdeadbeef\n\tcafebabe\n\t00000000\n\t00000001\n\t80000000\n\tffffffff\n"
        self.assertEqual(uInt32HexListStr(testList), expectedResult)

class Test_uInt32HexDualListStr(unittest.TestCase):
    def runTest(self):
        testList1 = [0xdeadbeef, 0xcafebabe, 0x0, 0x0, 0x80000000, 0xffffffff]
        testList2 = [0xfeadbeef, 0xcafebabe, 0x0, 0x1, 0x80000000, 0xffffffff]
        expectedResult = "\n\tdeadbeef    !=    feadbeef" \
                         "\n\tcafebabe          cafebabe" \
                         "\n\t00000000          00000000" \
                         "\n\t00000000    !=    00000001" \
                         "\n\t80000000          80000000" \
                         "\n\tffffffff          ffffffff\n"
        self.assertEqual(uInt32HexDualListStr(testList1, testList2), expectedResult)

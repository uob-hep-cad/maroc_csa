'''
Unit test for the TransactionElementHeader class

Created on May 21, 2010

@author: Robert Frazier
'''

import unittest
from array import array
from TransactionElement import TransactionElement
from IPbusHeader import makeHeader, TYPE_ID_WRITE, TYPE_ID_NON_INCR_WRITE, INFO_CODE_REQUEST
from ChipsException import ChipsException


class Test_TransactionElement(unittest.TestCase):

    def setUp(self):
        # The test object I'm making here from the normal constructor is just totally
        # arbitrary - it doesn't conform to the IPbus spec at all.
        self.badTransactionElementArray = array('I', [0x82345671, 0xdeadbeef, 0xcafebabe, 0x0ddba115])
        self.badTestObjFromInit = TransactionElement(self.badTransactionElementArray)
        
        # The test object I'm making here is done via the makeFromHeaderAndBody() named
        # constructor, and is a proper IPbus transaction that conforms to the spec.
        goodHeader = makeHeader(2, 0x32, 0x5, TYPE_ID_WRITE, INFO_CODE_REQUEST)
        self.goodBodyList = [0x30303030, 0xdeadbeef, 0xcafebabe, 0xbabecafe, 0xbeefbabe, 0xbeefba11]
        self.goodTestObjFromHeaderAndBody = TransactionElement.makeFromHeaderAndBody(goodHeader, self.goodBodyList)

    def tearDown(self):
        pass

    def testGetAll_fromInit(self):
        self.assertEqual(self.badTransactionElementArray, self.badTestObjFromInit.getAll())
        
    def testGetAll_fromHeaderAndBody(self):
        self.assertEqual(array('I', [0x2032051f] + self.goodBodyList), self.goodTestObjFromHeaderAndBody.getAll())
        
    def testGetU32TransmitSize(self):
        self.assertEqual(7, self.goodTestObjFromHeaderAndBody.getU32TransmitSize())

    def testGetHeader_fromInit(self):
        self.assertEqual(0x82345671, self.badTestObjFromInit.getHeader())
        
    def testGetHeader_fromHeaderAndBody(self):
        self.assertEqual(0x2032051f, self.goodTestObjFromHeaderAndBody.getHeader())

    def testGetBody_fromInit(self):
        self.assertEqual(array('I', [0xdeadbeef, 0xcafebabe, 0x0ddba115]), self.badTestObjFromInit.getBody())

    def testGetBody_fromHeaderAndBody(self):
        self.assertEqual(array('I', self.goodBodyList), self.goodTestObjFromHeaderAndBody.getBody())

    def testValidBodySize(self):
        validHeader = makeHeader(2, 0x32, 5, TYPE_ID_NON_INCR_WRITE, INFO_CODE_REQUEST)
        badBody = [0xab5ba115]
        testObj_validHeaderBadBodySize = TransactionElement.makeFromHeaderAndBody(validHeader, badBody)
        self.assertEqual(True, self.goodTestObjFromHeaderAndBody.validBodySize())
        self.assertEqual(False, testObj_validHeaderBadBodySize.validBodySize())
        self.assertRaises(ChipsException, self.badTestObjFromInit.validBodySize)

    def testStringRepresentation(self):
        expectedResult = "  0x2032051f\tHeader\n"\
                         "  0x30303030\tBody 0\n"\
                         "  0xdeadbeef\tBody 1\n"\
                         "  0xcafebabe\tBody 2\n"\
                         "  0xbabecafe\tBody 3\n"\
                         "  0xbeefbabe\tBody 4\n"\
                         "  0xbeefba11\tBody 5\n"
        testStr = str(self.goodTestObjFromHeaderAndBody)
        testRepr = repr(self.goodTestObjFromHeaderAndBody)
        self.assertEqual(expectedResult, testStr)
        self.assertEqual(expectedResult, testRepr)


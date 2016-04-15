'''
Unit test for the TransactionElementHeader class

Created on May 21, 2010

@author: Robert Frazier
'''

import unittest
from IPbusHeader import *
from ChipsException import ChipsException


class Test_IPbusHeader(unittest.TestCase):


    def setUp(self):
        self.arbitraryHeaderU32 = 0xd8fb7d9e
        self.makeHeaderU32 = makeHeader(5, 0x932, 0x9c, TYPE_ID_NON_INCR_READ, INFO_CODE_BUS_ERR_ON_WR)

    def tearDown(self):
        pass

    def testVersionMethod_arbitraryHeader(self):
        self.assertEqual(0xd, getVersion(self.arbitraryHeaderU32))

    def testVersionMethod_makeHeader(self):
        self.assertEqual(0x5, getVersion(self.makeHeaderU32))

    def testWordsMethod_arbitraryHeader(self):
        self.assertEqual(0x8fb, getTransactionId(self.arbitraryHeaderU32))

    def testWordsMethod_makeHeader(self):
        self.assertEqual(0x932, getTransactionId(self.makeHeaderU32))    

    def testTransactionIdMethod_arbitraryHeader(self):
        self.assertEqual(0x7d, getWords(self.arbitraryHeaderU32))

    def testTransactionIdMethod_makeHeader(self):
        self.assertEqual(0x9c, getWords(self.makeHeaderU32))    

    def testTypeMethod_arbitraryHeader(self):
        self.assertEqual(0x9, getTypeId(self.arbitraryHeaderU32))

    def testTypeMethod_makeHeader(self):
        self.assertEqual(0x2, getTypeId(self.makeHeaderU32))

    def testInfoCodeMethod_arbitraryHeader(self):
        self.assertEqual(0xe, getInfoCode(self.arbitraryHeaderU32))
        
    def testInfoCodeMethod_makeHeader(self):
        self.assertEqual(0x3, getInfoCode(self.makeHeaderU32))

    def testIsRequestHeader(self):
        self.assertTrue(isRequestHeader(0x0000000f))
        self.assertFalse(isRequestHeader(0x00000000))
        self.assertFalse(isRequestHeader(0x00000001))
        self.assertFalse(isRequestHeader(0x0000000e))

    def testIsResponseHeader(self):
        self.assertTrue(isResponseHeader(0x9abcdef0))
        self.assertTrue(isResponseHeader(0x9abcdef3))
        self.assertTrue(isResponseHeader(0x9abcdefe))
        self.assertFalse(isResponseHeader(0x0000000f))

    def testIsResponseSuccessHeader(self):
        self.assertTrue(isResponseSuccessHeader(0x9abcdef0))
        self.assertFalse(isResponseSuccessHeader(0x0000000f))
        self.assertFalse(isResponseSuccessHeader(0x9abcedf1))

    def testIsResponseErrorHeader(self):
        self.assertFalse(isResponseErrorHeader(0x9abcdef0))
        self.assertTrue(isResponseErrorHeader(0x9abcdef1))
        self.assertTrue(isResponseErrorHeader(0x0000000e))
        self.assertTrue(isResponseErrorHeader(0x00000003))
        self.assertFalse(isResponseErrorHeader(0x0000000f))

    def testInterpretInfoCode(self):
        self.assertEqual("The client request was handled successfully", interpretInfoCode(INFO_CODE_RESPONSE))
        self.assertEqual("The client request resulted in a bus-write timeout", interpretInfoCode(INFO_CODE_BUS_TIMEOUT_ON_WR))
        self.assertEqual("Outgoing client request", interpretInfoCode(INFO_CODE_REQUEST))
        self.assertEqual("The IPbus header Info Code '0xe' is undefined/reserved!", interpretInfoCode(0xe))

    def testExpectedBodySizeThrowsWithBadHeader(self):
        self.assertRaises(ChipsException, getExpectedBodySize, self.arbitraryHeaderU32)

    def testExpectedBodySize_readRequest(self):
        testHeaderU32 = makeHeader(1, 1, 5, TYPE_ID_READ, INFO_CODE_REQUEST)
        self.assertEqual(1, getExpectedBodySize(testHeaderU32))
        
    def testExpectedBodySize_writeRequest(self):
        testHeaderU32 = makeHeader(1, 1, 5, TYPE_ID_WRITE, INFO_CODE_REQUEST)
        self.assertEqual(6, getExpectedBodySize(testHeaderU32))

    def testExpectedBodySize_nonIncrementingReadRequest(self):
        testHeaderU32 = makeHeader(1, 1, 5, TYPE_ID_NON_INCR_READ, INFO_CODE_REQUEST)
        self.assertEqual(1, getExpectedBodySize(testHeaderU32))
        
    def testExpectedBodySize_nonIncrementingWriteRequest(self):
        testHeaderU32 = makeHeader(1, 1, 5, TYPE_ID_NON_INCR_WRITE, INFO_CODE_REQUEST)
        self.assertEqual(6, getExpectedBodySize(testHeaderU32))

    def testExpectedBodySize_readWriteModifyBitsRequest(self):
        testHeaderU32 = makeHeader(1, 1, 5, TYPE_ID_RMW_BITS, INFO_CODE_REQUEST)
        self.assertEqual(3, getExpectedBodySize(testHeaderU32))

    def testExpectedBodySize_readWriteModifySumRequest(self):
        testHeaderU32 = makeHeader(1, 1, 5, TYPE_ID_RMW_SUM, INFO_CODE_REQUEST)
        self.assertEqual(2, getExpectedBodySize(testHeaderU32))

    def testExpectedBodySize_reservedAddressInfoRequest(self):
        testHeaderU32 = makeHeader(1, 1, 5, TYPE_ID_RSVD_ADDR_INFO, INFO_CODE_REQUEST)
        self.assertEqual(0, getExpectedBodySize(testHeaderU32))

    def testExpectedBodySize_readResponse(self):
        testHeaderU32 = makeHeader(1, 1, 5, TYPE_ID_READ, INFO_CODE_RESPONSE)
        self.assertEqual(5, getExpectedBodySize(testHeaderU32))
        
    def testExpectedBodySize_writeResponse(self):
        testHeaderU32 = makeHeader(1, 1, 5, TYPE_ID_WRITE, INFO_CODE_RESPONSE)
        self.assertEqual(0, getExpectedBodySize(testHeaderU32))

    def testExpectedBodySize_nonIncrementingReadResponse(self):
        testHeaderU32 = makeHeader(1, 1, 5, TYPE_ID_NON_INCR_READ, INFO_CODE_RESPONSE)
        self.assertEqual(5, getExpectedBodySize(testHeaderU32))
        
    def testExpectedBodySize_nonIncrementingWriteResponse(self):
        testHeaderU32 = makeHeader(1, 1, 5, TYPE_ID_NON_INCR_WRITE, INFO_CODE_RESPONSE)
        self.assertEqual(0, getExpectedBodySize(testHeaderU32))

    def testExpectedBodySize_readWriteModifyBitsResponse(self):
        testHeaderU32 = makeHeader(1, 1, 5, TYPE_ID_RMW_BITS, INFO_CODE_RESPONSE)
        self.assertEqual(1, getExpectedBodySize(testHeaderU32))

    def testExpectedBodySize_readWriteModifySumResponse(self):
        testHeaderU32 = makeHeader(1, 1, 5, TYPE_ID_RMW_SUM, INFO_CODE_RESPONSE)
        self.assertEqual(1, getExpectedBodySize(testHeaderU32))

    def testExpectedBodySize_reservedAddressInfoResponse(self):
        testHeaderU32 = makeHeader(1, 1, 5, TYPE_ID_RSVD_ADDR_INFO, INFO_CODE_RESPONSE)
        self.assertEqual(2, getExpectedBodySize(testHeaderU32))

    def testUpdateWords(self):
        testHeaderU32_orig = makeHeader(1, 1, 0xff, 0x3, 0)
        testHeaderU32_update1 = updateWords(testHeaderU32_orig, 129)
        self.assertEqual(129, getWords(testHeaderU32_update1))
        testHeaderU32_update2 = updateWords(testHeaderU32_orig, 0)
        self.assertEqual(0, getWords(testHeaderU32_update2))
        testHeaderU32_update3 = updateWords(testHeaderU32_update2, 0xfffffff)  # silly input
        self.assertEqual(0xff, getWords(testHeaderU32_update3))
        self.assertEqual(testHeaderU32_orig, testHeaderU32_update3)  # if the silly input hasn't overwritten anything else, then the original should equal update3

    def testUpdateInfoCode(self):
        testHeaderU32_orig = makeHeader(1, 5, 1, 0x2, INFO_CODE_REQUEST)
        testHeaderU32_update1 = updateInfoCode(testHeaderU32_orig, 0)
        self.assertEqual(0, getInfoCode(testHeaderU32_update1))
        testHeaderU32_update2 = updateInfoCode(testHeaderU32_update1, INFO_CODE_BAD_HEADER)
        self.assertEqual(1, getInfoCode(testHeaderU32_update2))
        testHeaderU32_update3 = updateInfoCode(testHeaderU32_update2, 0xfffffffffffff)  # silly input
        self.assertEqual(INFO_CODE_REQUEST, getInfoCode(testHeaderU32_update3))
        self.assertEqual(testHeaderU32_orig, testHeaderU32_update3)  # if the silly input hasn't overwritten anything else, then update1 should equal update3
        
    def testSillyConstruction_fromComponents(self):
        testHeaderU32 = makeHeader(0xffb, 0xfa5a, 0xfe5, 0x777, 0x5a)
        self.assertEqual(0xba5ae57a, testHeaderU32)
    

'''
Tests for the ChipsBusBase/ChipsBusUdp classes (ChipsBus.py)

@author Robert Frazier

June 2010
'''

import unittest
from array import array
from ChipsBus import ChipsBusBase
from ChipsException import ChipsException
from TransactionElement import TransactionElement
from SerDes import SerDes

class Test_SerDes(unittest.TestCase):

    def setUp(self):
        pass

    def tearDown(self):
        pass

    def test_serialisation(self):
        # Tests that the serialiser is producing the expected result
        serdes = SerDes()
        arbitraryTransaction1 = TransactionElement(array('I', [0x0ddba115, 0xdeafbabe, 0xbeefcafe]))
        arbitraryTransaction2 = TransactionElement(array('I', [0x19283746, 0x12345678, 0x8181f0f0]))
        transactionElementList = [arbitraryTransaction1, arbitraryTransaction2]
        serialisedData = serdes.serialise(transactionElementList)
        # TEMPORARY IPBUS V2.x HACK!   Add a little-endian packet header of [0xf0000020] to the beginning of each packet.
        expectedResult = "\xf0\x00\x00\x20" \
                         "\x15\xa1\xdb\x0d\xbe\xba\xaf\xde\xfe\xca\xef\xbe" \
                         "\x46\x37\x28\x19\x78\x56\x34\x12\xf0\xf0\x81\x81"
        self.assertEqual(expectedResult, serialisedData)
    
    def test_deserilisation_throwsOnBadInputStringLength(self):
        # Tests that the deserialiser throws when given an input string that
        # cannot be translated into an integer number of 32-bit values.
        inputString_5bytes = "\xf0\x00\x00\x20\x11"
        inputString_6bytes = "\xf0\x00\x00\x20\x11\x22"
        inputString_7bytes = "\xf0\x00\x00\x20\x11\x22\x33"
        serdes = SerDes()
        self.assertRaises(ChipsException, serdes.deserialise, inputString_5bytes)
        self.assertRaises(ChipsException, serdes.deserialise, inputString_6bytes)
        self.assertRaises(ChipsException, serdes.deserialise, inputString_7bytes)
        
    def test_deserialisation_throwsOnMalformedIPbusPacket(self):
        # A valid packet in terms of integer number of 32-bit words, but it's
        # not a valid IPbus packet
        inputString = "\xf0\x00\x00\x20\x15\xa1\xdb\x07"
        serdes = SerDes()
        self.assertRaises(ChipsException, serdes.deserialise, inputString)
        
    def test_deserialisation_bigEndianValidIPbusPacket(self):
        # Tests big-endian deserialisation with big-endian byte-order header
        # TEMPORARY IPBUS V2.x HACK!   Add a packet header of [0x200000f0] to the beginning of each packet.
        inputString = "\x20\x00\x00\xf0" \
                      "\x20\x06\x0c\x0f\xba\x5e\xad\xd4"
        serdes = SerDes()
        blockReadTransaction_depth6 = TransactionElement(array('I', [0x20060c0f, 0xba5eadd4]))
        expectedResult = [blockReadTransaction_depth6]
        deserialisedResult = serdes.deserialise(inputString)
        # Have to delve into the content of each transaction element, as haven't
        # implemented a direct comparison of two transaction element objects.
        self.assertEqual(expectedResult[0].getAll(), deserialisedResult[0].getAll())

    def test_deserialisation_littleEndianValidIPbusPacket(self):
        # Tests little-endian deserialisation with little-endian byte-order header
        # TEMPORARY IPBUS V2.x HACK!   Add a little-endian packet header of [0xf0000020] to the beginning of each packet.
        inputString = "\xf0\x00\x00\x20" \
                      "\x0f\x0c\x06\x20\xd4\xad\x5e\xba"
        serdes = SerDes()
        blockReadTransaction_depth6 = TransactionElement(array('I', [0x20060c0f, 0xba5eadd4]))
        expectedResult = [blockReadTransaction_depth6]
        deserialisedResult = serdes.deserialise(inputString)
        # Have to delve into the content of each transaction element, as haven't
        # implemented a direct comparison of two transaction element objects.
        self.assertEqual(expectedResult[0].getAll(), deserialisedResult[0].getAll())

    def test_deserialiseThenSerialise_bigEndian(self):
        # Tests we get back what we started with, using a big-endian byte-order header
        # Specifically, this tests that the serialiser correctly remembers the
        # byte-order "state".  If the deserialiser does a byte-swap, then the serialiser
        # should also perform a byte-swap.  If deserialiser doesn't perform a byte-swap,
        # then neither does the serialiser.
        # TEMPORARY IPBUS V2.x HACK!   Add a packet header of [0x200000f0] to the beginning of each packet.
        originalInput = "\x20\x00\x00\xf0\x20\x06\x0c\x0f\xba\x5e\xad\xd4"
        serdes = SerDes()
        deserialisedData = serdes.deserialise(originalInput)
        reserialisedData = serdes.serialise(deserialisedData)
        self.assertEqual(originalInput, reserialisedData)

    def test_deserialiseThenSerialise_littleEndian(self):
        # Tests we get back what we started with, using a little-endian byte-order header
        # Specifically, this tests that the serialiser correctly remembers the
        # byte-order "state".  If the deserialiser does a byte-swap, then the serialiser
        # should also perform a byte-swap.  If deserialiser doesn't perform a byte-swap,
        # then neither does the serialiser.
        # TEMPORARY IPBUS V2.x HACK!   Add a packet header of [0x200000f0] to the beginning of each packet.
        originalInput = "\xf0\x00\x00\x20\x0f\x0c\x06\x20\xd4\xad\x5e\xba"
        serdes = SerDes()
        deserialisedData = serdes.deserialise(originalInput)
        reserialisedData = serdes.serialise(deserialisedData)
        self.assertEqual(originalInput, reserialisedData)

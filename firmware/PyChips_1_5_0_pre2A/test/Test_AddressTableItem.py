'''
Tests for the AddressTableItem class

@author Robert Frazier

June 2010
'''

import unittest
from AddressTableItem import AddressTableItem
from ChipsException import ChipsException


class Test_AddressTableItem(unittest.TestCase):

    def setUp(self):
        self.testObj = AddressTableItem("myRegisterName", 0x87654320, 0x00ff0000)

    def tearDown(self):
        pass

    def test_getName(self):
        self.setUp()
        self.assertEqual(self.testObj.getName(), "myRegisterName")
        
    def test_setName(self):
        self.setUp()
        self.testObj.setName("myOtherRegisterName")
        self.assertEqual(self.testObj.getName(), "myOtherRegisterName")

    def test_getAddress(self):
        self.setUp()
        self.assertEqual(self.testObj.getAddress(), 0x87654320)
    
    def test_setAddress(self):
        self.setUp()
        self.testObj.setAddress(0x0000000c)
        self.assertEqual(self.testObj.getAddress(), 0x0000000c)

    def test_getMask(self):
        self.setUp()
        self.assertEqual(self.testObj.getMask(), 0x00ff0000)

    def test_shiftDataFromMask_afterInit(self):
        self.setUp()
        self.assertEqual(self.testObj.shiftDataFromMask(0xffffffff), 0xff)

    def test_shiftDataToMask_afterInit(self):
        self.setUp()
        self.assertEqual(self.testObj.shiftDataToMask(0x81), 0x00810000)
    
    def test_shiftDataToMask_dataBiggerThanMask(self):
        self.setUp()
        self.assertRaises(ChipsException, self.testObj.shiftDataToMask, 0x100)

    def test_shiftDataToMask_dataBiggerThanMask2(self):
        # A shiftDataToMask bug was spotted during testing of another
        # module, so added this test to look for it explicitly.
        localTestObj = AddressTableItem("myRegisterName", 0xffff000c, 0xff000000)
        self.assertRaises(ChipsException, localTestObj.shiftDataToMask, 0x87654321)
        
    def test_setMask(self):
        self.setUp()
        self.testObj.setMask(0xe0000000)
        self.assertEqual(self.testObj.getMask(), 0xe0000000)
    
    def test_shiftDataFromMask_afterSetMask(self):
        self.setUp()
        self.testObj.setMask(0xe0000000)
        self.assertEqual(self.testObj.shiftDataFromMask(0xcfffffff), 0x6)

    def test_shiftDataToMask_afterSetMask(self):
        self.setUp()
        self.testObj.setMask(0xe0000000)
        self.assertEqual(self.testObj.shiftDataToMask(0x5), 0xa0000000)

    def test_setAddress_ignoreOversizeValue(self):
        self.setUp()
        self.testObj.setAddress(0xf87654320)
        self.assertEqual(self.testObj.getAddress(), 0x87654320)
        
    def test_setMask_ignoreOversizeValue(self):
        self.setUp()
        self.testObj.setMask(0xffffffffff)
        self.assertEqual(self.testObj.getMask(), 0xffffffff)
        
    def test_ignoreOversizeArgsOnInit(self):
        testObj = AddressTableItem("myRegister", 0xf00000000, 0xf0000ffff)
        self.assertEqual(testObj.getAddress(), 0x00000000)
        self.assertEqual(testObj.getMask(), 0x0000ffff)

    def test_getDefaultRWFlags(self):
        self.setUp()   #The AddressTableItem defined in setUp() has no RW flags defined so takes the default value of 1 for both
        self.assertEqual(self.testObj.getReadFlag(), 1)
        self.assertEqual(self.testObj.getWriteFlag(), 1)

    def test_getRWFlags(self):
        testObj = AddressTableItem("myRegisterName", 0x87654320, 0x00ff0000, 1, 0)
        self.assertEqual(testObj.getReadFlag(), 1)
        self.assertEqual(testObj.getWriteFlag(), 0)

    def test_setWriteFlag(self):
        testObj = AddressTableItem("myRegisterName", 0x87654320, 0x00ff0000, 1, 0)
        testObj.setWriteFlag(1)
        self.assertEqual(testObj.getWriteFlag(), 1)

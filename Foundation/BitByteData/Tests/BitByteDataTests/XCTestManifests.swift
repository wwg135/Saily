#if !canImport(ObjectiveC)
    import XCTest

    extension BigEndianByteReaderTests {
        // DO NOT MODIFY: This is autogenerated, use:
        //   `swift test --generate-linuxmain`
        // to regenerate.
        static let __allTests__BigEndianByteReaderTests = [
            ("testByte", testByte),
            ("testBytes", testBytes),
            ("testBytesLeft", testBytesLeft),
            ("testBytesRead", testBytesRead),
            ("testIntFromBytes", testIntFromBytes),
            ("testIsFinished", testIsFinished),
            ("testNonZeroStartIndex", testNonZeroStartIndex),
            ("testUint16", testUint16),
            ("testUint16FromBytes", testUint16FromBytes),
            ("testUint32", testUint32),
            ("testUint32FromBytes", testUint32FromBytes),
            ("testUint64", testUint64),
            ("testUint64FromBytes", testUint64FromBytes),
        ]
    }

    extension LittleEndianByteReaderTests {
        // DO NOT MODIFY: This is autogenerated, use:
        //   `swift test --generate-linuxmain`
        // to regenerate.
        static let __allTests__LittleEndianByteReaderTests = [
            ("testByte", testByte),
            ("testBytes", testBytes),
            ("testBytesLeft", testBytesLeft),
            ("testBytesRead", testBytesRead),
            ("testIntFromBytes", testIntFromBytes),
            ("testIsFinished", testIsFinished),
            ("testNonZeroStartIndex", testNonZeroStartIndex),
            ("testUint16", testUint16),
            ("testUint16FromBytes", testUint16FromBytes),
            ("testUint32", testUint32),
            ("testUint32FromBytes", testUint32FromBytes),
            ("testUint64", testUint64),
            ("testUint64FromBytes", testUint64FromBytes),
        ]
    }

    extension LsbBitReaderTests {
        // DO NOT MODIFY: This is autogenerated, use:
        //   `swift test --generate-linuxmain`
        // to regenerate.
        static let __allTests__LsbBitReaderTests = [
            ("testAdvance", testAdvance),
            ("testAlign", testAlign),
            ("testBit", testBit),
            ("testBitReaderByte", testBitReaderByte),
            ("testBitReaderBytes", testBitReaderBytes),
            ("testBitReaderIntFromBytes", testBitReaderIntFromBytes),
            ("testBitReaderNonZeroStartIndex", testBitReaderNonZeroStartIndex),
            ("testBitReaderUint16", testBitReaderUint16),
            ("testBitReaderUint32FromBytes", testBitReaderUint32FromBytes),
            ("testBits", testBits),
            ("testBitsLeft", testBitsLeft),
            ("testBitsRead", testBitsRead),
            ("testByteFromBits", testByteFromBits),
            ("testBytesLeft", testBytesLeft),
            ("testBytesRead", testBytesRead),
            ("testConvertedByteReader", testConvertedByteReader),
            ("testIntFromBits", testIntFromBits),
            ("testIsAligned", testIsAligned),
            ("testIsFinished", testIsFinished),
            ("testSignedIntFromBits_1C", testSignedIntFromBits_1C),
            ("testSignedIntFromBits_2C", testSignedIntFromBits_2C),
            ("testSignedIntFromBits_Biased_E1023", testSignedIntFromBits_Biased_E1023),
            ("testSignedIntFromBits_Biased_E127", testSignedIntFromBits_Biased_E127),
            ("testSignedIntFromBits_Biased_E3", testSignedIntFromBits_Biased_E3),
            ("testSignedIntFromBits_RN2", testSignedIntFromBits_RN2),
            ("testSignedIntFromBits_SM", testSignedIntFromBits_SM),
            ("testUint16FromBits", testUint16FromBits),
            ("testUint32FromBits", testUint32FromBits),
            ("testUint64FromBits", testUint64FromBits),
        ]
    }

    extension LsbBitWriterTests {
        // DO NOT MODIFY: This is autogenerated, use:
        //   `swift test --generate-linuxmain`
        // to regenerate.
        static let __allTests__LsbBitWriterTests = [
            ("testAlign", testAlign),
            ("testAppendByte", testAppendByte),
            ("testIsAligned", testIsAligned),
            ("testNamingConsistency", testNamingConsistency),
            ("testWriteBit", testWriteBit),
            ("testWriteBitsArray", testWriteBitsArray),
            ("testWriteNumber", testWriteNumber),
            ("testWriteSignedNumber_1C", testWriteSignedNumber_1C),
            ("testWriteSignedNumber_2C", testWriteSignedNumber_2C),
            ("testWriteSignedNumber_Biased_E1023", testWriteSignedNumber_Biased_E1023),
            ("testWriteSignedNumber_Biased_E127", testWriteSignedNumber_Biased_E127),
            ("testWriteSignedNumber_Biased_E3", testWriteSignedNumber_Biased_E3),
            ("testWriteSignedNumber_RN2", testWriteSignedNumber_RN2),
            ("testWriteSignedNumber_SM", testWriteSignedNumber_SM),
            ("testWriteUnsignedNumber", testWriteUnsignedNumber),
        ]
    }

    extension MsbBitReaderTests {
        // DO NOT MODIFY: This is autogenerated, use:
        //   `swift test --generate-linuxmain`
        // to regenerate.
        static let __allTests__MsbBitReaderTests = [
            ("testAdvance", testAdvance),
            ("testAlign", testAlign),
            ("testBit", testBit),
            ("testBitReaderByte", testBitReaderByte),
            ("testBitReaderBytes", testBitReaderBytes),
            ("testBitReaderIntFromBytes", testBitReaderIntFromBytes),
            ("testBitReaderNonZeroStartIndex", testBitReaderNonZeroStartIndex),
            ("testBitReaderUint16", testBitReaderUint16),
            ("testBitReaderUint32FromBytes", testBitReaderUint32FromBytes),
            ("testBits", testBits),
            ("testBitsLeft", testBitsLeft),
            ("testBitsRead", testBitsRead),
            ("testByteFromBits", testByteFromBits),
            ("testBytesLeft", testBytesLeft),
            ("testBytesRead", testBytesRead),
            ("testConvertedByteReader", testConvertedByteReader),
            ("testIntFromBits", testIntFromBits),
            ("testIsAligned", testIsAligned),
            ("testIsFinished", testIsFinished),
            ("testSignedIntFromBits_1C", testSignedIntFromBits_1C),
            ("testSignedIntFromBits_2C", testSignedIntFromBits_2C),
            ("testSignedIntFromBits_Biased_E1023", testSignedIntFromBits_Biased_E1023),
            ("testSignedIntFromBits_Biased_E127", testSignedIntFromBits_Biased_E127),
            ("testSignedIntFromBits_Biased_E3", testSignedIntFromBits_Biased_E3),
            ("testSignedIntFromBits_RN2", testSignedIntFromBits_RN2),
            ("testSignedIntFromBits_SM", testSignedIntFromBits_SM),
            ("testUint16FromBits", testUint16FromBits),
            ("testUint32FromBits", testUint32FromBits),
            ("testUint64FromBits", testUint64FromBits),
        ]
    }

    extension MsbBitWriterTests {
        // DO NOT MODIFY: This is autogenerated, use:
        //   `swift test --generate-linuxmain`
        // to regenerate.
        static let __allTests__MsbBitWriterTests = [
            ("testAlign", testAlign),
            ("testAppendByte", testAppendByte),
            ("testIsAligned", testIsAligned),
            ("testNamingConsistency", testNamingConsistency),
            ("testWriteBit", testWriteBit),
            ("testWriteBitsArray", testWriteBitsArray),
            ("testWriteNumber", testWriteNumber),
            ("testWriteSignedNumber_1C", testWriteSignedNumber_1C),
            ("testWriteSignedNumber_2C", testWriteSignedNumber_2C),
            ("testWriteSignedNumber_Biased_E1023", testWriteSignedNumber_Biased_E1023),
            ("testWriteSignedNumber_Biased_E127", testWriteSignedNumber_Biased_E127),
            ("testWriteSignedNumber_Biased_E3", testWriteSignedNumber_Biased_E3),
            ("testWriteSignedNumber_RN2", testWriteSignedNumber_RN2),
            ("testWriteSignedNumber_SM", testWriteSignedNumber_SM),
            ("testWriteUnsignedNumber", testWriteUnsignedNumber),
        ]
    }

    extension SignedNumberRepresentationTests {
        // DO NOT MODIFY: This is autogenerated, use:
        //   `swift test --generate-linuxmain`
        // to regenerate.
        static let __allTests__SignedNumberRepresentationTests = [
            ("testMaxRepresentableNumber_1C", testMaxRepresentableNumber_1C),
            ("testMaxRepresentableNumber_2C", testMaxRepresentableNumber_2C),
            ("testMaxRepresentableNumber_Biased_E1023", testMaxRepresentableNumber_Biased_E1023),
            ("testMaxRepresentableNumber_Biased_E127", testMaxRepresentableNumber_Biased_E127),
            ("testMaxRepresentableNumber_Biased_E3", testMaxRepresentableNumber_Biased_E3),
            ("testMaxRepresentableNumber_RN2", testMaxRepresentableNumber_RN2),
            ("testMaxRepresentableNumber_SM", testMaxRepresentableNumber_SM),
            ("testMinRepresentableNumber_1C", testMinRepresentableNumber_1C),
            ("testMinRepresentableNumber_2C", testMinRepresentableNumber_2C),
            ("testMinRepresentableNumber_Biased_E1023", testMinRepresentableNumber_Biased_E1023),
            ("testMinRepresentableNumber_Biased_E127", testMinRepresentableNumber_Biased_E127),
            ("testMinRepresentableNumber_Biased_E3", testMinRepresentableNumber_Biased_E3),
            ("testMinRepresentableNumber_RN2", testMinRepresentableNumber_RN2),
            ("testMinRepresentableNumber_SM", testMinRepresentableNumber_SM),
        ]
    }

    public func __allTests() -> [XCTestCaseEntry] {
        [
            testCase(BigEndianByteReaderTests.__allTests__BigEndianByteReaderTests),
            testCase(LittleEndianByteReaderTests.__allTests__LittleEndianByteReaderTests),
            testCase(LsbBitReaderTests.__allTests__LsbBitReaderTests),
            testCase(LsbBitWriterTests.__allTests__LsbBitWriterTests),
            testCase(MsbBitReaderTests.__allTests__MsbBitReaderTests),
            testCase(MsbBitWriterTests.__allTests__MsbBitWriterTests),
            testCase(SignedNumberRepresentationTests.__allTests__SignedNumberRepresentationTests),
        ]
    }
#endif
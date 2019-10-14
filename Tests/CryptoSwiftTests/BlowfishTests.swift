//
//  CryptoSwift
//
//  Copyright (C) 2014-2017 Marcin Krzyżanowski <marcin@krzyzanowskim.com>
//  This software is provided 'as-is', without any express or implied warranty.
//
//  In no event will the authors be held liable for any damages arising from the use of this software.
//
//  Permission is granted to anyone to use this software for any purpose,including commercial applications, and to alter it and redistribute it freely, subject to the following restrictions:
//
//  - The origin of this software must not be misrepresented; you must not claim that you wrote the original software. If you use this software in a product, an acknowledgment in the product documentation is required.
//  - Altered source versions must be plainly marked as such, and must not be misrepresented as being the original software.
//  - This notice may not be removed or altered from any source or binary distribution.
//

// Test vector from http://www.schneier.com/code/vectors.txt

@testable import CryptoSwift
import XCTest

class BlowfishTests: XCTestCase {
    struct TestData {
        let key: Array<UInt8>
        let input: Array<UInt8>
        let output: Array<UInt8>
    }

    let tests = [
        TestData(key: [0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00],
                 input: [0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00],
                 output: [0x4e, 0xf9, 0x97, 0x45, 0x61, 0x98, 0xdd, 0x78]),
        TestData(key: [0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff],
                 input: [0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff],
                 output: [0x51, 0x86, 0x6f, 0xd5, 0xb8, 0x5e, 0xcb, 0x8a]),
        TestData(key: [0x30, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00],
                 input: [0x10, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01],
                 output: [0x7d, 0x85, 0x6f, 0x9a, 0x61, 0x30, 0x63, 0xf2]),
        TestData(key: [0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11],
                 input: [0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11],
                 output: [0x24, 0x66, 0xdd, 0x87, 0x8b, 0x96, 0x3c, 0x9d]),

        TestData(key: [0x01, 0x23, 0x45, 0x67, 0x89, 0xab, 0xcd, 0xef],
                 input: [0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11],
                 output: [0x61, 0xf9, 0xc3, 0x80, 0x22, 0x81, 0xb0, 0x96]),

        TestData(key: [0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11],
                 input: [0x01, 0x23, 0x45, 0x67, 0x89, 0xab, 0xcd, 0xef],
                 output: [0x7d, 0x0c, 0xc6, 0x30, 0xaf, 0xda, 0x1e, 0xc7]),

        TestData(key: [0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00],
                 input: [0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00],
                 output: [0x4e, 0xf9, 0x97, 0x45, 0x61, 0x98, 0xdd, 0x78]),

        TestData(key: [0xfe, 0xdc, 0xba, 0x98, 0x76, 0x54, 0x32, 0x10],
                 input: [0x01, 0x23, 0x45, 0x67, 0x89, 0xab, 0xcd, 0xef],
                 output: [0x0a, 0xce, 0xab, 0x0f, 0xc6, 0xa0, 0xa2, 0x8d]),

        TestData(key: [0x7c, 0xa1, 0x10, 0x45, 0x4a, 0x1a, 0x6e, 0x57],
                 input: [0x01, 0xa1, 0xd6, 0xd0, 0x39, 0x77, 0x67, 0x42],
                 output: [0x59, 0xc6, 0x82, 0x45, 0xeb, 0x05, 0x28, 0x2b]),

        TestData(key: [0x01, 0x31, 0xd9, 0x61, 0x9d, 0xc1, 0x37, 0x6e],
                 input: [0x5c, 0xd5, 0x4c, 0xa8, 0x3d, 0xef, 0x57, 0xda],
                 output: [0xb1, 0xb8, 0xcc, 0x0b, 0x25, 0x0f, 0x09, 0xa0]),

        TestData(key: [0x07, 0xa1, 0x13, 0x3e, 0x4a, 0x0b, 0x26, 0x86],
                 input: [0x02, 0x48, 0xd4, 0x38, 0x06, 0xf6, 0x71, 0x72],
                 output: [0x17, 0x30, 0xe5, 0x77, 0x8b, 0xea, 0x1d, 0xa4]),

        TestData(key: [0x38, 0x49, 0x67, 0x4c, 0x26, 0x02, 0x31, 0x9e],
                 input: [0x51, 0x45, 0x4b, 0x58, 0x2d, 0xdf, 0x44, 0x0a],
                 output: [0xa2, 0x5e, 0x78, 0x56, 0xcf, 0x26, 0x51, 0xeb]),

        TestData(key: [0x04, 0xb9, 0x15, 0xba, 0x43, 0xfe, 0xb5, 0xb6],
                 input: [0x42, 0xfd, 0x44, 0x30, 0x59, 0x57, 0x7f, 0xa2],
                 output: [0x35, 0x38, 0x82, 0xb1, 0x09, 0xce, 0x8f, 0x1a]),

        TestData(key: [0x01, 0x13, 0xb9, 0x70, 0xfd, 0x34, 0xf2, 0xce],
                 input: [0x05, 0x9b, 0x5e, 0x08, 0x51, 0xcf, 0x14, 0x3a],
                 output: [0x48, 0xf4, 0xd0, 0x88, 0x4c, 0x37, 0x99, 0x18]),

        TestData(key: [0x01, 0x70, 0xf1, 0x75, 0x46, 0x8f, 0xb5, 0xe6],
                 input: [0x07, 0x56, 0xd8, 0xe0, 0x77, 0x47, 0x61, 0xd2],
                 output: [0x43, 0x21, 0x93, 0xb7, 0x89, 0x51, 0xfc, 0x98]),

        TestData(key: [0x43, 0x29, 0x7f, 0xad, 0x38, 0xe3, 0x73, 0xfe],
                 input: [0x76, 0x25, 0x14, 0xb8, 0x29, 0xbf, 0x48, 0x6a],
                 output: [0x13, 0xf0, 0x41, 0x54, 0xd6, 0x9d, 0x1a, 0xe5]),

        TestData(key: [0x07, 0xa7, 0x13, 0x70, 0x45, 0xda, 0x2a, 0x16],
                 input: [0x3b, 0xdd, 0x11, 0x90, 0x49, 0x37, 0x28, 0x02],
                 output: [0x2e, 0xed, 0xda, 0x93, 0xff, 0xd3, 0x9c, 0x79]),

        TestData(key: [0x04, 0x68, 0x91, 0x04, 0xc2, 0xfd, 0x3b, 0x2f],
                 input: [0x26, 0x95, 0x5f, 0x68, 0x35, 0xaf, 0x60, 0x9a],
                 output: [0xd8, 0x87, 0xe0, 0x39, 0x3c, 0x2d, 0xa6, 0xe3]),

        TestData(key: [0x37, 0xd0, 0x6b, 0xb5, 0x16, 0xcb, 0x75, 0x46],
                 input: [0x16, 0x4d, 0x5e, 0x40, 0x4f, 0x27, 0x52, 0x32],
                 output: [0x5f, 0x99, 0xd0, 0x4f, 0x5b, 0x16, 0x39, 0x69]),

        TestData(key: [0x1f, 0x08, 0x26, 0x0d, 0x1a, 0xc2, 0x46, 0x5e],
                 input: [0x6b, 0x05, 0x6e, 0x18, 0x75, 0x9f, 0x5c, 0xca],
                 output: [0x4a, 0x05, 0x7a, 0x3b, 0x24, 0xd3, 0x97, 0x7b]),

        TestData(key: [0x58, 0x40, 0x23, 0x64, 0x1a, 0xba, 0x61, 0x76],
                 input: [0x00, 0x4b, 0xd6, 0xef, 0x09, 0x17, 0x60, 0x62],
                 output: [0x45, 0x20, 0x31, 0xc1, 0xe4, 0xfa, 0xda, 0x8e]),

        TestData(key: [0x02, 0x58, 0x16, 0x16, 0x46, 0x29, 0xb0, 0x07],
                 input: [0x48, 0x0d, 0x39, 0x00, 0x6e, 0xe7, 0x62, 0xf2],
                 output: [0x75, 0x55, 0xae, 0x39, 0xf5, 0x9b, 0x87, 0xbd]),

        TestData(key: [0x49, 0x79, 0x3e, 0xbc, 0x79, 0xb3, 0x25, 0x8f],
                 input: [0x43, 0x75, 0x40, 0xc8, 0x69, 0x8f, 0x3c, 0xfa],
                 output: [0x53, 0xc5, 0x5f, 0x9c, 0xb4, 0x9f, 0xc0, 0x19]),

        TestData(key: [0x4f, 0xb0, 0x5e, 0x15, 0x15, 0xab, 0x73, 0xa7],
                 input: [0x07, 0x2d, 0x43, 0xa0, 0x77, 0x07, 0x52, 0x92],
                 output: [0x7a, 0x8e, 0x7b, 0xfa, 0x93, 0x7e, 0x89, 0xa3]),

        TestData(key: [0x49, 0xe9, 0x5d, 0x6d, 0x4c, 0xa2, 0x29, 0xbf],
                 input: [0x02, 0xfe, 0x55, 0x77, 0x81, 0x17, 0xf1, 0x2a],
                 output: [0xcf, 0x9c, 0x5d, 0x7a, 0x49, 0x86, 0xad, 0xb5]),

        TestData(key: [0x01, 0x83, 0x10, 0xdc, 0x40, 0x9b, 0x26, 0xd6],
                 input: [0x1d, 0x9d, 0x5c, 0x50, 0x18, 0xf7, 0x28, 0xc2],
                 output: [0xd1, 0xab, 0xb2, 0x90, 0x65, 0x8b, 0xc7, 0x78]),

        TestData(key: [0x1c, 0x58, 0x7f, 0x1c, 0x13, 0x92, 0x4f, 0xef],
                 input: [0x30, 0x55, 0x32, 0x28, 0x6d, 0x6f, 0x29, 0x5a],
                 output: [0x55, 0xcb, 0x37, 0x74, 0xd1, 0x3e, 0xf2, 0x01]),

        TestData(key: [0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01],
                 input: [0x01, 0x23, 0x45, 0x67, 0x89, 0xab, 0xcd, 0xef],
                 output: [0xfa, 0x34, 0xec, 0x48, 0x47, 0xb2, 0x68, 0xb2]),

        TestData(key: [0x1f, 0x1f, 0x1f, 0x1f, 0x0e, 0x0e, 0x0e, 0x0e],
                 input: [0x01, 0x23, 0x45, 0x67, 0x89, 0xab, 0xcd, 0xef],
                 output: [0xa7, 0x90, 0x79, 0x51, 0x08, 0xea, 0x3c, 0xae]),

        TestData(key: [0xe0, 0xfe, 0xe0, 0xfe, 0xf1, 0xfe, 0xf1, 0xfe],
                 input: [0x01, 0x23, 0x45, 0x67, 0x89, 0xab, 0xcd, 0xef],
                 output: [0xc3, 0x9e, 0x07, 0x2d, 0x9f, 0xac, 0x63, 0x1d]),

        TestData(key: [0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00],
                 input: [0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff],
                 output: [0x01, 0x49, 0x33, 0xe0, 0xcd, 0xaf, 0xf6, 0xe4]),

        TestData(key: [0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff],
                 input: [0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00],
                 output: [0xf2, 0x1e, 0x9a, 0x77, 0xb7, 0x1c, 0x49, 0xbc]),

        TestData(key: [0x01, 0x23, 0x45, 0x67, 0x89, 0xab, 0xcd, 0xef],
                 input: [0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00],
                 output: [0x24, 0x59, 0x46, 0x88, 0x57, 0x54, 0x36, 0x9a]),

        TestData(key: [0xfe, 0xdc, 0xba, 0x98, 0x76, 0x54, 0x32, 0x10],
                 input: [0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff],
                 output: [0x6b, 0x5c, 0x5a, 0x9c, 0x5d, 0x9e, 0x0a, 0x5a])
    ]

    func testEncrypt() {
        for test in tests {
            XCTAssertEqual(try Blowfish(key: test.key, blockMode: ECB(), padding: .noPadding).encrypt(test.input), test.output)
        }
    }

    func testDecrypt() {
        for test in tests {
            XCTAssertEqual(try Blowfish(key: test.key, blockMode: ECB(), padding: .noPadding).decrypt(test.output), test.input)
        }
    }

    func testCBCZeroPadding() {
        let key = Array<UInt8>(hex: "0123456789ABCDEFF0E1D2C3B4A59687")
        let iv = Array<UInt8>(hex: "FEDCBA9876543210")
        let input = Array<UInt8>(hex: "37363534333231204E6F77206973207468652074696D6520666F722000")
        XCTAssertEqual(try Blowfish(key: key, blockMode: CBC(iv: iv), padding: .zeroPadding).encrypt(input), Array<UInt8>(hex: "6B77B4D63006DEE605B156E27403979358DEB9E7154616D959F1652BD5FF92CC"))
    }

    func testEncryptDecrypt() {
        let key = Array<UInt8>.init(hex: "0123456789ABCDEFF0E1D2C3B4A59687")
        let iv = Array<UInt8>.init(hex: "FEDCBA9876543210")
        let input = Array<UInt8>.init(hex: "37363534333231204E6F77206973207468652074696D6520666F722000")

        do {
            let cipher = try Blowfish(key: key, blockMode: CBC(iv: iv), padding: .pkcs7)
            let ciphertext = try cipher.encrypt(input)
            let plaintext = try cipher.decrypt(ciphertext)
            XCTAssertEqual(plaintext, input)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }

    // https://github.com/krzyzanowskim/CryptoSwift/issues/415
    func testDecryptCFB415() {
        do {
            let plaintext = "secret12".bytes
            let key = "passwordpassword".bytes
            let iv = "12345678".bytes
            let encrypted = try Blowfish(key: key, blockMode: CFB(iv: iv), padding: .noPadding).encrypt(plaintext)
            let decrypted = try Blowfish(key: key, blockMode: CFB(iv: iv), padding: .noPadding).decrypt(encrypted)
            XCTAssertEqual(plaintext, decrypted)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
}

extension BlowfishTests {
    static func allTests() -> [(String, (BlowfishTests) -> () -> Void)] {
        let tests = [
            ("testEncrypt", testEncrypt),
            ("testDecrypt", testDecrypt),
            ("testCBCZeroPadding", testCBCZeroPadding),
            ("testEncryptDecrypt", testEncryptDecrypt),
            ("testDecryptCFB415", testDecryptCFB415)
        ]
        return tests
    }
}

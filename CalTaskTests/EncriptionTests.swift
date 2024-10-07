//
//  EncriptionTests.swift
//  CalTaskTests
//
//  Created by israel water-io on 07/10/2024.
//

import XCTest
import CryptoKit
@testable import CalTask

final class EncriptionTests: XCTestCase {

    // Test case for encryption and decryption flow
    func testStringEncryptionAndDecryption() throws {
        let originalString = "Sensitive Data for Unit Test!"
        
        // Encrypt the string
        guard let encryptedString = originalString.encrypt() else {
            XCTFail("Encryption failed")
            return
        }
        
        print("Encrypted String: \(encryptedString)")
        
        // Decrypt the string
        guard let decryptedString = encryptedString.decrypt() else {
            XCTFail("Decryption failed")
            return
        }
        
        print("Decrypted String: \(decryptedString)")
        
        // Assert that the decrypted string matches the original string
        XCTAssertEqual(originalString, decryptedString, "Decrypted string should match the original")
    }
    
    // Test case for failed decryption with invalid data
    func testDecryptionWithInvalidData() throws {
        let invalidEncryptedString = "InvalidData"
        
        // Attempt to decrypt invalid data
        let decryptedString = invalidEncryptedString.decrypt()
        
        // Assert that decryption fails and returns nil
        XCTAssertNil(decryptedString, "Decryption should fail with invalid data")
    }
}

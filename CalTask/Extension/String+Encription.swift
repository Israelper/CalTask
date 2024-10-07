//
//  Encription+Extension.swift
//  CalTask
//
//  Created by israel water-io on 06/10/2024.
//

import Foundation
import CryptoKit
/**
 This extension adds encryption and decryption functionalities to the `String` class using AES-GCM encryption.
 The symmetric key is stored as a static variable, and the extension provides methods to encrypt a string and return
 a Base64-encoded ciphertext, as well as decrypt a Base64-encoded ciphertext back into a plain string.
 */
extension String {
    private static var key: SymmetricKey = CryptoManager.generateKey()

    func encrypt() -> String? {
        guard let data = self.data(using: .utf8) else { return nil }
        
        do {
            let nonce = AES.GCM.Nonce()
            let sealedBox = try AES.GCM.seal(data, using: String.key, nonce: nonce)
            
            var combinedData = Data()
            combinedData.append(nonce.withUnsafeBytes { Data($0) })
            combinedData.append(sealedBox.ciphertext)
            combinedData.append(sealedBox.tag)
            
            return combinedData.base64EncodedString()
        } catch {
            print("Encryption error: \(error)")
            return nil
        }
    }

    func decrypt() -> String? {
        guard let combinedData = Data(base64Encoded: self) else { return nil }
        
        let nonceSize = 12
        let tagSize = 16
        
        let nonceData = combinedData.prefix(nonceSize)
        let ciphertextData = combinedData.dropFirst(nonceSize).dropLast(tagSize)
        let tagData = combinedData.suffix(tagSize)
        
        do {
            let nonce = try AES.GCM.Nonce(data: nonceData)
            let sealedBox = try AES.GCM.SealedBox(nonce: nonce, ciphertext: ciphertextData, tag: tagData)
            let decryptedData = try AES.GCM.open(sealedBox, using: String.key)
            
            return String(data: decryptedData, encoding: .utf8)
        } catch {
            print("Decryption error: \(error)")
            return nil
        }
    }
}

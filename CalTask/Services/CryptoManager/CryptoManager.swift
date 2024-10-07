//
//  CryptoManager.swift
//  CalTask
//
//  Created by israel water-io on 07/10/2024.
//

import Foundation
import CryptoKit
/**
 This class, `CryptoManager`, handles encryption and decryption of strings using AES-GCM symmetric key encryption.
 It provides functionality to generate a symmetric key, encrypt a string, and decrypt the ciphertext.
 The class uses a random nonce and includes error handling for both encryption and decryption processes.
 */
class CryptoManager {
    private let key: SymmetricKey
    
    init(key: SymmetricKey) {
        self.key = key
    }
    
    static func generateKey() -> SymmetricKey {
        return SymmetricKey(size: .bits256)
    }
    
    func encrypt(_ string: String) -> (ciphertext: Data, tag: Data, nonce: AES.GCM.Nonce)? {
        guard let data = string.data(using: .utf8) else { return nil }
        
        do {
            let nonce = AES.GCM.Nonce()
            let sealedBox = try AES.GCM.seal(data, using: key, nonce: nonce)
            return (sealedBox.ciphertext, sealedBox.tag, nonce)
        } catch {
            print("Encryption error: \(error)")
            return nil
        }
    }
    
    func decrypt(ciphertext: Data, tag: Data, nonce: AES.GCM.Nonce) -> String? {
        do {
            let sealedBox = try AES.GCM.SealedBox(nonce: nonce, ciphertext: ciphertext, tag: tag)
            let decryptedData = try AES.GCM.open(sealedBox, using: key)
            return String(data: decryptedData, encoding: .utf8)
        } catch {
            print("Decryption error: \(error)")
            return nil
        }
    }
}

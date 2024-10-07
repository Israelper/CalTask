//
//  BiometricManager.swift
//  CalTask
//
//  Created by israel water-io on 06/10/2024.
//

import Foundation
import LocalAuthentication

protocol BiometricAuthentication {
    func authenticateUser(completion: @escaping (Bool, Error?) -> Void)
}

class BiometricManager: BiometricAuthentication {

    static let shared = BiometricManager()

    private init() {}

    func authenticateUser(completion: @escaping (Bool, Error?) -> Void) {
        let context = LAContext()
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Authenticate to access secure data"
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, evaluationError in
                DispatchQueue.main.async {
                    if success {
                        completion(true, nil)
                    } else {
                        completion(false, evaluationError)
                    }
                }
            }
        } else {
            DispatchQueue.main.async {
                completion(false, error)
            }
        }
    }
}

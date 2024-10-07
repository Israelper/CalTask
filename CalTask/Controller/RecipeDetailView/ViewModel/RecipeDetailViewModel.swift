//
//  RecipeDetailViewModel.swift
//  CalTask
//
//  Created by israel water-io on 06/10/2024.
//

import Foundation
import Combine

class RecipeDetailViewModel {
    private let recipe: Recipe
    private let biometricAuth: BiometricAuthentication

    @Published var currentRecipe: Recipe?
    private var cancellables = Set<AnyCancellable>()

    var isDataEncrypted = true

    init(recipe: Recipe, biometricAuth: BiometricAuthentication = BiometricManager.shared) {
        self.recipe = recipe.encrypt()
        self.biometricAuth = biometricAuth
        self.currentRecipe = recipe.encrypt()
    }

    func decryptDetails() -> Future<Recipe?, Never> {
        return Future { promise in
            self.biometricAuth.authenticateUser { [weak self] success, error in
                guard let self = self else {
                    promise(.success(nil))
                    return
                }
                if success {
                    self.isDataEncrypted = false
                    let decryptedRecipe = self.recipe.decrypt()
                    self.currentRecipe = decryptedRecipe 
                    promise(.success(decryptedRecipe))
                } else {
                    promise(.success(nil))
                }
            }
        }
    }
}

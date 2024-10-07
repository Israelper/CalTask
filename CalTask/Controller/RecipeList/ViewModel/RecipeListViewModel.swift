//
//  RecipeListViewModel.swift
//  CalTask
//
//  Created by israel water-io on 06/10/2024.
//

import Foundation
import Combine

class RecipeListViewModel {
    @Published private(set) var recipes: [Recipe] = []
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var errorMessage: String?
    @Published private(set) var recipeSelected: Recipe?

    private let networkManager: RecipesProvider

    init(networkManager: RecipesProvider) {
        self.networkManager = networkManager
    }

    func fetchRecipes()  {
        isLoading = true
        errorMessage = nil

        Task() { [weak self] in
            guard let self else { return }
            do {
                let response = try await networkManager.request()
                await MainActor.run {
                    self.recipes = response
                    self.isLoading = false
                }
            } catch {
                await MainActor.run {
                    self.errorMessage = "Failed to load recipes: \(error.localizedDescription)"
                    self.isLoading = false
                    self.recipes = []  
                }
            }
        }
    }

    func didSelectRecipe(at index: Int) {
        let recipe = recipes[index]
        recipeSelected = recipe
    }
}

//
//  MainCoordinator.swift
//  CalTask
//
//  Created by israel water-io on 06/10/2024.
//


import UIKit
import SwiftUI
import Combine

class MainCoordinator: Coordinator {
    // MARK: - Properties
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    private var onFinshedCancelable : AnyCancellable?

    private let dataManager: AppDataManager
    
    // MARK: - Life cycle
    init(navigationController: UINavigationController, dataManager: AppDataManager) {
        self.navigationController = navigationController
        self.dataManager = dataManager
    }
}

// MARK: - API
extension MainCoordinator {
    func start() {
        let viewModel = RecipeListViewModel(networkManager: dataManager.networkManager)
        let viewController = RecipeListViewController(viewModel: viewModel)
        onFinshedCancelable = viewModel.$recipeSelected
            .sink { [weak self] item in
                guard let item else {return }
                self?.showRecipeDetail(recipe: item)
            }
        
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func showRecipeDetail(recipe: Recipe) {
        let recipeDetailView = RecipeDetailViewController(viewModel: RecipeDetailViewModel(recipe: recipe))
        navigationController.pushViewController(recipeDetailView, animated: true)
    }
}

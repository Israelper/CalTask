//
//  AppCoordinator.swift
//  CalTask
//
//  Created by israel water-io on 06/10/2024.
//


import UIKit

class AppCoordinator: Coordinator {
    // MARK: - Properties
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    // MARK: - Life cycle
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}

// MARK: - API
extension AppCoordinator {
    func start() {
        let coordinator = MainCoordinator(navigationController: navigationController, dataManager: AppDataManager())
        coordinator.start()
        childCoordinators.append(coordinator)
    }
}

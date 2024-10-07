//
//  Coordinator.swift
//  CalTask
//
//  Created by israel water-io on 06/10/2024.
//

import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }

    func start()
}

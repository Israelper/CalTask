//
//  AppDataManager.swift
//  CalTask
//
//  Created by israel water-io on 06/10/2024.
//

import Foundation

final class AppDataManager {

    lazy var networkManager = {
        return RecipesProvider(networkManager:  NetworkManager())
    }()
    
}

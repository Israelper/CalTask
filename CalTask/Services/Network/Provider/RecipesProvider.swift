//
//  RecipesProvider.swift
//  CalTask
//
//  Created by israel water-io on 06/10/2024.
//

import Foundation

public protocol RecipesProviderProtocol {
    func request() async throws -> [Recipe]
}

public class RecipesProvider {
    private let baseURL = "https://hf-android-app.s3-eu-west-1.amazonaws.com/android-test/recipes.json"
    
    
    public let networkManager: NetworkManagerProtocol
    
    public init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
}

extension RecipesProvider: RecipesProviderProtocol {
    public func request() async throws -> [Recipe] {
        guard  let url = URL(string: baseURL) else {
            throw Error.internal
        }
        
        let data = try await networkManager.fetch(from: url)
        let decoder = JSONDecoder()
        return try decoder.decode([Recipe].self, from: data)
    }
}

// MARK: Error
extension RecipesProvider {
    enum Error: Swift.Error {
        case `internal`
    }
}

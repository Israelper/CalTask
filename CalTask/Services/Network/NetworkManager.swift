//
//  NetworkManager.swift
//  CalTask
//
//  Created by israel water-io on 06/10/2024.
//

import Foundation

public class NetworkManager {
    // MARK: - Properties
    private let validStatus = 200...299
    private let urlSession = URLSession.shared
    
    // MARK: - Life cycle
    public init () { }
}

extension NetworkManager: NetworkManagerProtocol {
   
    public func fetch(from url: URL) async throws -> Data {
        guard let (data, response) = try await urlSession.data(from: url, delegate: nil) as? (Data, HTTPURLResponse),
              validStatus.contains(response.statusCode) else {
            throw Error.networkError
        }
        return data
    }
}

// MARK: Error
extension NetworkManager {
    enum Error: Swift.Error {
        case networkError
    }
}


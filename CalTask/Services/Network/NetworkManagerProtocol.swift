//
//  NetworkManagerProtocol.swift
//  CalTask
//
//  Created by israel water-io on 06/10/2024.
//

import Foundation


public protocol NetworkManagerProtocol {
    func fetch(from url: URL) async throws -> Data
}

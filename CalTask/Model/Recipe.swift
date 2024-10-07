//
//  Recipe.swift
//  CalTask
//
//  Created by israel water-io on 06/10/2024.
//

import Foundation

public struct Recipe: Codable {
    public let id: String
    public let name: String
    public let thumb: String
    public let image: String
    public let fats: String
    public let calories: String
    public let carbos: String
    public let description: String
}

//
//  Recipt+Encription.swift
//  CalTask
//
//  Created by israel water-io on 07/10/2024.
//

import Foundation

extension Recipe {
    func encrypt() -> Recipe {
        return Recipe(
            id: encrypt(id),
            name: encrypt(name),
            thumb: encrypt(thumb),
            image: encrypt(image),
            fats: encrypt(fats),
            calories: encrypt(calories),
            carbos: encrypt(carbos),
            description: encrypt(description)
        )
    }
    
    func decrypt() -> Recipe {
        return Recipe(
            id: decrypt(id),
            name: decrypt(name),
            thumb: decrypt(thumb),
            image: decrypt(image),
            fats: decrypt(fats),
            calories: decrypt(calories),
            carbos: decrypt(carbos),
            description: decrypt(description)
        )
    }
    
    private func encrypt(_ text: String) -> String {
        return text.encrypt() ?? ""
    }
    
    private func decrypt(_ text: String) -> String {
        return text.decrypt() ?? ""
    }
}

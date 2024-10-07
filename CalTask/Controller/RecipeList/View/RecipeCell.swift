//
//  RecipeCell.swift
//  CalTask
//
//  Created by israel water-io on 06/10/2024.
//

import UIKit

class RecipeCell: UITableViewCell {
    
    static let identifier = "RecipeCell"
    
    private let thumbImageView: NetworkImage = {
        let imageView = NetworkImage()
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.numberOfLines = 1
        return label
    }()
    
    private let fatsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 1
        return label
    }()
    
    private let caloriesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 1
        return label
    }()
    
    private let carbsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 1
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCellUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with recipe: Recipe) {
        nameLabel.text = recipe.name
        fatsLabel.text = "Fats: \(recipe.fats)"
        caloriesLabel.text = "Calories: \(recipe.calories)"
        carbsLabel.text = "Carbs: \(recipe.carbos)"
        
        if let url = URL(string: recipe.thumb) {
            self.thumbImageView.loadImage(from: url)
        }
    }
    
    private func setupCellUI() {
        contentView.addSubview(thumbImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(fatsLabel)
        contentView.addSubview(caloriesLabel)
        contentView.addSubview(carbsLabel)
        
        thumbImageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        fatsLabel.translatesAutoresizingMaskIntoConstraints = false
        caloriesLabel.translatesAutoresizingMaskIntoConstraints = false
        carbsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            thumbImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            thumbImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            thumbImageView.widthAnchor.constraint(equalToConstant: 80),
            thumbImageView.heightAnchor.constraint(equalToConstant: 80),
            
            nameLabel.leadingAnchor.constraint(equalTo: thumbImageView.trailingAnchor, constant: 16),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            fatsLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            fatsLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            
            caloriesLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            caloriesLabel.topAnchor.constraint(equalTo: fatsLabel.bottomAnchor, constant: 4),
            
            carbsLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            carbsLabel.topAnchor.constraint(equalTo: caloriesLabel.bottomAnchor, constant: 4),
            carbsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
}

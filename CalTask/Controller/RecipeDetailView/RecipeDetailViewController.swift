//
//  RecipeDetailViewController.swift
//  CalTask
//
//  Created by israel water-io on 06/10/2024.
//

import UIKit
import Combine

class RecipeDetailViewController: UIViewController {
    private let viewModel: RecipeDetailViewModel
    private var textView: UITextView!
    private var networkImageView: NetworkImage!
    
    private var cancellables = Set<AnyCancellable>()

    init(viewModel: RecipeDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()

        
//        displayRecipeDetails(viewModel.currentRecipe)

        observeRecipeChanges()

        authenticateAndDecrypt()
    }

    private func setupView() {
        networkImageView = NetworkImage()
        networkImageView.translatesAutoresizingMaskIntoConstraints = false

        textView = UITextView(frame: .zero)
        textView.isEditable = false
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(networkImageView)
        view.addSubview(textView)

        NSLayoutConstraint.activate([
            networkImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            networkImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            networkImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            networkImageView.heightAnchor.constraint(equalToConstant: 200),

            textView.topAnchor.constraint(equalTo: networkImageView.bottomAnchor, constant: 16),
            textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            textView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
    }

    private func observeRecipeChanges() {
        viewModel.$currentRecipe
            .compactMap { $0 }  
            .sink { [weak self] recipe in
                self?.displayRecipeDetails(recipe)
            }
            .store(in: &cancellables)
    }

    private func displayRecipeDetails(_ recipe: Recipe) {
        textView.text = """
        Name: \(recipe.name)
        Fats: \(recipe.fats)
        Calories: \(recipe.calories)
        Carbs: \(recipe.carbos)
        Description: \(recipe.description)
        """

        if let url = URL(string: recipe.thumb) {
            networkImageView.loadImage(from: url)
        }
    }

    private func authenticateAndDecrypt() {
        viewModel.decryptDetails()
            .sink { [weak self] decryptedRecipe in
                if decryptedRecipe == nil {
                    self?.showAuthenticationFailedAlert()
                }
            }
            .store(in: &cancellables)
    }

    private func showAuthenticationFailedAlert() {
        let alert = UIAlertController(title: "Authentication Failed",
                                      message: "Unable to decrypt the recipe details without authentication.",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

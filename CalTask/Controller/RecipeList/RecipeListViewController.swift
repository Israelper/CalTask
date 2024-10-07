//
//  RecipeListView.swift
//  CalTask
//
//  Created by israel water-io on 06/10/2024.
//

import UIKit
import UIKit
import Combine

class RecipeListViewController: UIViewController {
    private let viewModel: RecipeListViewModel
    private var tableView: UITableView!
    private var activityIndicator: UIActivityIndicatorView!
    private var errorLabel: UILabel!

    private var cancellables = Set<AnyCancellable>()

    init(viewModel: RecipeListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupLoadingIndicator()
        setupErrorLabel()
        setupBindings()
        viewModel.fetchRecipes()
    }

    private func setupTableView() {
        tableView = UITableView(frame: view.bounds)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(RecipeCell.self, forCellReuseIdentifier: RecipeCell.identifier)
        view.addSubview(tableView)
        tableView.isHidden = true
    }

    private func setupLoadingIndicator() {
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
    }

    private func setupErrorLabel() {
        errorLabel = UILabel()
        errorLabel.textColor = .red
        errorLabel.textAlignment = .center
        errorLabel.numberOfLines = 0
        errorLabel.frame = CGRect(x: 0, y: 0, width: view.bounds.width - 40, height: 100)
        errorLabel.center = view.center
        errorLabel.isHidden = true
        view.addSubview(errorLabel)
    }

    private func setupBindings() {
        viewModel.$recipes
            .receive(on: DispatchQueue.main)
            .sink { [weak self] recipes in
                guard let self else { return }
                self.tableView.reloadData()
                self.tableView.isHidden = recipes.isEmpty
            }
            .store(in: &cancellables)

        viewModel.$isLoading
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isLoading in
                guard let self else { return }
                if isLoading {
                    self.activityIndicator.startAnimating()
                    self.tableView.isHidden = true
                    self.errorLabel.isHidden = true
                } else {
                    self.activityIndicator.stopAnimating()
                }
            }
            .store(in: &cancellables)

        viewModel.$errorMessage
            .receive(on: DispatchQueue.main)
            .sink { [weak self] errorMessage in
                guard let self else { return }
                if let errorMessage = errorMessage {
                    self.errorLabel.text = errorMessage
                    self.errorLabel.isHidden = false
                    self.tableView.isHidden = true
                } else {
                    self.errorLabel.isHidden = true  
                }
            }
            .store(in: &cancellables)
    }
}

extension RecipeListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RecipeCell.identifier, for: indexPath) as? RecipeCell else {
            return UITableViewCell()
        }
        let recipe = viewModel.recipes[indexPath.row]
        cell.configure(with: recipe)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectRecipe(at: indexPath.row)
    }
}

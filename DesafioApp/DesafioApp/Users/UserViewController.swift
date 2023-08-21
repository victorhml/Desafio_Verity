//
//  UserViewController.swift
//  DesafioApp
//
//  Created by Victor Hugo Martins Lisboa on 18/08/23.
//

import UIKit

class UserViewController: UIViewController {
    
    let viewModel = UserViewModel()
    var users = [UserModel]()
    var searchedUsers = [UserModel]()
    var isSearching = false
    
    private lazy var loadingView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var loadingActivityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
    private lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Não foi possível carregar a lista de usuários"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.showsCancelButton = true
        searchBar.placeholder = "Nome do usuário"
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).tintColor = .darkGray
        return searchBar
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Usuários"
        view.backgroundColor = .white
        setupLoadingView()
        setupLoadingActivityIndicator()
        fillData()
    }
    
    private func setupLoadingView() {
        view.addSubview(loadingView)
        NSLayoutConstraint.activate([
            loadingView.topAnchor.constraint(equalTo: view.topAnchor),
            loadingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loadingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loadingView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupLoadingActivityIndicator() {
        loadingView.addSubview(loadingActivityIndicator)
        loadingActivityIndicator.startAnimating()
        NSLayoutConstraint.activate([
            loadingActivityIndicator.centerXAnchor.constraint(equalTo: loadingView.centerXAnchor),
            loadingActivityIndicator.centerYAnchor.constraint(equalTo: loadingView.centerYAnchor)
        ])
    }
    
    private func setupErrorLabel() {
        loadingActivityIndicator.removeFromSuperview()
        loadingView.addSubview(errorLabel)
        NSLayoutConstraint.activate([
            errorLabel.leadingAnchor.constraint(equalTo: loadingView.leadingAnchor, constant: 20),
            errorLabel.trailingAnchor.constraint(equalTo: loadingView.trailingAnchor, constant: -20),
            errorLabel.centerYAnchor.constraint(equalTo: loadingView.centerYAnchor)
        ])
    }
    
    private func setupSearchBar() {
        view.addSubview(searchBar)
        searchBar.delegate = self
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    private func setupTableView() {
        loadingView.removeFromSuperview()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UserCell")
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func getImage(urlImageString: String) -> UIImage {
        
        var image = UIImage(systemName: "person.fill") ?? UIImage()
        
        guard let urlImage = URL(string: urlImageString) else {
            image.withTintColor(.black)
            return image
        }
        
        let data = try? Data(contentsOf: urlImage)
        
        if let imageData = data {
            image = UIImage(data: imageData) ?? UIImage()
            return image
        }
        
        image.withTintColor(.black)
        return image
    }
    
    private func fillData() {
        viewModel.getUsersList(urlString: "https://api.github.com/users") { users in
            if users.isEmpty {
                self.loadingActivityIndicator.stopAnimating()
                self.setupErrorLabel()
            } else {
                self.loadingActivityIndicator.stopAnimating()
                self.users = users
                self.setupSearchBar()
                self.setupTableView()
                self.tableView.reloadData()
            }
        }
    }
}

extension UserViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchedUsers = users.filter { $0.login.lowercased().prefix(searchText.count) == searchText.lowercased() }
        isSearching = true
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
        tableView.reloadData()
    }
}

extension UserViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isSearching {
            viewModel.goToUserInfo(navigationController: self.navigationController ?? UINavigationController(), currentUser: searchedUsers[indexPath.row])
        } else {
            viewModel.goToUserInfo(navigationController: self.navigationController ?? UINavigationController(), currentUser: users[indexPath.row])
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return searchedUsers.count
        } else {
            return users.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath)
        
        cell.selectionStyle = .none
        
        cell.imageView?.layer.borderWidth = 1.0
        cell.imageView?.layer.borderColor = UIColor.lightGray.cgColor
        cell.imageView?.layer.cornerRadius = cell.bounds.height/2
        cell.imageView?.clipsToBounds = true
        
        if isSearching {
            cell.textLabel?.text = searchedUsers[indexPath.row].login
            cell.imageView?.image = getImage(urlImageString: searchedUsers[indexPath.row].avatarUrl)
        } else {
            cell.textLabel?.text = users[indexPath.row].login
            cell.imageView?.image = getImage(urlImageString: users[indexPath.row].avatarUrl)
        }
        return cell
    }
}

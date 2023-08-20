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
    
    private var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Usuários"
        setupSearchBar()
        setupTableView()
        viewModel.getUsersList { users in
            self.users = users
            self.tableView.reloadData()
        }
    }
    
    func setupSearchBar() {
        view.addSubview(searchBar)
        searchBar.delegate = self
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    func setupTableView() {
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
    
    func getImage(urlImageString: String) -> UIImage {
        guard let urlImage = URL(string: urlImageString) else {
            return UIImage(systemName: "person.fill") ?? UIImage()
        }
        
        let data = try? Data(contentsOf: urlImage)
        
        if let imageData = data {
            return UIImage(data: imageData) ?? UIImage()
        }
        
        return UIImage(systemName: "person.fill") ?? UIImage()
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

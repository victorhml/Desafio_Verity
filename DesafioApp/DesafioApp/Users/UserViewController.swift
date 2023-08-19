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
    
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Usuários"
        setupTableView()
        viewModel.getUsersList { users in
            self.users = users
            self.tableView.reloadData()
        }
    }

    func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UserCell")
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
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

extension UserViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.goToUserInfo(navigationController: self.navigationController ?? UINavigationController(), currentUser: users[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath)
        cell.textLabel?.text = users[indexPath.row].login
        cell.imageView?.image = getImage(urlImageString: users[indexPath.row].avatarUrl)
        return cell
    }
}

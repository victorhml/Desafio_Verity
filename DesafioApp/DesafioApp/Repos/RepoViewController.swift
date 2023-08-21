//
//  RepoViewController.swift
//  DesafioApp
//
//  Created by Victor Hugo Martins Lisboa on 18/08/23.
//

import UIKit

class RepoViewController: UIViewController {

    var currentUserInfo: UserInfoModel?
    var viewModel = RepoViewModel()
    var repos = [RepoModel]()
    
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
        label.text = "Não foi possível carregar a lista de repositórios de \(currentUserInfo?.login ?? "")"
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Repositórios"
        navigationController?.navigationBar.tintColor = .darkGray
        setupLoadingView()
        setupLoadingActivityIndicator()
        fillData()
    }
    
    func setupLoadingView() {
        view.addSubview(loadingView)
        NSLayoutConstraint.activate([
            loadingView.topAnchor.constraint(equalTo: view.topAnchor),
            loadingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loadingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loadingView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func setupLoadingActivityIndicator() {
        loadingView.addSubview(loadingActivityIndicator)
        loadingActivityIndicator.startAnimating()
        NSLayoutConstraint.activate([
            loadingActivityIndicator.centerXAnchor.constraint(equalTo: loadingView.centerXAnchor),
            loadingActivityIndicator.centerYAnchor.constraint(equalTo: loadingView.centerYAnchor)
        ])
    }
    
    func setupErrorLabel() {
        loadingActivityIndicator.removeFromSuperview()
        loadingView.addSubview(errorLabel)
        NSLayoutConstraint.activate([
            errorLabel.centerXAnchor.constraint(equalTo: loadingView.centerXAnchor),
            errorLabel.centerYAnchor.constraint(equalTo: loadingView.centerYAnchor)
        ])
    }
    
    func setupTableView() {
        loadingView.removeFromSuperview()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "RepoCell")
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
    
    func fillData() {
        viewModel.getReposList(urlString: currentUserInfo?.reposUrl ?? "") { repos in
            if repos.isEmpty {
                self.loadingActivityIndicator.stopAnimating()
                self.setupErrorLabel()
            } else {
                self.loadingActivityIndicator.stopAnimating()
                self.repos = repos
                self.setupTableView()
                self.tableView.reloadData()
            }
        }
    }
}

extension RepoViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RepoCell", for: indexPath)
        cell.selectionStyle = .none
        cell.textLabel?.text = repos[indexPath.row].name
        return cell
    }
    
    
}

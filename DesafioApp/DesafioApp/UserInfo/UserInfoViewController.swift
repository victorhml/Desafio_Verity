//
//  UserInfoViewController.swift
//  DesafioApp
//
//  Created by Victor Hugo Martins Lisboa on 18/08/23.
//

import UIKit

class UserInfoViewController: UIViewController {

    var currentUser: UserModel?
    var viewModel = UserInfoViewModel()
    var currentUserInfo = UserInfoModel()
    
    private var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var loginLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var emailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var twitterLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var blogLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var bioLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var reposLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var gistsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var followersLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var followingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private var reposButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Repositórios", for: .normal)
        button.backgroundColor = .blue
        button.tintColor = .red
        button.addTarget(self, action: #selector(reposButtonAction), for: .touchUpInside)
        return button
    }()
    
    private var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.axis = .vertical
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        navigationItem.title = currentUser?.login ?? ""
        setupProfileImageView()
        setupStackView()
        setupReposButton()
        fillData()
    }
    
    func setupProfileImageView() {
        view.addSubview(profileImageView)
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileImageView.heightAnchor.constraint(equalToConstant: 200),
            profileImageView.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    func setupStackView() {
        view.addSubview(stackView)
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(loginLabel)
        stackView.addArrangedSubview(emailLabel)
        stackView.addArrangedSubview(twitterLabel)
        stackView.addArrangedSubview(blogLabel)
        stackView.addArrangedSubview(bioLabel)
        stackView.addArrangedSubview(reposLabel)
        stackView.addArrangedSubview(gistsLabel)
        stackView.addArrangedSubview(followersLabel)
        stackView.addArrangedSubview(followingLabel)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func setupReposButton() {
        view.addSubview(reposButton)
        NSLayoutConstraint.activate([
            reposButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 32),
            reposButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            reposButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            reposButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            reposButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func fillData() {
        viewModel.getUserInfo(urlString: currentUser?.url ?? "") { userInfo in
            self.currentUserInfo = userInfo ?? UserInfoModel()

            self.profileImageView.image = self.getImage(urlImageString: userInfo?.avatarUrl ?? "")
            
            self.nameLabel.text = userInfo?.name
            self.loginLabel.text = userInfo?.login
            self.emailLabel.text = userInfo?.email
            self.twitterLabel.text = userInfo?.twitterUsername
            self.blogLabel.text = userInfo?.blog
            self.bioLabel.text = userInfo?.bio
            self.reposLabel.text = "\(userInfo?.publicRepos ?? 0)"
            self.gistsLabel.text = "\(userInfo?.publicGists ?? 0)"
            self.followersLabel.text = "\(userInfo?.followers ?? 0)"
            self.followingLabel.text = "\(userInfo?.following ?? 0)"
        }
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
    
    @objc func reposButtonAction() {
        viewModel.goToRepos(navigationController: self.navigationController ?? UINavigationController(), currentUserInfo: currentUserInfo)
    }
}

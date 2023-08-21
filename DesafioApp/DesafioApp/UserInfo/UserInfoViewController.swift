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
        label.text = "Não foi possível carregar as informações do usuário: \(currentUser?.login ?? "")"
        return label
    }()
    
    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.borderWidth = 1.0
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        imageView.layer.cornerRadius = 100
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var loginLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var twitterLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var blogLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var bioLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var companyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var reposLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var gistsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var followersLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var followingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()

    private lazy var reposButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Repositórios", for: .normal)
        button.backgroundColor = .darkGray
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.darkGray.cgColor
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(reposButtonAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        return stackView
    }()
    
    private lazy var reposGistsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 4)
        return stackView
    }()
    
    private lazy var followStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        navigationItem.title = currentUser?.login ?? ""
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
    
    func setupProfileImageView() {
        view.addSubview(profileImageView)
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileImageView.heightAnchor.constraint(equalToConstant: 200),
            profileImageView.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    func setupMainStackView() {
        view.addSubview(mainStackView)
        mainStackView.addArrangedSubview(nameLabel)
        mainStackView.addArrangedSubview(loginLabel)
        mainStackView.addArrangedSubview(emailLabel)
        mainStackView.addArrangedSubview(twitterLabel)
        mainStackView.addArrangedSubview(blogLabel)
        mainStackView.addArrangedSubview(bioLabel)
        mainStackView.addArrangedSubview(companyLabel)
        mainStackView.addArrangedSubview(locationLabel)
        mainStackView.addArrangedSubview(reposGistsStackView)
        mainStackView.addArrangedSubview(followStackView)
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 16),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func setupReposGistsStackView() {
        reposGistsStackView.addArrangedSubview(reposLabel)
        reposGistsStackView.addArrangedSubview(gistsLabel)
    }
    
    func setupFollowStackView() {
        followStackView.addArrangedSubview(followersLabel)
        followStackView.addArrangedSubview(followingLabel)
    }
    
    func setupReposButton() {
        view.addSubview(reposButton)
        NSLayoutConstraint.activate([
            reposButton.topAnchor.constraint(equalTo: mainStackView.bottomAnchor, constant: 32),
            reposButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            reposButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            reposButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func fillData() {
        viewModel.getUserInfo(urlString: currentUser?.url ?? "") { userInfo in
            if let userInfo = userInfo {
                self.currentUserInfo = userInfo
                
                self.loadingActivityIndicator.stopAnimating()
                self.setupProfileImageView()
                self.setupMainStackView()
                self.setupReposGistsStackView()
                self.setupFollowStackView()
                self.setupReposButton()

                self.profileImageView.image = self.getImage(urlImageString: userInfo.avatarUrl ?? "")
                
                if !(userInfo.name?.isEmpty ?? true) {
                    self.nameLabel.text = "👤Nome: " + (userInfo.name ?? "")
                }
                
                if !userInfo.login.isEmpty {
                    self.loginLabel.text = "🧑‍💻Login: " + userInfo.login
                }
                
                if !(userInfo.email?.isEmpty ?? true) {
                    self.emailLabel.text = "📧Email: " + (userInfo.email ?? "")
                }
                if !(userInfo.twitterUsername?.isEmpty ?? true) {
                    self.twitterLabel.attributedText = self.stringWithImage(imageName: "logo-twitter-x.png", text: " Twitter: \(userInfo.twitterUsername ?? "")")
                }
                if !(userInfo.blog?.isEmpty ?? true) {
                    self.blogLabel.text = "💻Blog: " + (userInfo.blog ?? "")
                }
                if !(userInfo.bio?.isEmpty ?? true) {
                    self.bioLabel.text = "📖Bio: " + (userInfo.bio ?? "")
                }
                if !(userInfo.company?.isEmpty ?? true) {
                    self.companyLabel.text = "🏢Compania: " + (userInfo.company ?? "")
                }
                
                if !(userInfo.location?.isEmpty ?? true) {
                    self.locationLabel.text = "📍Localização: " + (userInfo.location ?? "")
                }
                
                self.reposLabel.attributedText = self.stringWithImage(imageName: "repo.png", text: " Repositórios: \(userInfo.publicRepos)")
                self.gistsLabel.text = "Gists: " + "\(userInfo.publicGists)"
                self.followersLabel.text = "👥Seguidores: " + "\(userInfo.followers)"
                self.followingLabel.text = "Seguindo " + "\(userInfo.following)"
            } else {
                self.loadingActivityIndicator.stopAnimating()
                self.setupErrorLabel()
            }
        }
    }
    
    func stringWithImage(imageName: String, text: String) -> NSMutableAttributedString {
        let fullString = NSMutableAttributedString(string: "")
        let image1Attachment = NSTextAttachment()
        image1Attachment.image = UIImage(named: imageName)

        let image1String = NSAttributedString(attachment: image1Attachment)

        fullString.append(image1String)
        fullString.append(NSAttributedString(string: text))

        return fullString
    }
    
    func getImage(urlImageString: String) -> UIImage {
        
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
    
    @objc func reposButtonAction() {
        viewModel.goToRepos(navigationController: self.navigationController ?? UINavigationController(), currentUserInfo: currentUserInfo)
    }
}

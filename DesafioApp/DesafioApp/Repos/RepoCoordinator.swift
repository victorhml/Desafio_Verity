//
//  RepoCoordinator.swift
//  DesafioApp
//
//  Created by Victor Hugo Martins Lisboa on 18/08/23.
//

import Foundation
import UIKit

class RepoCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    var currentUserInfo = UserInfoModel()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = RepoViewController()
        viewController.currentUserInfo = currentUserInfo
        navigationController.pushViewController(viewController, animated: true)
    }
}

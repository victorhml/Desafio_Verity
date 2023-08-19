//
//  UserInfoCoordinator.swift
//  DesafioApp
//
//  Created by Victor Hugo Martins Lisboa on 18/08/23.
//

import Foundation
import UIKit

class UserInfoCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    var currentUser = UserModel()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = UserInfoViewController()
        viewController.currentUser = currentUser
        navigationController.pushViewController(viewController, animated: true)
    }
}

//
//  UserCoordinator.swift
//  DesafioApp
//
//  Created by Victor Hugo Martins Lisboa on 18/08/23.
//

import Foundation
import UIKit

class UserCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = UserViewController()
        navigationController.pushViewController(viewController, animated: true)
    }
}

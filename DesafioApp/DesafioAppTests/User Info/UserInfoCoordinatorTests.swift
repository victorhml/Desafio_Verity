//
//  UserInfoCoordinatorTests.swift
//  DesafioAppTests
//
//  Created by Victor Hugo Martins Lisboa on 21/08/23.
//

import XCTest
@testable import DesafioApp

class UserInfoCoordinatorTests: XCTestCase {

    var coordinator: UserInfoCoordinator!
    
    override func setUp() {
        super.setUp()
        let navigationController = UINavigationController()
        coordinator = UserInfoCoordinator(navigationController: navigationController)
    }

    func test_start() {
        coordinator.start()
    }
}

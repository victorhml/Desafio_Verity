//
//  UserCoordinatorTests.swift
//  DesafioAppTests
//
//  Created by Victor Hugo Martins Lisboa on 21/08/23.
//

import XCTest
@testable import DesafioApp

class UserCoordinatorTests: XCTestCase {
    var coordinator: UserCoordinator!
    
    override func setUp() {
        super.setUp()
        let navigationController = UINavigationController()
        coordinator = UserCoordinator(navigationController: navigationController)
    }
    
    func test_start() {
        coordinator.start()
    }
}

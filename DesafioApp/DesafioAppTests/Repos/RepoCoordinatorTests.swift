//
//  RepoCoordinatorTests.swift
//  DesafioAppTests
//
//  Created by Victor Hugo Martins Lisboa on 21/08/23.
//

import XCTest
@testable import DesafioApp

class RepoCoordinatorTests: XCTestCase {
    var coordinator: RepoCoordinator!

    override func setUp() {
        super.setUp()
        let navigationController = UINavigationController()
        coordinator = RepoCoordinator(navigationController: navigationController)
    }
    
    func test_start() {
        coordinator.start()
    }
}

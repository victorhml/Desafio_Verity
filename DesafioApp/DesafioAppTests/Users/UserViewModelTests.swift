//
//  UserViewModelTests.swift
//  DesafioAppTests
//
//  Created by Victor Hugo Martins Lisboa on 21/08/23.
//

import XCTest
@testable import DesafioApp

class UserViewModelTests: XCTestCase {
    var viewModel: UserViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = UserViewModel()
    }
    
    func test_getUsersList() {
        viewModel.getUsersList(urlString: "https://api.github.com/users") { users in
            XCTAssertNotNil(users)
        }
    }
    
    func test_getUsersListWithError() {
        viewModel.getUsersList(urlString: "https://api.github.com/users1") { users in
            XCTAssertNil(users)
        }
    } 
    
    func test_goToUserInfo() {
        let navigationController = UINavigationController()
        let userModel = UserModel()
        viewModel.goToUserInfo(navigationController: navigationController, currentUser: userModel)
        
    }
}

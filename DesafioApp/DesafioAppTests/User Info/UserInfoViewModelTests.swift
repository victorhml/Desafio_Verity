//
//  UserInfoViewModelTests.swift
//  DesafioAppTests
//
//  Created by Victor Hugo Martins Lisboa on 21/08/23.
//

import XCTest
@testable import DesafioApp

class UserInfoViewModelTests: XCTestCase {
    var viewModel: UserInfoViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = UserInfoViewModel()
    }
    
    func test_getUserInfo() {
        viewModel.getUserInfo(urlString: "https://api.github.com/users/torvalds") { userInfo in
            XCTAssertNotNil(userInfo)
        }
    }
    
    func test_getUserInfoWithError() {
        viewModel.getUserInfo(urlString: "https://api.github.com/users/torvalds1") { userInfo in
            XCTAssertNil(userInfo)
        }
    }
    
    func test_goToRepos() {
        let navigationController = UINavigationController()
        let userInfoModel = UserInfoModel()
        viewModel.goToRepos(navigationController: navigationController, currentUserInfo: userInfoModel)
    }
}

//
//  RepoViewModelTests.swift
//  DesafioAppTests
//
//  Created by Victor Hugo Martins Lisboa on 21/08/23.
//

import XCTest
@testable import DesafioApp

class RepoViewModelTests: XCTestCase {
    var viewModel: RepoViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = RepoViewModel()
    }
    
    func test_getReposList() {
        viewModel.getReposList(urlString: "https://api.github.com/users/torvalds/repos") { repos in
            XCTAssertNotNil(repos)
        }
    }
    
    func test_getReposListWithError() {
        viewModel.getReposList(urlString: "https://api.github.com/users/torvalds/repos1") { repos in
            XCTAssertNil(repos) 
        }
    }
}

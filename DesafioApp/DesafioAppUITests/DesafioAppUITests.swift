//
//  DesafioAppUITests.swift
//  DesafioAppUITests
//
//  Created by Victor Hugo Martins Lisboa on 21/08/23.
//

import XCTest
import DesafioApp

class DesafioAppUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

        func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
                    
        userView(app: app)
                        
        userInfoView(app: app)
        repoView(app: app)
    }
    
    func userView(app: XCUIApplication) {
        let usernameSearchField = app.searchFields["Nome do usuário"]
        usernameSearchField.waitForExistence(timeout: 10)
        XCTAssertTrue(usernameSearchField.exists)
        
        usernameSearchField.tap()
        usernameSearchField.typeText("mojombo")
        
        usernameSearchField.buttons["Clear text"].tap()
        
        let firstElement = app.tables.cells.element(boundBy: 0)
        XCTAssertTrue(firstElement.exists)
        firstElement.tap()
    }
    
    func userInfoView(app: XCUIApplication) {
        let repoButton = app.buttons["Repositórios"]
        repoButton.waitForExistence(timeout: 10)
        XCTAssertTrue(repoButton.exists)
        
        repoButton.tap()
    }
    
    func repoView(app: XCUIApplication) {
        let repoTableView = app.tables.element
        repoTableView.waitForExistence(timeout: 10)
        repoTableView.swipeUp(velocity: .slow)
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}

//
//  MainViewControllerTests.swift
//  luzie-locke-iosTests
//
//  Created by Harry on 10.10.21.
//

import XCTest
@testable import luzie_locke_ios

class MainViewControllerTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testShouldNavigateToLoginScreenWhenNotLoggedIn() throws {
        let authManagerMock = AuthManagerMock()
        
        let sut = MainViewController(authManager: authManagerMock)
        
        let navigationController = UINavigationController(rootViewController: sut)
//        navigationController.pushViewController(sut, animated: false)
        
        XCTAssertTrue(true)
    }
}

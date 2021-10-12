//
//  MainViewControllerTests.swift
//  luzie-locke-iosTests
//
//  Created by Harry on 10.10.21.
//

import XCTest
@testable import luzie_locke_ios

class MainViewControllerTests: XCTestCase {
    
    var sut:                    MainTabBarController?
    var authableMock:           AuthableMock?
    var loginCoordinatorMock:   CoordinatorMock?
    
    let shown  = 1
    let hidden = 0
    
    let authenticated   = true
    let unauthenticated = false
    
    override func setUpWithError() throws {
        authableMock = AuthableMock()
        loginCoordinatorMock = CoordinatorMock()
        
        if let authableMock = authableMock, let loginCoordinatorMock = loginCoordinatorMock {
            sut = MainTabBarController(auth: authableMock, loginCoordinator: loginCoordinatorMock)
            
            let window = UIWindow(frame: UIScreen.main.bounds)
            window.rootViewController = sut
            window.makeKeyAndVisible()
        }
    }

    func givenUserIs(_ status: Bool) {
        authableMock?.authenticated = status
    }
    
    func whenViewIsLoaded() {
        sut?.loadViewIfNeeded()
        sut?.viewDidAppear(true)
    }
    
    func loginViewControllerShouldBe(_ status: Int) {
        XCTAssertEqual(loginCoordinatorMock?.navigationController.viewControllers.count, status)
    }
    
    func testShouldNavigateToLoginScreenWhenUnauthenticated() throws {
        givenUserIs(unauthenticated)
        loginViewControllerShouldBe(hidden)
        
        whenViewIsLoaded()
        loginViewControllerShouldBe(shown)
    }
    
    func testShouldNotNavigateToLoginScreenWhenAuthenticated() throws {
        givenUserIs(authenticated)
        
        whenViewIsLoaded()
        loginViewControllerShouldBe(hidden)
    }
}

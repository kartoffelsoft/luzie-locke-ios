//
//  MainViewControllerTests.swift
//  luzie-locke-iosTests
//
//  Created by Harry on 10.10.21.
//

import XCTest
@testable import luzie_locke_ios

class MainViewControllerTests: XCTestCase {
    
    var sut:                    MainTabBarController!
    var mockUserStorage:        UserStorageMock!
    var mockLoginCoordinator:   CoordinatorMock!
    
    let shown  = 1
    let hidden = 0
    
    let authenticated   = false
    let unauthenticated = true
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        mockUserStorage     = UserStorageMock()
        mockLoginCoordinator = CoordinatorMock()
        
        sut = MainTabBarController(userStorage: mockUserStorage, loginCoordinator: mockLoginCoordinator)
            
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = sut
        window.makeKeyAndVisible()
    }
    
    override func tearDownWithError() throws {
        sut = nil
        mockUserStorage = nil
        mockLoginCoordinator = nil
        try super.tearDownWithError()
    }
    
    func givenUserIs(_ status: Bool) {
        mockUserStorage?.setIsEmpty(empty: status)
    }
    
    func whenViewIsLoaded() {
        sut?.beginAppearanceTransition(true, animated: true)
        sut?.endAppearanceTransition()
    }
    
    func loginViewControllerShouldBe(_ status: Int) {
        XCTAssertEqual(mockLoginCoordinator?.navigationController.viewControllers.count, status)
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

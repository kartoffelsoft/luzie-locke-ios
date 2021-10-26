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
  var mockAuthService:        AuthServiceMock!
  var mockStorageService:     StorageService!
  var mockOpenHttpClient:     OpenHTTPClientMock!
  var mockLoginCoordinator:   CoordinatorMock!
  
  let shown  = 1
  let hidden = 0
  
  let authenticated   = false
  let unauthenticated = true
  
  override func setUpWithError() throws {
    try super.setUpWithError()
    
    mockAuthService      = AuthServiceMock()
    mockStorageService   = StorageService(
                             profile: AnyStorage(wrap: ProfileStorageMock(key: "Profile")),
                             accessToken: AnyStorage(wrap: SimpleStringStorageMock(key: "AccessToken")),
                             refreshToken: AnyStorage(wrap: SimpleStringStorageMock(key: "RefreshToken")))
    mockOpenHttpClient   = OpenHTTPClientMock()
    
    mockLoginCoordinator = CoordinatorMock()
    
    sut = MainTabBarController(
            auth: mockAuthService,
            storage: mockStorageService,
            openHttpClient: mockOpenHttpClient,
            backendApiClient: _,
            loginCoordinator: mockLoginCoordinator)
    
    let window = UIWindow(frame: UIScreen.main.bounds)
    window.rootViewController = sut
    window.makeKeyAndVisible()
  }
  
  override func tearDownWithError() throws {
    sut = nil
    mockStorageService = nil
    mockLoginCoordinator = nil
    try super.tearDownWithError()
  }
  
  func givenUserIs(_ state: Bool) {
    mockAuthService?.setAuthStateTo(state)
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

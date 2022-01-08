//
//  SwipeImageViewmodelTests.swift
//  luzie-locke-iosTests
//
//  Created by Harry on 08.01.22.
//

import XCTest

@testable import luzie_locke_ios

class SwipeImageViewModelTests: XCTestCase {

  var sut:              SwipeImageViewModel!
  var imageUseCaseMock: ImageUseCaseMock!

  var controllers: [UIViewController]?
  
  let fakeUrls: [String] = Faker.image.imageUrls()
  
  override func setUpWithError() throws {
    try super.setUpWithError()
    
    imageUseCaseMock = ImageUseCaseMock()
    sut = SwipeImageViewModel(imageUseCase: imageUseCaseMock)
  }
  
  func givenThatViewModelIsBound() {
    sut.bindableControllers.bind { [weak self] controllers in
      self?.controllers = controllers
    }
  }
  
  func theControllerModuleShouldBeBuilt() {
    XCTAssertEqual(fakeUrls.count, controllers?.count ?? 0)
  }
  
  func whenUrlsAreSet(_ fakeUrls: [String]) {
    sut.urls = fakeUrls
  }
  
  func testShouldBuildControllerModulesWhenUrlsAreSet() throws {
    givenThatViewModelIsBound()

    whenUrlsAreSet(fakeUrls)
    theControllerModuleShouldBeBuilt()
  }
}


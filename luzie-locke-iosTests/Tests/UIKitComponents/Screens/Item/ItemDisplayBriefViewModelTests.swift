//
//  ItemDisplayBriefViewModelTests.swift
//  luzie-locke-iosTests
//
//  Created by Harry on 07.01.22.
//

import XCTest

@testable import luzie_locke_ios

class ItemDisplayBriefViewModelTests: XCTestCase {

  var sut:              ItemDisplayBriefViewModel!
  var imageUseCaseMock: ImageUseCaseMock!
  var coordinatorSpy:   ItemDisplayCoordinatorSpy!
  
  var titleText:        String!
  var locationText:     String!
  
  let fakeModel = FakeModels.itemDisplay()
  
  override func setUpWithError() throws {
    try super.setUpWithError()
    
    coordinatorSpy   = ItemDisplayCoordinatorSpy()
    imageUseCaseMock = ImageUseCaseMock()
    sut              = ItemDisplayBriefViewModel(coordinator: coordinatorSpy, imageUseCase: imageUseCaseMock)
  }
  
  func givenThatViewModelIsBound() {
    sut.bindableTitleText.bind { [weak self] text in
      self?.titleText = text
    }

    sut?.bindableLocationText.bind { [weak self] text in
      self?.locationText = text
    }
  }
  
  func givenModelIsSet(_ model: ItemDisplay) {
    whenModelIsSet(model)
  }
  
  func whenModelIsSet(_ model: ItemDisplay) {
    sut.model = model
  }
  
  func whenMoreButtonIsTapped() {
    sut.didTapMoreButton(UIViewController())
  }
  
  func theTitleTextShouldBe(_ expected: String) {
    XCTAssertEqual(expected, titleText)
  }
  
  func theLocationTextShouldBe(_ expected: String) {
    XCTAssertEqual(expected, locationText)
  }
  
  func theLoadedImageUrlsShouldBe(_ expected: [String]) {
    XCTAssertEqual(expected, sut.swipeImageViewModel.urls)
  }
  
  func presentMoreShouldBeCalled() {
    XCTAssertEqual(1, coordinatorSpy.presentMoreCallLog.callCount)
    XCTAssertEqual(fakeModel, coordinatorSpy.presentMoreCallLog.model)
  }
  
  func testShouldLoadTextWhenModelIsSet() throws {
    givenThatViewModelIsBound()
  
    whenModelIsSet(fakeModel)
    theTitleTextShouldBe(fakeModel.title)
    theLocationTextShouldBe(fakeModel.location)
  }
  
  func testShouldLoadImageUrls() throws {
    givenThatViewModelIsBound()
    
    whenModelIsSet(fakeModel)
    theLoadedImageUrlsShouldBe(fakeModel.imageUrls.compactMap{ $0 })
  }
  
  func testShouldPresentMoreWhenMoreButtonIsTapped() throws {
    givenThatViewModelIsBound()
    givenModelIsSet(fakeModel)
    
    whenMoreButtonIsTapped()
    presentMoreShouldBeCalled()
  }
}

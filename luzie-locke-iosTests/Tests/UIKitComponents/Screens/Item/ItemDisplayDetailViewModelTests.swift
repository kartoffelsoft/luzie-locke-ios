//
//  ItemDisplayDetailViewModelTests.swift
//  luzie-locke-iosTests
//
//  Created by Harry on 08.01.22.
//

import XCTest

@testable import luzie_locke_ios

class ItemDisplayDetailViewModelTests: XCTestCase {

  var sut:              ItemDisplayDetailViewModel!
  var imageUseCaseMock: ImageUseCaseMock!
  
  var userImage:       UIImage!
  var userNameText:    String!
  var titleText:       String!
  var locationText:    String!
  var descriptionText: String!
  
  let fakeModel = FakeModels.itemDisplay()
  let fakeImage = UIImage(systemName: "photo")

  override func setUpWithError() throws {
    try super.setUpWithError()
    
    imageUseCaseMock = ImageUseCaseMock()
    imageUseCaseMock.setFakeResult(.success(fakeImage))
    
    sut = ItemDisplayDetailViewModel(imageUseCase: imageUseCaseMock)
  }
  
  func givenThatViewModelIsBound() {
    sut.bindableUserImage.bind { [weak self] image in
      self?.userImage = image
    }

    sut?.bindableUserNameText.bind { [weak self] text in
      self?.userNameText = text
    }
    
    sut.bindableTitleText.bind { [weak self] text in
      self?.titleText = text
    }

    sut?.bindableLocationText.bind { [weak self] text in
      self?.locationText = text
    }
    
    sut?.bindableDescriptionText.bind { [weak self] text in
      self?.descriptionText = text
    }
  }
  
  func givenModelIsSet(_ model: ItemDisplay) {
    whenModelIsSet(model)
  }
  
  func whenModelIsSet(_ model: ItemDisplay) {
    sut.model = model
  }

  func theUserNameTextShouldBe(_ expected: String) {
    XCTAssertEqual(expected, userNameText)
  }
  
  func theUserImageShouldBe(_ expected: UIImage?) {
    XCTAssertEqual(expected, userImage)
  }
  
  func theTitleTextShouldBe(_ expected: String) {
    XCTAssertEqual(expected, titleText)
  }
  
  func theLocationTextShouldBe(_ expected: String) {
    XCTAssertEqual(expected, locationText)
  }
  
  func theDescriptionTextShouldBe(_ expected: String) {
    XCTAssertEqual(expected, descriptionText)
  }
  
  func theLoadedImageUrlsShouldBe(_ expected: [String]) {
    XCTAssertEqual(expected, sut.swipeImageViewModel.urls)
  }
  
  func testShouldLoadTextWhenModelIsSet() throws {
    givenThatViewModelIsBound()
  
    whenModelIsSet(fakeModel)
    theUserNameTextShouldBe(fakeModel.userName)
    theTitleTextShouldBe(fakeModel.title)
    theLocationTextShouldBe(fakeModel.location)
    theDescriptionTextShouldBe(fakeModel.description)
  }
  
  func testShouldRequestImageWhenModelIsSet() throws {
    givenThatViewModelIsBound()
    
    whenModelIsSet(fakeModel)
    theUserImageShouldBe(fakeImage)
  }
  
  func testShouldLoadImageUrls() throws {
    givenThatViewModelIsBound()
    
    whenModelIsSet(fakeModel)
    theLoadedImageUrlsShouldBe(fakeModel.imageUrls.compactMap{ $0 })
  }
}

//
//  RecentMessageCellViewModelTests.swift
//  luzie-locke-iosTests
//
//  Created by Harry on 20.12.21.
//

import XCTest

@testable import luzie_locke_ios

class RecentMessageCellViewModelTests: XCTestCase {

  var sut: RecentMessageCellViewModel!
  var imageUseCaseMock: ImageUseCaseMock!
  
  var nameText:     String!
  var messageText:  String!
  var dateText:     String!
  var itemImage:    UIImage!
  var userImage:    UIImage!

  let fakeModel = FakeModels.recentMessage()
  let fakeImage = UIImage(systemName: "photo")
  
  override func setUpWithError() throws {
    try super.setUpWithError()
    
    imageUseCaseMock  = ImageUseCaseMock()
    sut               = RecentMessageCellViewModel(imageUseCase: imageUseCaseMock)
    
    imageUseCaseMock.setFakeResult(.success(fakeImage))
  }
  
  func givenThatViewModelIsBound() {
    sut.bindableNameText.bind { [weak self] text in
      self?.nameText = text
    }
    
    sut?.bindableMessageText.bind { [weak self] text in
      self?.messageText = text
    }
    
    sut?.bindableDateText.bind { [weak self] text in
      self?.dateText = text
    }
    
    sut?.bindableItemImage.bind { [weak self] image in
      self?.itemImage = image
    }
    
    sut?.bindableUserImage.bind { [weak self] image in
      self?.userImage = image
    }
  }
  
  func givenMockIsConfiguredToFailDownload() {
    imageUseCaseMock.setFakeResult(.failure(.unableToComplete))
  }
  
  func whenModelIsSet(_ model: RecentMessage) {
    sut.model = model
  }
  
  func theNameTextShouldBe(_ expected: String) {
    XCTAssertEqual(expected, nameText)
  }

  func theMessageTextShouldBe(_ expected: String) {
    XCTAssertEqual(expected, messageText)
  }
  
  func theDateTextShouldBe(_ expected: String) {
    XCTAssertEqual(expected, dateText)
  }
  
  func theItemImageShouldBe(_ expected: UIImage?) {
    XCTAssertEqual(expected, itemImage)
  }
  
  func theUserImageShouldBe(_ expected: UIImage?) {
    XCTAssertEqual(expected, userImage)
  }

  func testShouldLoadTextsWhenModelIsSet() throws {
    givenThatViewModelIsBound()
    
    whenModelIsSet(fakeModel)
    theNameTextShouldBe(fakeModel.name)
    theMessageTextShouldBe(fakeModel.text)
    theDateTextShouldBe(DateUtility.string(from: fakeModel.date))
  }
  
  func testShouldLoadItemImageWhenDownloadSucceeded() throws {
    givenThatViewModelIsBound()
    
    whenModelIsSet(fakeModel)
    theItemImageShouldBe(fakeImage)
  }
  
  func testShouldLoadUserImageWhenDownloadSucceeded() throws {
    givenThatViewModelIsBound()
    
    whenModelIsSet(fakeModel)
    theUserImageShouldBe(fakeImage)
  }
  
  func testShouldNotLoadItemImageWhenDownloadIsFailed() throws {
    givenThatViewModelIsBound()
    givenMockIsConfiguredToFailDownload()
    
    whenModelIsSet(fakeModel)
    theItemImageShouldBe(nil)
  }
  
  func testShouldNotLoadUserImageWhenDownloadIsFailed() throws {
    givenThatViewModelIsBound()
    givenMockIsConfiguredToFailDownload()
    
    whenModelIsSet(fakeModel)
    theUserImageShouldBe(nil)
  }
}

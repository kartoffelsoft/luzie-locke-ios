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
  
  var nameText:     String!
  var messageText:  String!
  var dateText:     String!
  var itemImage:    UIImage!
  var userImage:    UIImage!
  
  var imageUseCaseSpy: ImageUseCaseSpy!
  
  let fakeModel       = FakeModels.recentMessage()
  let fakeItemUIImage = UIImage(systemName: "location")
  let fakeUserUIImage = UIImage(systemName: "plus")
  
  override func setUpWithError() throws {
    try super.setUpWithError()
    
    imageUseCaseSpy = ImageUseCaseSpy()
    sut             = RecentMessageCellViewModel(imageUseCase: imageUseCaseSpy)
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
  
  func whenModelIsSet(_ model: RecentMessage) {
    sut.model = model
  }
  
  func whenItemImageIsFetchedWith(_ result: Result<UIImage?, LLError>) {
    guard let callback = imageUseCaseSpy.completionCallbackWithItemId else { return }
    callback(result)
  }
  
  func whenUserImageIsFetchedWith(_ result: Result<UIImage?, LLError>) {
    guard let callback = imageUseCaseSpy.completionCallbackWithUserId else { return }
    callback(result)
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
  
  func shouldTriggerGetItemImage() {
    XCTAssertTrue(imageUseCaseSpy.getImageWithItemIdIsCalled)
  }
  
  func shouldTriggerGetUserImage() {
    XCTAssertTrue(imageUseCaseSpy.getImageWithUserIdIsCalled)
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
  
  func testShouldTriggerImageDownloadWhenModelIsSet() throws {
    givenThatViewModelIsBound()
    
    whenModelIsSet(fakeModel)
    shouldTriggerGetItemImage()
    shouldTriggerGetUserImage()
  }
  
  func testShouldLoadItemImageWhenDownloadSucceeded() throws {
    givenThatViewModelIsBound()
    
    whenModelIsSet(fakeModel)
    whenItemImageIsFetchedWith(.success(fakeItemUIImage))
    theItemImageShouldBe(fakeItemUIImage)
  }
  
  func testShouldLoadUserImageWhenDownloadSucceeded() throws {
    givenThatViewModelIsBound()
    
    whenModelIsSet(fakeModel)
    whenUserImageIsFetchedWith(.success(fakeItemUIImage))
    theUserImageShouldBe(fakeItemUIImage)
  }
  
  func testShouldNotLoadItemImageWhenDownloadIsFailed() throws {
    givenThatViewModelIsBound()
    
    whenModelIsSet(fakeModel)
    whenItemImageIsFetchedWith(.failure(.unableToComplete))
    theItemImageShouldBe(nil)
  }
  
  func testShouldNotLoadUserImageWhenDownloadIsFailed() throws {
    givenThatViewModelIsBound()
    
    whenModelIsSet(fakeModel)
    whenUserImageIsFetchedWith(.failure(.unableToComplete))
    theUserImageShouldBe(nil)
  }
}

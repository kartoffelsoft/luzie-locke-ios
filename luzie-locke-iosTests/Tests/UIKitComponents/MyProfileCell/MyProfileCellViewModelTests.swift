//
//  MyProfileCellViewModel.swift
//  luzie-locke-iosTests
//
//  Created by Harry on 26.10.21.
//

import XCTest

@testable import luzie_locke_ios

class MyProfileCellViewModelTests: XCTestCase {

  var sut: MyProfileCellViewModel!
  
  var userImage:         UIImage?
  var userNameText:      String?
  var userLocationText:  String?
  
  var imageUseCaseMock:  ImageUseCaseMock!
  
  let fakeModel   = FakeModels.userProfileBrief()
  let fakeUIImage = UIImage(systemName: "location")
  
  override func setUpWithError() throws {
    try super.setUpWithError()
    
    imageUseCaseMock    = ImageUseCaseMock()
    sut                 = MyProfileCellViewModel(imageUseCase: imageUseCaseMock)
    
    userImage           = nil
    userNameText        = nil
    userLocationText    = nil
    
    imageUseCaseMock.setFakeResult(.success(fakeUIImage))
  }
  
  func givenThatViewModelIsBound() {
    sut.bindableProfileImage.bind { [weak self] image in
      self?.userImage = image
    }
    
    sut?.bindableNameText.bind { [weak self] text in
      self?.userNameText = text
    }
    
    sut?.bindableLocationText.bind { [weak self] text in
      self?.userLocationText = text
    }
  }
  
  func givenMockIsConfiguredToFailDownload() {
    imageUseCaseMock.setFakeResult(.failure(.unableToComplete))
  }
  
  func whenModelIsSet(_ model: UserProfileBrief) {
    sut.model = model
  }

  func theNameTextShouldBe(_ expected: String) {
    XCTAssertEqual(expected, userNameText)
  }
  
  func theLocationTextShouldBe(_ expected: String) {
    XCTAssertEqual(expected, userLocationText)
  }
  
  func theImageShouldBe(_ expected: UIImage?) {
    XCTAssertEqual(expected, userImage)
  }

  func testShouldLoadTextsWhenModelIsSet() throws {
    givenThatViewModelIsBound()
    
    whenModelIsSet(fakeModel)
    theNameTextShouldBe(fakeModel.name)
    theLocationTextShouldBe(fakeModel.city)
  }

  func testShouldLoadImageWhenDownloadSucceeded() throws {
    givenThatViewModelIsBound()
    
    whenModelIsSet(fakeModel)
    theImageShouldBe(fakeUIImage)
  }
  
  func testShouldNotLoadImageWhenDownloadIsFailed() throws {
    givenThatViewModelIsBound()
    givenMockIsConfiguredToFailDownload()
    
    whenModelIsSet(fakeModel)
    theImageShouldBe(nil)
  }
}

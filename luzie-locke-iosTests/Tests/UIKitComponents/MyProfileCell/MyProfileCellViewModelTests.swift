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
  
  var userImageView:      UIImageView!
  var userNameLabel:      UILabel!
  var userLocationLabel:  UILabel!
  
  var imageUseCaseSpy:   ImageUseCaseSpy!
  
  let fakeModel   = FakeModels.userProfileBrief()
  let fakeUIImage = UIImage(systemName: "location")
  
  override func setUpWithError() throws {
    try super.setUpWithError()
    
    imageUseCaseSpy     = ImageUseCaseSpy()
    sut                 = MyProfileCellViewModel(imageUseCase: imageUseCaseSpy)
    
    userImageView       = UIImageView()
    userNameLabel       = UILabel()
    userLocationLabel   = UILabel()
  }
  
  func givenThatViewModelIsBound() {
    sut.bindableProfileImage.bind { [weak self] image in
      self?.userImageView.image = image
    }
    
    sut?.bindableNameText.bind { [weak self] text in
      self?.userNameLabel.text = text
    }
    
    sut?.bindableLocationText.bind { [weak self] text in
      self?.userLocationLabel.text = text
    }
  }
  
  func whenModelIsSet(_ model: UserProfileBrief) {
    sut.model = model
  }
  
  func whenImageIsFetchedWith(_ result: Result<UIImage?, LLError>) {
    guard let callback = imageUseCaseSpy.completionCallbackWithUrl else { return }
    callback(result)
  }

  func theNameTextShouldBe(_ expected: String) {
    XCTAssertEqual(expected, userNameLabel.text)
  }
  
  func theLocationTextShouldBe(_ expected: String) {
    XCTAssertEqual(expected, userLocationLabel.text)
  }
  
  func shouldTriggerGetImage() {
    XCTAssertTrue(imageUseCaseSpy.getImageWithUrlIsCalled)
  }
  
  func theImageShouldBe(_ expected: UIImage?) {
    XCTAssertEqual(expected, userImageView.image)
  }

  func testShouldLoadTextsWhenModelIsSet() throws {
    givenThatViewModelIsBound()
    
    whenModelIsSet(fakeModel)
    theNameTextShouldBe(fakeModel.name)
    theLocationTextShouldBe(fakeModel.city)
  }
  
  func testShouldTriggerImageDownloadWhenModelIsSet() throws {
    givenThatViewModelIsBound()
    
    whenModelIsSet(fakeModel)
    shouldTriggerGetImage()
  }
  
  func testShouldLoadImageWhenDownloadSucceeded() throws {
    givenThatViewModelIsBound()
    
    whenModelIsSet(fakeModel)
    whenImageIsFetchedWith(.success(fakeUIImage))
    theImageShouldBe(fakeUIImage)
  }
  
  func testShouldNotLoadImageWhenDownloadIsFailed() throws {
    givenThatViewModelIsBound()
    
    whenModelIsSet(fakeModel)
    whenImageIsFetchedWith(.failure(.unableToComplete))
    theImageShouldBe(nil)
  }
}

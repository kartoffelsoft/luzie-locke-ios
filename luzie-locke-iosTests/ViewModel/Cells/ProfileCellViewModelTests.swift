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
  
  var mockOpenHttpClient: OpenHTTPClientMock!
  
  let fakeMyProfile = FakeModels.myProfileCellModel()
  let fakeUIImage   = UIImage(systemName: "location")
  
  override func setUpWithError() throws {
    try super.setUpWithError()
    
    mockOpenHttpClient  = OpenHTTPClientMock()
    sut                 = MyProfileCellViewModel(openHttpClient: mockOpenHttpClient)
    
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
  
  func whenProfileIsSet(_ profile: MyProfileCellModel) {
    sut.model = profile
  }
  
  func whenHttpClientFetchedResultWith(_ result: Result<UIImage?, LLError>) {
    mockOpenHttpClient.fetchDownloadImageCompletionWith(result: result)
  }
  
  func theNameTextShouldBe(_ expected: String) {
    XCTAssertEqual(expected, userNameLabel.text)
  }
  
  func theLocationTextShouldBe(_ expected: String) {
    XCTAssertEqual(expected, userLocationLabel.text)
  }
  
  func shouldTriggerImageDownload() {
    XCTAssertTrue(mockOpenHttpClient.isDownloadImageCalled)
  }
  
  func theImageShouldBe(_ expected: UIImage?) {
    XCTAssertEqual(expected, userImageView.image)
  }

  func testShouldLoadTextsWhenProfileIsSet() throws {
    givenThatViewModelIsBound()
    
    whenProfileIsSet(fakeMyProfile)
    theNameTextShouldBe(fakeMyProfile.name)
    theLocationTextShouldBe(fakeMyProfile.city)
  }
  
  func testShouldTriggerImageDownloadWhenProfileIsSet() throws {
    givenThatViewModelIsBound()
    
    whenProfileIsSet(fakeMyProfile)
    shouldTriggerImageDownload()
  }
  
  func testShouldLoadImageWhenDownloadSucceeded() throws {
    givenThatViewModelIsBound()
    
    whenProfileIsSet(fakeMyProfile)
    whenHttpClientFetchedResultWith(.success(fakeUIImage))
    theImageShouldBe(fakeUIImage)
  }
  
  func testShouldNotLoadImageWhenDownloadIsFailed() throws {
    givenThatViewModelIsBound()
    
    whenProfileIsSet(fakeMyProfile)
    whenHttpClientFetchedResultWith(.failure(.unableToComplete))
    theImageShouldBe(nil)
  }
}

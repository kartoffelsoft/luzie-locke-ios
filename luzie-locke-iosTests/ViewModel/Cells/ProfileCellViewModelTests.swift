//
//  ProfileCellViewModel.swift
//  luzie-locke-iosTests
//
//  Created by Harry on 26.10.21.
//

import XCTest

@testable import luzie_locke_ios

class ProfileCellViewModelTests: XCTestCase {

  var sut: ProfileCellViewModel!
  
  var userImageView: UIImageView!
  var userNameLabel: UILabel!
  var userLocationLabel: UILabel!
  
  var mockOpenHttpClient: OpenHTTPClientMock!
  
  let testProfile = User(uid: "abc123",
                         name: "Tester",
                         email: "happy@coding.com",
                         reputation: 10,
                         pictureURI: "www.test.com/test",
                         location: Location(name: "Playground",
                                            geoJSON: GeoJSON(type: "2DPoint",
                                                             coordinates: [12.34, 56.78])))
  
  let testUIImage = UIImage(systemName: "location")
  
  override func setUpWithError() throws {
    try super.setUpWithError()
    
    mockOpenHttpClient  = OpenHTTPClientMock()
    sut                 = ProfileCellViewModel(openHttpClient: mockOpenHttpClient)
    
    userImageView     = UIImageView()
    userNameLabel     = UILabel()
    userLocationLabel = UILabel()
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
  
  func whenProfileIsSet(_ profile: User) {
    sut.profile = profile
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
    
    whenProfileIsSet(testProfile)
    theNameTextShouldBe("Tester")
    theLocationTextShouldBe("Playground")
  }
  
  func testShouldTriggerImageDownloadWhenProfileIsSet() throws {
    givenThatViewModelIsBound()
    
    whenProfileIsSet(testProfile)
    shouldTriggerImageDownload()
  }
  
  func testShouldLoadImageWhenDownloadSucceeded() throws {
    givenThatViewModelIsBound()
    
    whenProfileIsSet(testProfile)
    whenHttpClientFetchedResultWith(.success(testUIImage))
    theImageShouldBe(testUIImage)
  }
  
  func testShouldNotLoadImageWhenDownloadIsFailed() throws {
    givenThatViewModelIsBound()
    
    whenProfileIsSet(testProfile)
    whenHttpClientFetchedResultWith(.failure(.unableToComplete))
    theImageShouldBe(nil)
  }
}

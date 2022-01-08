//
//  ImageViewModelTests.swift
//  luzie-locke-iosTests
//
//  Created by Harry on 08.01.22.
//

import XCTest

@testable import luzie_locke_ios

class ImageViewModelTests: XCTestCase {

  var sut:              ImageViewModel!
  var imageUseCaseMock: ImageUseCaseMock!

  var image: UIImage?
  
  let fakeUrl: String = Faker.image.imageUrl()
  let fakeImage = UIImage(systemName: "photo")
  
  override func setUpWithError() throws {
    try super.setUpWithError()
    
    imageUseCaseMock = ImageUseCaseMock()
    imageUseCaseMock.setFakeResult(.success(fakeImage))
    
    sut = ImageViewModel(imageUseCase: imageUseCaseMock)
  }
  
  func givenThatViewModelIsBound() {
    sut.bindableImage.bind { [weak self] image in
      self?.image = image
    }
  }
  
  func whenUrlIsSet(_ fakeUrl: String) {
    sut.url = fakeUrl
  }
  
  func theImageShouldBe(_ expected: UIImage?) {
    XCTAssertEqual(expected, image)
  }
  
  func testShouldRequestImageWhenUrlIsSet() throws {
    givenThatViewModelIsBound()
    
    whenUrlIsSet(fakeUrl)
    theImageShouldBe(fakeImage)
  }
}

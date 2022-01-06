//
//  ItemCellViewModelTests.swift
//  luzie-locke-iosTests
//
//  Created by Harry on 19.12.21.
//

import XCTest

@testable import luzie_locke_ios

class ItemCellViewModelTests: XCTestCase {

  var sut: ItemCellViewModel!
  
  var itemTitleText:    String?
  var itemLocationText: String?
  var itemDateText:     String?
  var itemImage:        UIImage?
  
  var imageUseCaseSpy:   ImageUseCaseSpy!
  
  let fakeModel   = FakeModels.itemListElement()
  let fakeUIImage = UIImage(systemName: "location")
  
  override func setUpWithError() throws {
    try super.setUpWithError()
    
    imageUseCaseSpy     = ImageUseCaseSpy()
    sut                 = ItemCellViewModel(imageUseCase: imageUseCaseSpy)
  }
  
  func givenThatViewModelIsBound() {
    sut.bindableItemImage.bind { [weak self] image in
      self?.itemImage = image
    }
    
    sut?.bindableTitleText.bind { [weak self] text in
      self?.itemTitleText = text
    }
    
    sut?.bindableLocationText.bind { [weak self] text in
      self?.itemLocationText = text
    }
    
    sut?.bindableDateText.bind { [weak self] text in
      self?.itemDateText = text
    }
  }
  
  func whenModelIsSet(_ model: ItemListElement) {
    sut.model = model
  }
  
  func whenImageIsFetchedWith(_ result: Result<UIImage?, LLError>) {
    guard let callback = imageUseCaseSpy.completionCallbackWithUrl else { return }
    callback(result)
  }
  
  func theTitleTextShouldBe(_ expected: String) {
    XCTAssertEqual(expected, itemTitleText)
  }
  
  func theLocationTextShouldBe(_ expected: String) {
    XCTAssertEqual(expected, itemLocationText)
  }
  
  func shouldTriggerGetImage() {
    XCTAssertTrue(imageUseCaseSpy.getImageWithUrlIsCalled)
  }
  
  func theImageShouldBe(_ expected: UIImage?) {
    XCTAssertEqual(expected, itemImage)
  }

  func testShouldLoadTextsWhenModelIsSet() throws {
    givenThatViewModelIsBound()
    
    whenModelIsSet(fakeModel)
    theTitleTextShouldBe(fakeModel.title)
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

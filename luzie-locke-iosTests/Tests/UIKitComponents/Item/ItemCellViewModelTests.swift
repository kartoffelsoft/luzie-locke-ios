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
  
  var imageUseCaseMock: ImageUseCaseMock!
  
  let fakeModel   = FakeModels.itemListElement()
  let fakeUIImage = UIImage(systemName: "location")
  
  override func setUpWithError() throws {
    try super.setUpWithError()
    
    imageUseCaseMock  = ImageUseCaseMock()
    sut               = ItemCellViewModel(imageUseCase: imageUseCaseMock)
    
    imageUseCaseMock.setFakeResult(.success(fakeUIImage))
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
  
  func givenMockIsConfiguredToFailDownload() {
    imageUseCaseMock.setFakeResult(.failure(.unableToComplete))
  }
  
  func whenModelIsSet(_ model: ItemListElement) {
    sut.model = model
  }
  
  func theTitleTextShouldBe(_ expected: String) {
    XCTAssertEqual(expected, itemTitleText)
  }
  
  func theLocationTextShouldBe(_ expected: String) {
    XCTAssertEqual(expected, itemLocationText)
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

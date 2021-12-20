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
  
  var itemTitleLabel:     UILabel!
  var itemLocationLabel:  UILabel!
  var itemDateLabel:      UILabel!
  var itemImageView:      UIImageView!
  
  var imageUseCaseSpy:   ImageUseCaseSpy!
  
  let fakeModel   = FakeModels.itemListElement()
  let fakeUIImage = UIImage(systemName: "location")
  
  override func setUpWithError() throws {
    try super.setUpWithError()
    
    imageUseCaseSpy     = ImageUseCaseSpy()
    sut                 = ItemCellViewModel(imageUseCase: imageUseCaseSpy)
    
    itemTitleLabel      = UILabel()
    itemLocationLabel   = UILabel()
    itemDateLabel       = UILabel()
    itemImageView       = UIImageView()
  }
  
  func givenThatViewModelIsBound() {
    sut.bindableItemImage.bind { [weak self] image in
      self?.itemImageView.image = image
    }
    
    sut?.bindableTitleText.bind { [weak self] text in
      self?.itemTitleLabel.text = text
    }
    
    sut?.bindableLocationText.bind { [weak self] text in
      self?.itemLocationLabel.text = text
    }
    
    sut?.bindableDateText.bind { [weak self] text in
      self?.itemDateLabel.text = text
    }
  }
  
  func whenModelIsSet(_ model: ItemListElement) {
    sut.model = model
  }
  
  func whenImageIsFetchedWith(_ result: Result<UIImage?, LLError>) {
    imageUseCaseSpy.fetchCompletionWith(result)
  }
  
  func theTitleTextShouldBe(_ expected: String) {
    XCTAssertEqual(expected, itemTitleLabel.text)
  }
  
  func theLocationTextShouldBe(_ expected: String) {
    XCTAssertEqual(expected, itemLocationLabel.text)
  }
  
  func shouldTriggerGetImage() {
    XCTAssertTrue(imageUseCaseSpy.getImageIsCalled)
  }
  
  func theImageShouldBe(_ expected: UIImage?) {
    XCTAssertEqual(expected, itemImageView.image)
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

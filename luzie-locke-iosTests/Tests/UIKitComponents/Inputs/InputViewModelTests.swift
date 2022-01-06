//
//  InputViewModelTests.swift
//  luzie-locke-iosTests
//
//  Created by Harry on 06.01.22.
//

import XCTest

@testable import luzie_locke_ios

class InputViewModelTests: XCTestCase {

  var sut: InputViewModel!

  var text: String?
  var textColor: UIColor?
  
  let activeColor = CustomUIColors.primaryColor
  let inactiveColor = CustomUIColors.primaryColorLight1
  
  override func setUpWithError() throws {
    try super.setUpWithError()

    sut = InputViewModel(placeholder: "Enter text here")
    
    text      = nil
    textColor = nil
  }
  
  func givenThatViewModelIsBound() {
    text = sut.bindableText.value
    textColor = sut.bindableTextColor.value
    
    sut.bindableText.bind { [weak self] text in
      self?.text = text
    }
    
    sut.bindableTextColor.bind { [weak self] textColor in
      self?.textColor = textColor
    }
  }
  
  func whenBeginEditing() {
    sut.didBeginEditing()
  }
  
  func whenChangeInput(_ text: String?) {
    sut.didChangeInput(text: text)
  }
  
  func whenEndEditing() {
    sut.didEndEditing()
  }
  
  func theTextShouldBe(_ expected: String?) {
    XCTAssertEqual(expected, text)
  }
  
  func theTextColorShouldBe(_ expected: UIColor?) {
    XCTAssertEqual(expected, textColor)
  }
  
  func testShouldShowInactiveOnInit() throws {
    givenThatViewModelIsBound()
    theTextShouldBe("Enter text here")
    theTextColorShouldBe(inactiveColor)
  }
  
  func testShouldShowActiveWhenBeginEditing() throws {
    givenThatViewModelIsBound()
    
    whenBeginEditing()
    theTextShouldBe(nil)
    theTextColorShouldBe(activeColor)
    
    whenChangeInput("a")
    theTextShouldBe("a")
    theTextColorShouldBe(activeColor)
  }
  
  func testShouldShowInactiveIfTextIsEmptyWhenEndEditing() throws {
    givenThatViewModelIsBound()
    
    whenBeginEditing()
    whenChangeInput("a")
    whenChangeInput("ab")
    whenChangeInput("a")
    whenChangeInput("")
    theTextColorShouldBe(activeColor)

    whenEndEditing()
    theTextColorShouldBe(inactiveColor)
  }
}

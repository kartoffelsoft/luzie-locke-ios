//
//  ItemActionPanelViewModelTests.swift
//  luzie-locke-iosTests
//
//  Created by Harry on 05.01.22.
//

import XCTest

@testable import luzie_locke_ios

class ItemActionPanelViewModelTests: XCTestCase {

  var sut:                          ItemActionPanelViewModel!
  var coordinatorSpy:               ItemDisplayCoordinatorSpy!
  var myProfileUseCaseMock:         MyProfileUseCaseMock!
  var userFavoriteItemUseCaseMock:  UserFavoriteItemUseCaseMock!

  var fakeProfile: UserProfile!   = FakeModels.userProfile()
  var fakeModel: ItemActionPanel! = FakeModels.itemActionPanel()

  var priceText:  String?
  var isMine:     Bool?
  var favoriteOn: Bool?
  
  override func setUpWithError() throws {
    try super.setUpWithError()
    
    coordinatorSpy              = ItemDisplayCoordinatorSpy()
    myProfileUseCaseMock        = MyProfileUseCaseMock()
    userFavoriteItemUseCaseMock = UserFavoriteItemUseCaseMock()
    
    sut = ItemActionPanelViewModel(coordinator: coordinatorSpy,
                                   myProfileUseCase: myProfileUseCaseMock,
                                   userFavoriteItemUseCase: userFavoriteItemUseCaseMock)
    
    priceText   = nil
    isMine      = nil
    favoriteOn  = nil
  }
  
  func givenThatViewModelIsBound() {
    sut.bindablePriceText.bind { [weak self] text in
      self?.priceText = text
    }
    
    sut.bindableIsMine.bind { [weak self] isMine in
      self?.isMine = isMine
    }
    
    sut.bindableFavoriteOn.bind { [weak self] favoriteOn in
      self?.favoriteOn = favoriteOn
    }
  }
  
  func givenThatItemIsMine() {
    fakeProfile = FakeModels.userProfile()
    fakeModel   = FakeModels.itemActionPanel(sellerId: fakeProfile.id!)
    myProfileUseCaseMock.setFakeProfile(fakeProfile)
  }
  
  func givenThatItemIsNotMine() {
    fakeProfile = FakeModels.userProfile()
    fakeModel   = FakeModels.itemActionPanel(sellerId: fakeProfile.id! + "9")
    myProfileUseCaseMock.setFakeProfile(fakeProfile)
  }
  
  func givenThatModelIsSet(_ model: ItemActionPanel) {
    whenModelIsSet(model)
  }
  
  func whenModelIsSet(_ model: ItemActionPanel) {
    sut.model = model
  }
  
  func whenChatButtonIsTapped() {
    sut.didTapChatButton()
  }
  
  func whenEditButtonIsTapped() {
    sut.didTapEditButton()
  }
  
  func testShouldLoadPriceTextWhenModelIsSet() throws {
    givenThatViewModelIsBound()
    givenThatItemIsMine()
    
    whenModelIsSet(fakeModel)
    XCTAssertEqual(fakeModel.price, priceText)
  }
  
  func testShouldSetIsMineTrueWhenItemIsMine() throws {
    givenThatViewModelIsBound()
    givenThatItemIsMine()
    
    whenModelIsSet(fakeModel)
    XCTAssertEqual(true, isMine)
  }
  
  func testShouldSetIsMineFalseWhenItemIsNotMine() throws {
    givenThatViewModelIsBound()
    givenThatItemIsNotMine()
    
    whenModelIsSet(fakeModel)
    XCTAssertEqual(false, isMine)
  }
  
  func testShouldNavigateToChatWhenChatButtonIsTapped() throws {
    givenThatViewModelIsBound()
    givenThatItemIsNotMine()
    givenThatModelIsSet(fakeModel)
    
    whenChatButtonIsTapped()
    XCTAssertEqual(1, coordinatorSpy.navigateToChatCallLog.callCount)
    XCTAssertEqual(fakeModel.id, coordinatorSpy.navigateToChatCallLog.itemId ?? "")
    XCTAssertEqual(fakeModel.sellerId, coordinatorSpy.navigateToChatCallLog.remoteUserId ?? "")
  }
  
  func testShouldNavigateToEditWhenEditButtonIsTapped() throws {
    givenThatViewModelIsBound()
    givenThatItemIsMine()
    givenThatModelIsSet(fakeModel)
    
    whenEditButtonIsTapped()
    XCTAssertEqual(1, coordinatorSpy.navigateToItemUpdateCallLog.callCount)
    XCTAssertEqual(fakeModel.id, coordinatorSpy.navigateToItemUpdateCallLog.itemId ?? "")
  }
}

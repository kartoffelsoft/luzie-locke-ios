//
//  SettingsViewModelTests.swift
//  luzie-locke-iosTests
//
//  Created by Harry on 08.01.22.
//

import XCTest

@testable import luzie_locke_ios

class SettingsViewModelTests: XCTestCase {

  var sut:                  SettingsViewModel!
  var coordinatorSpy:       SettingsCoordinatorSpy!
  var authUseCaseMock:      AuthUseCaseMock!
  var myProfileUseCaseMock: MyProfileUseCaseMock!
  var imageUseCaseMock:     ImageUseCaseMock!
  
  override func setUpWithError() throws {
    try super.setUpWithError()
    
    coordinatorSpy        = SettingsCoordinatorSpy()
    authUseCaseMock       = AuthUseCaseMock()
    myProfileUseCaseMock  = MyProfileUseCaseMock()
    imageUseCaseMock      = ImageUseCaseMock()
    sut                   = SettingsViewModel(coordinator: coordinatorSpy,
                                              authUseCase: authUseCaseMock,
                                              myProfileUseCase: myProfileUseCaseMock,
                                              imageUseCase: imageUseCaseMock)
  }
}

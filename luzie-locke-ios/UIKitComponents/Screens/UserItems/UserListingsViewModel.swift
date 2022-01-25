//
//  UserListingsViewModel.swift
//  luzie-locke-ios
//
//  Created by Harry on 23.11.21.
//

import Foundation

class UserListingsViewModel {
  
  let coordinator:          SettingsCoordinator
  let imageUseCase:         ImageUseCaseProtocol
  let userOpenItemUseCase:  UserOpenItemUseCaseProtocol
  let userSoldItemUseCase:  UserSoldItemUseCaseProtocol
  
  init(coordinator:           SettingsCoordinator,
       imageUseCase:          ImageUseCaseProtocol,
       userOpenItemUseCase:   UserOpenItemUseCaseProtocol,
       userSoldItemUseCase:   UserSoldItemUseCaseProtocol) {
    self.coordinator          = coordinator
    self.imageUseCase         = imageUseCase
    self.userOpenItemUseCase  = userOpenItemUseCase
    self.userSoldItemUseCase  = userSoldItemUseCase
  }
}


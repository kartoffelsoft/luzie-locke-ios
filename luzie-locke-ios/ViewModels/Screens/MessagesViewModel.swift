//
//  MessagesViewModel.swift
//  luzie-locke-ios
//
//  Created by Harry on 10.11.21.
//

import Foundation

class MessagesViewModel {
  
  let coordinator:          MessagesCoordinator
  let profileRepository:    ProfileRepository

  init(coordinator:         MessagesCoordinator,
       profileRepository:   ProfileRepository) {
    self.coordinator        = coordinator
    self.profileRepository  = profileRepository
  }
  
  func didSelectItemAt(indexPath: IndexPath) {
//    if let item = bindableItems.value?[indexPath.row], let id = item._id {
      coordinator.navigateToChat()
//    }
  }
}

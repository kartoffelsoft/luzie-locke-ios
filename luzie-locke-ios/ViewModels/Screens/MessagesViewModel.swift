//
//  MessagesViewModel.swift
//  luzie-locke-ios
//
//  Created by Harry on 10.11.21.
//

import Foundation

class MessagesViewModel {
  
  let coordinator:        MessagesCoordinator
  let profileStorage:     AnyStorage<User>

  init(coordinator:       MessagesCoordinator,
       profileStorage:    AnyStorage<User>) {
    self.coordinator      = coordinator
    self.profileStorage   = profileStorage
  }
  
  func didSelectItemAt(indexPath: IndexPath) {
//    if let item = bindableItems.value?[indexPath.row], let id = item._id {
      coordinator.navigateToChat()
//    }
  }
}

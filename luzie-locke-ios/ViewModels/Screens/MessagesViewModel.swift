//
//  MessagesViewModel.swift
//  luzie-locke-ios
//
//  Created by Harry on 10.11.21.
//

import Foundation

class MessagesViewModel {
  
  let coordinator:              MessagesCoordinator
  let localProfileRepository:   LocalProfileRepository

  init(coordinator:             MessagesCoordinator,
       localProfileRepository:  LocalProfileRepository) {
    self.coordinator            = coordinator
    self.localProfileRepository = localProfileRepository
  }
  
  func didSelectItemAt(indexPath: IndexPath) {
//    if let item = bindableItems.value?[indexPath.row], let id = item._id {
      coordinator.navigateToChat()
//    }
  }
}

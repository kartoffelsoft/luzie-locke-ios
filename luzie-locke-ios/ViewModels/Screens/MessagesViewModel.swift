//
//  MessagesViewModel.swift
//  luzie-locke-ios
//
//  Created by Harry on 10.11.21.
//

import Foundation

class MessagesViewModel {
  
  var bindableMessages = Bindable<[RecentMessage]>()
  
  private let coordinator:              MessagesCoordinator
  private let localProfileRepository:   LocalProfileRepository
  private let recentMessageRepository:  RecentMessageRepository

  init(coordinator:               MessagesCoordinator,
       localProfileRepository:    LocalProfileRepository,
       recentMessageRepository:   RecentMessageRepository) {
    self.coordinator              = coordinator
    self.localProfileRepository   = localProfileRepository
    self.recentMessageRepository  = recentMessageRepository
    
    bindableMessages.value = [RecentMessage]()
  }
  
  func didLoad() {
    guard let profile = localProfileRepository.read() else { return }
    
    recentMessageRepository.read(localUserId: profile._id!) { [weak self] messages in
      self?.bindableMessages.value?.append(contentsOf: messages)
    }
  }
  
  func willDisappear() {
    recentMessageRepository.stop()
  }
  
  func didSelectItemAt(indexPath: IndexPath) {
//    if let item = bindableItems.value?[indexPath.row], let id = item._id {
      coordinator.navigateToChat()
//    }
  }
}

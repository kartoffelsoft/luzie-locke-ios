//
//  MessagesViewModel.swift
//  luzie-locke-ios
//
//  Created by Harry on 10.11.21.
//

import Foundation

class MessagesViewModel {
  
  var bindableRecentMessages      = Bindable<[RecentMessage]>()
  
  var recentMessagesViewModels    = [RecentMessageCellViewModel]()
  
  private var recentMessagesDictionary              = [String: RecentMessage]()
  private var recentMessagesViewModelsDictionary    = [String: RecentMessageCellViewModel]()
  
  private let coordinator:              MessagesCoordinator
  private let openHttpClient:           OpenHTTPClient
  private let localProfileRepository:   LocalProfileRepository
  private let chatMessageRepository:    ChatMessageRepository
  private let recentMessageRepository:  RecentMessageRepository

  init(coordinator:               MessagesCoordinator,
       openHttpClient:            OpenHTTPClient,
       localProfileRepository:    LocalProfileRepository,
       chatMessageRepository:     ChatMessageRepository,
       recentMessageRepository:   RecentMessageRepository) {
    self.coordinator              = coordinator
    self.openHttpClient           = openHttpClient
    self.localProfileRepository   = localProfileRepository
    self.chatMessageRepository    = chatMessageRepository
    self.recentMessageRepository  = recentMessageRepository
    
    bindableRecentMessages.value = [RecentMessage]()
  }
  
  private func reload() {
    recentMessagesViewModels = Array(recentMessagesViewModelsDictionary.values).sorted(by: { v1, v2 in
      return v1.message!.date.compare(v2.message!.date) == .orderedDescending
    })
    
    bindableRecentMessages.value = Array(recentMessagesDictionary.values).sorted(by: { m1, m2 in
      return m1.date.compare(m2.date) == .orderedDescending
    })
  }
  
  func didLoad() {
    guard let profile = localProfileRepository.read() else { return }
    
    recentMessageRepository.read(localUserId: profile.id!) { [weak self] messages in
      guard let self = self else { return }
      messages.forEach { message in
        self.recentMessagesDictionary[message.id] = message
        
        if let viewModel  = self.recentMessagesViewModelsDictionary[message.id] {
          viewModel.message = message

        } else {
          let viewModel = RecentMessageCellViewModel(openHttpClient: self.openHttpClient)
          viewModel.message = message
          self.recentMessagesViewModelsDictionary[message.id] = viewModel
        }
      }
      
      self.reload()
    }
  }
  
  func willDisappear() {
    recentMessageRepository.stop()
  }
  
  func didTapMessageAt(indexPath: IndexPath) {
    guard let remoteUserId = bindableRecentMessages.value?[indexPath.row].id else { return }
    coordinator.navigateToChat(remoteUserId: remoteUserId)
  }
  
  func didTapDeleteMessageAt(indexPath: IndexPath) {
    guard let localUserId  = localProfileRepository.read()?.id else { return }
    guard let remoteUserId = bindableRecentMessages.value?[indexPath.row].id else { return }
    
    recentMessageRepository.delete(localUserId: localUserId, remoteUserId: remoteUserId)
    chatMessageRepository.delete(localUserId: localUserId, remoteUserId: remoteUserId)
    
    recentMessagesViewModelsDictionary[remoteUserId]  = nil
    recentMessagesDictionary[remoteUserId]            = nil

    recentMessagesViewModels.remove(at: indexPath.row)
    bindableRecentMessages.value?.remove(at: indexPath.row)
  }
}

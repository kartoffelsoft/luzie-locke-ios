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
    
    NotificationCenter.default.addObserver(self, selector: #selector(handleDidLoginNotification), name: .didLogin, object: nil)
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
    refresh()
  }
  
  func refresh() {
    guard let profile = localProfileRepository.read() else { return }
    
    bindableRecentMessages.value          = [RecentMessage]()
    recentMessagesViewModels              = [RecentMessageCellViewModel]()
    recentMessagesDictionary              = [String: RecentMessage]()
    recentMessagesViewModelsDictionary    = [String: RecentMessageCellViewModel]()
    
    print("refresh: ", profile.id!)
    recentMessageRepository.read(localUserId: profile.id!) { [weak self] messages in
      guard let self = self else { return }
      print("get message,", messages)
      messages.forEach { message in
        self.recentMessagesDictionary[message.id] = message
        
        if let viewModel = self.recentMessagesViewModelsDictionary[message.id] {
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
    guard let remoteUserId = bindableRecentMessages.value?[indexPath.row].userId else { return }
    guard let itemId = bindableRecentMessages.value?[indexPath.row].itemId else { return }
    print("@@@")
    print("remoteUserId:", remoteUserId)
    print("itemId:", itemId)
    coordinator.navigateToChat(remoteUserId: remoteUserId, itemId: itemId)
  }
  
  func didTapDeleteMessageAt(indexPath: IndexPath) {
    guard let localUserId  = localProfileRepository.read()?.id else { return }
    guard let messageId = bindableRecentMessages.value?[indexPath.row].id else { return }
    guard let remoteUserId = bindableRecentMessages.value?[indexPath.row].userId else { return }
    guard let itemId = bindableRecentMessages.value?[indexPath.row].itemId else { return }
    
    recentMessageRepository.delete(localUserId: localUserId, remoteUserId: remoteUserId, itemId: itemId)
    chatMessageRepository.delete(localUserId: localUserId, remoteUserId: remoteUserId, itemId: itemId)
    
    recentMessagesViewModelsDictionary[messageId]  = nil
    recentMessagesDictionary[messageId]            = nil

    recentMessagesViewModels.remove(at: indexPath.row)
    bindableRecentMessages.value?.remove(at: indexPath.row)
  }
  
  @objc private func handleDidLoginNotification() {
    refresh()
  }
}

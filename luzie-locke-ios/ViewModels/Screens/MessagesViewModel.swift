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
  private let imageUseCase:             ImageUseCaseProtocol
  private let localProfileRepository:   LocalProfileRepository
  private let chatMessageRepository:    ChatMessageRepository
  private let recentMessageRepository:  RecentMessageRepository

  init(coordinator:               MessagesCoordinator,
       imageUseCase:              ImageUseCaseProtocol,
       localProfileRepository:    LocalProfileRepository,
       chatMessageRepository:     ChatMessageRepository,
       recentMessageRepository:   RecentMessageRepository) {
    self.coordinator              = coordinator
    self.imageUseCase             = imageUseCase
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
    
    recentMessageRepository.read(localUserId: profile.id!) { [weak self] messages in
      guard let self = self else { return }

      messages.forEach { message in
        self.recentMessagesDictionary[message.id] = message
        
        if let viewModel = self.recentMessagesViewModelsDictionary[message.id] {
          viewModel.message = message

        } else {
          let viewModel = RecentMessageCellViewModel(imageUseCase: self.imageUseCase)
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

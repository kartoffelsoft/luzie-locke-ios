//
//  ChatViewModel.swift
//  luzie-locke-ios
//
//  Created by Harry on 10.11.21.
//

import Foundation

enum ChatViewActionButtonType {
  case clear
  case sold
  case reopen
}

class ChatViewModel {
  
  var bindableMessages = Bindable<[ChatMessage]>()
  var bindableSoldOutViewIsHidden = Bindable<Bool>()
  var bindableActionButtonType = Bindable<ChatViewActionButtonType>()
  
  private let remoteUserId: String
  private let itemId: String

  private let itemTradeStateUseCase:    ItemTradeStateUseCaseProtocol
  private let userProfileRepository:    UserProfileRepositoryProtocol
  private let chatMessageRepository:    ChatMessageRepositoryProtocol
  private let recentMessageRepository:  RecentMessageRepositoryProtocol
  
  private var localUserProfile:   UserProfile?
  private var remoteUserProfile:  UserProfile?

  init(remoteUserId:              String,
       itemId:                    String,
       itemTradeStateUseCase:     ItemTradeStateUseCaseProtocol,
       userProfileRepository:     UserProfileRepositoryProtocol,
       chatMessageRepository:     ChatMessageRepositoryProtocol,
       recentMessageRepository:   RecentMessageRepositoryProtocol) {
    self.remoteUserId             = remoteUserId
    self.itemId                   = itemId
    self.itemTradeStateUseCase    = itemTradeStateUseCase
    self.userProfileRepository    = userProfileRepository
    self.chatMessageRepository    = chatMessageRepository
    self.recentMessageRepository  = recentMessageRepository
    
    bindableMessages.value              = [ChatMessage]()
    bindableSoldOutViewIsHidden.value   = true
    bindableActionButtonType.value      = .clear
  }
  
  func didLoad() {
    userProfileRepository.readLocal() { [weak self] result in
      guard let self = self else { return }
      switch(result) {
      case .success(let user):
        self.localUserProfile = user
        self.chatMessageRepository.read(localUserId: user.id!, remoteUserId: self.remoteUserId, itemId: self.itemId) { [weak self] messages in
          self?.bindableMessages.value?.append(contentsOf: messages)
        }
      case .failure(let error):
        print(error)
      }
    }
    
    userProfileRepository.readRemote(remoteUserId) { [weak self] result in
      switch(result) {
      case .success(let user):
        self?.remoteUserProfile = user
      case .failure(let error):
        print(error)
      }
    }
    
    itemTradeStateUseCase.getState(itemId: itemId) { [weak self] result in
      switch(result) {
      case .success((let state, let sellerId, _)):
        guard let userId = self?.localUserProfile?.id else { return }
        
        self?.bindableSoldOutViewIsHidden.value   = state == "open"
        
        if sellerId == userId {
          self?.bindableActionButtonType.value = (state == "open") ? .sold : .reopen
        } else {
          self?.bindableActionButtonType.value =  .clear
        }
        
      case .failure(let error):
        print(error)
      }
    }
  }
  
  func willDisappear() {
    chatMessageRepository.stop()
  }
  
  func didTapSend(text: String) {
    if let remoteUserProfile = remoteUserProfile, let localUserProfile = localUserProfile {
      chatMessageRepository.create(text: text,
                                   localUserId: localUserProfile.id!,
                                   remoteUserId: remoteUserProfile.id!,
                                   itemId: itemId)
                                   
      recentMessageRepository.create(text: text,
                                     localUserId: localUserProfile.id!,
                                     localUserName: localUserProfile.name!,
                                     remoteUserId: remoteUserId,
                                     remoteUserName: remoteUserProfile.name!,
                                     itemId: itemId)
    }
  }
  
  func didTapSold() {
    itemTradeStateUseCase.setSold(itemId: itemId, buyerId: remoteUserId) { [weak self] result in
      switch(result) {
      case .success((let state, let sellerId, _)):
        guard let userId = self?.localUserProfile?.id else { return }
        
        self?.bindableSoldOutViewIsHidden.value = state == "open"
        
        print("SellerId: ", sellerId)
        print("userId: ", userId)
        if sellerId == userId {
          self?.bindableActionButtonType.value = (state == "open") ? .sold : .reopen
        } else {
          self?.bindableActionButtonType.value =  .clear
        }
        
      case .failure(let error):
        print(error)
      }
    }
  }
  
  func didTapReopen() {
    itemTradeStateUseCase.setOpen(itemId: itemId) { [weak self] result in
      switch(result) {
      case .success((let state, let sellerId, _)):
        guard let userId = self?.localUserProfile?.id else { return }
        
        self?.bindableSoldOutViewIsHidden.value = state == "open"
        
        if sellerId == userId {
          self?.bindableActionButtonType.value = (state == "open") ? .sold : .reopen
        } else {
          self?.bindableActionButtonType.value =  .clear
        }
        
      case .failure(let error):
        print(error)
      }
    }
  }
}

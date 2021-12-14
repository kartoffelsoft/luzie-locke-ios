//
//  ChatViewModel.swift
//  luzie-locke-ios
//
//  Created by Harry on 10.11.21.
//

import UIKit

enum ChatViewActionButtonType {
  case clear
  case sold
  case reopen
}

class ChatViewModel {
  
  var bindableMessages            = Bindable<[ChatMessage]>()
  var bindableItemImage           = Bindable<UIImage>()
  var bindableBuyerImage          = Bindable<UIImage>()
  var bindableIsOwner             = Bindable<Bool>()
  var bindableSoldOutViewIsHidden = Bindable<Bool>()
  var bindableActionButtonType    = Bindable<ChatViewActionButtonType>()
  
  private let remoteUserId: String
  private let itemId: String

  private let imageUseCase:             ImageUseCaseProtocol
  private let itemControlUseCase:       ItemControlUseCaseProtocol
  private let userProfileRepository:    UserProfileRepositoryProtocol
  private let chatMessageRepository:    ChatMessageRepositoryProtocol
  private let recentMessageRepository:  RecentMessageRepositoryProtocol
  
  private var localUserProfile:   UserProfile?
  private var remoteUserProfile:  UserProfile?

  init(remoteUserId:              String,
       itemId:                    String,
       imageUseCase:              ImageUseCaseProtocol,
       itemControlUseCase:        ItemControlUseCaseProtocol,
       userProfileRepository:     UserProfileRepositoryProtocol,
       chatMessageRepository:     ChatMessageRepositoryProtocol,
       recentMessageRepository:   RecentMessageRepositoryProtocol) {
    self.remoteUserId             = remoteUserId
    self.imageUseCase             = imageUseCase
    self.itemId                   = itemId
    self.itemControlUseCase       = itemControlUseCase
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
    
    itemControlUseCase.getItem(itemId: itemId) { [weak self] result in
      guard let self = self else { return }
      
      switch(result) {
      case .success(let item):
        guard let userId    = self.localUserProfile?.id   else { return }
        guard let ownerId   = item.user?.id               else { return }
        guard let state     = item.state                  else { return }
        guard let imageUrl  = item.imageUrls?[0]          else { return }
        
        let isOwner = (ownerId == userId)
        let buyerId = isOwner ? self.remoteUserId : userId
        
        self.configureButtons(state: state, isOwner: isOwner)
        self.configureItemImage(imageUrl: imageUrl)
        self.configureBuyerImage(buyerId: buyerId)

        print("@:", isOwner)
        print("@@:", ownerId)
        print("@@@:", userId)
        self.bindableIsOwner.value = isOwner
        
      case .failure(let error):
        print(error)
      }
    }
  }
  
  private func configureButtons(state: String, isOwner: Bool) {
    bindableSoldOutViewIsHidden.value = (state == "open")
    
    if isOwner {
      bindableActionButtonType.value = (state == "open") ? .sold : .reopen
    } else {
      bindableActionButtonType.value =  .clear
    }
  }
  
  private func configureItemImage(imageUrl: String) {
    self.imageUseCase.getImage(url: imageUrl, completion: { [weak self] result in
      switch result {
      case .success(let image):
        self?.bindableItemImage.value = image
      case .failure:
        ()
      }
    })
  }
  
  private func configureBuyerImage(buyerId: String) {
    self.imageUseCase.getImage(userId: buyerId) { [weak self] result in
      switch result {
      case .success(let image):
        self?.bindableBuyerImage.value = image
      case .failure:
        ()
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
    itemControlUseCase.setSold(itemId: itemId, buyerId: remoteUserId) { [weak self] result in
      switch(result) {
      case .success:
        self?.bindableSoldOutViewIsHidden.value = false
        self?.bindableActionButtonType.value = .reopen
        
      case .failure(let error):
        print(error)
      }
    }
  }
  
  func didTapReopen() {
    itemControlUseCase.setOpen(itemId: itemId) { [weak self] result in
      switch(result) {
      case .success:
        self?.bindableSoldOutViewIsHidden.value = true
        self?.bindableActionButtonType.value = .sold
        
      case .failure(let error):
        print(error)
      }
    }
  }
}

//
//  ChatViewModel.swift
//  luzie-locke-ios
//
//  Created by Harry on 10.11.21.
//

import Foundation

class ChatViewModel {
  
  var bindableMessages = Bindable<[ChatMessage]>()
  
  private let remoteUserId: String

  private let userProfileRepository:    UserProfileRepository
  private let chatMessageRepository:    ChatMessageRepositoryProtocol
  private let recentMessageRepository:  RecentMessageRepositoryProtocol
  
  private var localUserProfile:   UserProfile?
  private var remoteUserProfile:  UserProfile?

  init(remoteUserId:              String,
       userProfileRepository:     UserProfileRepository,
       chatMessageRepository:     ChatMessageRepositoryProtocol,
       recentMessageRepository:   RecentMessageRepositoryProtocol) {
    self.remoteUserId             = remoteUserId
    self.userProfileRepository    = userProfileRepository
    self.chatMessageRepository    = chatMessageRepository
    self.recentMessageRepository  = recentMessageRepository
    
    bindableMessages.value = [ChatMessage]()
  }
  
  func didLoad() {
    userProfileRepository.readLocal() { [weak self] result in
      guard let self = self else { return }
      switch(result) {
      case .success(let user):
        self.localUserProfile = user
        self.chatMessageRepository.read(localUserId: user._id!, remoteUserId: self.remoteUserId) { [weak self] messages in
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
  }
  
  func willDisappear() {
    chatMessageRepository.stop()
  }
  
  func didTapSend(text: String) {
    if let remoteUserProfile = remoteUserProfile, let localUserProfile = localUserProfile {
      chatMessageRepository.create(text: text,
                                   localUserId: localUserProfile._id!,
                                   remoteUserId: remoteUserProfile._id!)
                                   
      recentMessageRepository.create(text: text,
                                     localUserId: localUserProfile._id!,
                                     localUserName: localUserProfile.name!,
                                     localUserImageUrl: localUserProfile.pictureURI ?? "",
                                     remoteUserId: remoteUserId, remoteUserName: remoteUserProfile.name!,
                                     remoteUserImageUrl: remoteUserProfile.pictureURI ?? "")
    }
  }
}

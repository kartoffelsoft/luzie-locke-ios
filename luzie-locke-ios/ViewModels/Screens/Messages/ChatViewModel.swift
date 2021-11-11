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
  private let localUserProfile: User
  private let userProfileRepository: UserProfileRepository
  private let chatMessageRepository: ChatMessageRepositoryProtocol
  private let recentMessageRepository: RecentMessageRepositoryProtocol
  
  private var remoteUserProfile: UserProfile?
  
  init(remoteUserId: String,
       localUserProfile: User,
       userProfileRepository: UserProfileRepository,
       chatMessageRepository: ChatMessageRepositoryProtocol,
       recentMessageRepository: RecentMessageRepositoryProtocol) {
    self.remoteUserId             = remoteUserId
    self.localUserProfile         = localUserProfile
    self.userProfileRepository    = userProfileRepository
    self.chatMessageRepository    = chatMessageRepository
    self.recentMessageRepository  = recentMessageRepository
    
    bindableMessages.value = [ChatMessage]()
  }
  
  func didLoad() {
    chatMessageRepository.read(localUserId: localUserProfile._id!, remoteUserId: remoteUserId) { [weak self] messages in
      self?.bindableMessages.value?.append(contentsOf: messages)
    }
    
    userProfileRepository.read(remoteUserId) { [weak self] result in
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
    if let remoteUserProfile = remoteUserProfile {
      print("text", text)
      print("remoteUserId:", remoteUserId)
      chatMessageRepository.create(localUserId: localUserProfile._id!, remoteUserId: remoteUserId, text: text)
      recentMessageRepository.create(text: text,
                                     localUserId: localUserProfile._id!,
                                     localUserName: localUserProfile.name!,
                                     localUserImageUrl: localUserProfile.pictureURI ?? "",
                                     remoteUserId: remoteUserId, remoteUserName: remoteUserProfile.name!,
                                     remoteUserImageUrl: remoteUserProfile.pictureURI ?? "")
    }
  }
}

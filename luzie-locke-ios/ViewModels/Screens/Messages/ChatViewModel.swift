//
//  ChatViewModel.swift
//  luzie-locke-ios
//
//  Created by Harry on 10.11.21.
//

import Foundation

class ChatViewModel {
  
  var bindableMessages = Bindable<[ChatMessage]>()
  
  private let localUserId: String
  private let remoteUserId: String
  private let chatMessageRepository: ChatMessageRepository
  
  init(localUserId: String,
       remoteUserId: String,
       chatMessageRepository: ChatMessageRepository) {
    self.localUserId            = localUserId
    self.remoteUserId           = remoteUserId
    self.chatMessageRepository  = chatMessageRepository
    
    bindableMessages.value = [ChatMessage]()
  }
  
  func didLoad() {
    chatMessageRepository.read(localUserId: localUserId, remoteUserId: remoteUserId) { [weak self] messages in
      print(messages)
      self?.bindableMessages.value?.append(contentsOf: messages)
    }
  }
  
  func didTapSend(text: String) {
    print("text", text)
    print("localUserId:", localUserId)
    print("remoteUserId:", remoteUserId)
    chatMessageRepository.create(localUserId: localUserId, remoteUserId: remoteUserId, text: text)
  }
}

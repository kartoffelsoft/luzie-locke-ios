//
//  ChatMessageRepository.swift
//  luzie-locke-ios
//
//  Created by Harry on 10.11.21.
//

import Firebase

protocol ChatMessageRepositoryProtocol {
  func create(localUserId: String, remoteUserId: String, text: String)
  func read(localUserId: String, remoteUserId: String, onReceive: @escaping ([ChatMessage]) -> Void)
  func stop()
}

class ChatMessageRepository: ChatMessageRepositoryProtocol {
  
  private var listener: ListenerRegistration?
  
  func create(localUserId: String, remoteUserId: String, text: String) {
    let data = ["sender": localUserId, "receiver": remoteUserId, "text": text, "timestamp": Timestamp(date: Date())] as [String: Any]
    
    let senderCollection = Firestore.firestore().collection("messages").document(localUserId).collection(remoteUserId)
    senderCollection.addDocument(data: data) { error in
      if let error = error { print("[Error:\(#file):\(#line)] \(error)") }
    }
    
    let receiverCollection = Firestore.firestore().collection("messages").document(remoteUserId).collection(localUserId)
    receiverCollection.addDocument(data: data) { error in
      if let error = error { print("[Error:\(#file):\(#line)] \(error)") }
    }
  }
  
  func read(localUserId: String, remoteUserId: String, onReceive: @escaping ([ChatMessage]) -> Void) {
    let query = Firestore.firestore().collection("messages").document(localUserId).collection(remoteUserId).order(by: "timestamp")
    
    listener = query.addSnapshotListener { querySnapshot, error in
      if let error = error {
        print("Failed to fetch messages: ", error)
      }
      
      var messages = [ChatMessage]()
      
      querySnapshot?.documentChanges.forEach({ (change) in
        if change.type == .added {
          let dictionary = change.document.data()
          messages.append(.init(dictionary: dictionary, localUserId: localUserId))
        }
      })
      
      onReceive(messages)
    }
  }
  
  func stop() {
    listener?.remove()
  }
}

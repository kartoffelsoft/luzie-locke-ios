//
//  RecentMessageRepository.swift
//  luzie-locke-ios
//
//  Created by Harry on 11.11.21.
//

import Firebase

protocol RecentMessageRepositoryProtocol {
  
  func create(text: String,
              localUserId: String, localUserName: String, localUserImageUrl: String,
              remoteUserId: String, remoteUserName: String, remoteUserImageUrl: String)
  
  func read(localUserId: String, remoteUserId: String, onReceive: @escaping ([RecentMessage]) -> Void)
  func stop()
}

class RecentMessageRepository: RecentMessageRepositoryProtocol {
  
  private let storeName = "messages"
  private let storeSubName = "recent-messages"
  
  private var listener: ListenerRegistration?
  
  func create(text: String,
              localUserId: String, localUserName: String, localUserImageUrl: String,
              remoteUserId: String, remoteUserName: String, remoteUserImageUrl: String) {
    
    let senderdata = [ "name": remoteUserName, "profileImageUrl": remoteUserImageUrl, "text": text,
                       "timestamp": Timestamp(date: Date()), "id": remoteUserId ] as [String : Any]
    
    Firestore.firestore().collection(storeName).document(localUserId)
                         .collection(storeSubName).document(remoteUserId)
                         .setData(senderdata) { err in
                           if let err = err {
                             print("Failed to save recent message: ", err)
                             return
                           }
                         }
    
    let receiverData = [ "name": localUserName, "profileImageUrl": localUserImageUrl, "text": text,
                         "timestamp": Timestamp(date: Date()), "id": localUserId ] as [String : Any]
    
    Firestore.firestore().collection(storeName).document(remoteUserId)
                         .collection("recent-messages").document(localUserId)
                         .setData(receiverData) { err in
                           if let err = err {
                               print("Failed to save recent message: ", err)
                               return
                           }
                       }
  }
  
  func read(localUserId: String, remoteUserId: String, onReceive: @escaping ([RecentMessage]) -> Void) {
    
    listener = Firestore.firestore().collection(storeName).document(localUserId).collection(storeSubName).addSnapshotListener { (querySnapshot, error) in
      if let error = error {
        print("Failed to fetch messages: ", error)
      }
      
      var messages = [RecentMessage]()
      querySnapshot?.documentChanges.forEach({ (change) in
        if change.type == .added || change.type == .modified {
          let dictionary = change.document.data()
          messages.append(.init(dictionary: dictionary))
        }
      })
      
      onReceive(messages)
    }
  }
  
  func stop() {
    listener?.remove()
  }
}

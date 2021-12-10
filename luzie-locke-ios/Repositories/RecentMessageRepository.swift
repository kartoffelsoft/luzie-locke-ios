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
              remoteUserId: String, remoteUserName: String, remoteUserImageUrl: String,
              itemId: String)
  func read(localUserId: String, onReceive: @escaping ([RecentMessage]) -> Void)
  func delete(localUserId: String, remoteUserId: String, itemId: String, completion: @escaping (Result<Void, LLError>) -> Void)
  func stop()
}

class RecentMessageRepository: RecentMessageRepositoryProtocol {
  
  private let storeName = "messages"
  private let storeSubName = "recent-messages"
  
  private var listener: ListenerRegistration?
  
  func create(text: String,
              localUserId: String, localUserName: String, localUserImageUrl: String,
              remoteUserId: String, remoteUserName: String, remoteUserImageUrl: String,
              itemId: String) {
    
    let senderdata = [ "name": remoteUserName, "profileImageUrl": remoteUserImageUrl, "text": text,
                       "timestamp": Timestamp(date: Date()), "id": remoteUserId + itemId,
                       "userId": remoteUserId, "itemId": itemId] as [String : Any]
    
    Firestore.firestore().collection(storeName).document(localUserId)
                         .collection(storeSubName).document(remoteUserId + itemId)
                         .setData(senderdata) { error in
                           if let error = error {
                             print("Failed to save recent message: ", error)
                             return
                           }
                         }
    
    let receiverData = [ "name": localUserName, "profileImageUrl": localUserImageUrl, "text": text,
                         "timestamp": Timestamp(date: Date()), "id": localUserId + itemId,
                         "userId": localUserId, "itemId": itemId] as [String : Any]
    
    Firestore.firestore().collection(storeName).document(remoteUserId)
                         .collection("recent-messages").document(localUserId + itemId)
                         .setData(receiverData) { error in
                           if let error = error {
                               print("Failed to save recent message: ", error)
                               return
                           }
                       }
  }
  
  func read(localUserId: String, onReceive: @escaping ([RecentMessage]) -> Void) {
    
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
  
  func delete(localUserId: String, remoteUserId: String, itemId: String, completion: @escaping (Result<Void, LLError>) -> Void = {_ in }) {
    Firestore.firestore().collection(storeName).document(localUserId).collection(storeSubName).document(remoteUserId + itemId).delete() { error in
      if let error = error {
        print("[Error:\(#file):\(#line)] \(error)")
        completion(.failure(.serverErrorResponse))
        return
      }
      
      completion(.success(()))
    }
  }
  
  func stop() {
    listener?.remove()
  }
}

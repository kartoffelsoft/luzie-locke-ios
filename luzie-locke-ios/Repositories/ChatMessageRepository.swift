//
//  ChatMessageRepository.swift
//  luzie-locke-ios
//
//  Created by Harry on 10.11.21.
//

import Firebase

protocol ChatMessageRepositoryProtocol {
  
  func create(text: String, localUserId: String, remoteUserId: String, itemId: String)
  func read(localUserId: String, remoteUserId: String, itemId: String, onReceive: @escaping ([ChatMessage]) -> Void)
  func delete(localUserId: String, remoteUserId: String, itemId: String, completion: @escaping (Result<Void, LLError>) -> Void)
  func stop()
}

class ChatMessageRepository: ChatMessageRepositoryProtocol {
  
  private let storeName = "messages"

  private var listener: ListenerRegistration?
  private lazy var firestore = Firestore.firestore()
  
  func create(text: String, localUserId: String, remoteUserId: String, itemId: String) {
    let data = ["sender": localUserId, "receiver": remoteUserId, "text": text, "timestamp": Timestamp(date: Date())] as [String: Any]
    
    let senderCollection = Firestore.firestore().collection(storeName).document(localUserId).collection(remoteUserId + itemId)
    senderCollection.addDocument(data: data) { error in
      if let error = error { print("[Error:\(#file):\(#line)] \(error)") }
    }
    
    let receiverCollection = Firestore.firestore().collection(storeName).document(remoteUserId).collection(localUserId + itemId)
    receiverCollection.addDocument(data: data) { error in
      if let error = error { print("[Error:\(#file):\(#line)] \(error)") }
    }
  }
  
  func read(localUserId: String, remoteUserId: String, itemId: String, onReceive: @escaping ([ChatMessage]) -> Void) {
    let query = Firestore.firestore().collection(storeName).document(localUserId).collection(remoteUserId + itemId).order(by: "timestamp")
    
    listener = query.addSnapshotListener { snapshot, error in
      if let error = error {
        print("[Error:\(#file):\(#line)] \(error)")
      }
      
      var messages = [ChatMessage]()
      snapshot?.documentChanges.forEach({ (change) in
        if change.type == .added {
          let dictionary = change.document.data()
          messages.append(.init(dictionary: dictionary, localUserId: localUserId))
        }
      })
      
      onReceive(messages)
    }
  }
  
  func delete(localUserId: String, remoteUserId: String, itemId: String, completion: @escaping (Result<Void, LLError>) -> Void = {_ in }) {
    let collectionRef = firestore.collection(storeName).document(localUserId).collection(remoteUserId + itemId)
    
    collectionRef.limit(to: 100).getDocuments { (snapshot, error) in
      if let error = error {
        print("[Error:\(#file):\(#line)] \(error)")
        completion(.failure(.serverErrorResponse))
        return
      }

      let batch = collectionRef.firestore.batch()
      snapshot?.documents.forEach { batch.deleteDocument($0.reference) }

      batch.commit { error in
        if let error = error {
          print("[Error:\(#file):\(#line)] \(error)")
          completion(.failure(.serverErrorResponse))
        } else {
          print("Batch write succeeded.")
          completion(.success(()))
        }
      }
    }
  }
  
  func stop() {
    listener?.remove()
  }
}

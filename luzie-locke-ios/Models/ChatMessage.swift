//
//  Message.swift
//  luzie-locke-ios
//
//  Created by Harry on 08.11.21.
//

import Firebase

struct ChatMessage {
  
  let sender:     String
  let receiver:   String
  let text:       String
  let date:       Date
  let isFromSelf: Bool
  
  init(dictionary: [String: Any], localUserId: String) {
    self.sender     = dictionary["sender"] as? String ?? ""
    self.receiver   = dictionary["receiver"] as? String ?? ""
    self.text       = dictionary["text"] as? String ?? ""
    self.date       = (dictionary["timestamp"] as? Timestamp ?? Timestamp(date: Date())).dateValue()
    self.isFromSelf = (sender == localUserId)
  }
}

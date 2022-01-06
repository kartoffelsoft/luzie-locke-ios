//
//  RecentMessage.swift
//  luzie-locke-ios
//
//  Created by Harry on 10.11.21.
//

import Firebase

struct RecentMessage: Hashable {
  
  let id:       String
  let userId:   String
  let itemId:   String
  let name:     String
  let text:     String
  let date:     Date
  
  init(id: String, userId: String, itemId: String, name: String, text: String, date: Date) {
    self.id     = id
    self.userId = userId
    self.itemId = itemId
    self.name   = name
    self.text   = text
    self.date   = date
  }
  
  init(dictionary: [String: Any]) {
    self.id     = dictionary["id"] as? String ?? ""
    self.userId = dictionary["userId"] as? String ?? ""
    self.itemId = dictionary["itemId"] as? String ?? ""
    self.name   = dictionary["name"] as? String ?? ""
    self.text   = dictionary["text"] as? String ?? ""
    self.date   = (dictionary["timestamp"] as? Timestamp ?? Timestamp(date: Date())).dateValue()
  }
  
  func hash(into hasher: inout Hasher) {
      hasher.combine(id)
  }
}

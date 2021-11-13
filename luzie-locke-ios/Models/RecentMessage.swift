//
//  Inbox.swift
//  luzie-locke-ios
//
//  Created by Harry on 10.11.21.
//

import Firebase

struct RecentMessage: Hashable {
  
  let id:               String
  let name:             String
  let profileImageUrl:  String
  let text:             String
  let date:             Date
  
  init(dictionary: [String: Any]) {
    self.id               = dictionary["id"] as? String ?? ""
    self.name             = dictionary["name"] as? String ?? ""
    self.profileImageUrl  = dictionary["profileImageUrl"] as? String ?? ""
    self.text             = dictionary["text"] as? String ?? ""
    self.date             = (dictionary["timestamp"] as? Timestamp ?? Timestamp(date: Date())).dateValue()
  }
  
  func hash(into hasher: inout Hasher) {
      hasher.combine(id)
  }
}

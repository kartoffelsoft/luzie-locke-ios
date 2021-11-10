//
//  Message.swift
//  luzie-locke-ios
//
//  Created by Harry on 08.11.21.
//

import Firebase

struct ChatMessage: Hashable{
  let text:               String
  let isFromCurrentUser:  Bool
  let fromId:             String
  let toId:               String
  let timestamp:          Timestamp
}

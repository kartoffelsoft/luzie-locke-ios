//
//  ItemDisplay.swift
//  luzie-locke-ios
//
//  Created by Harry on 07.01.22.
//

import Foundation

struct ItemDisplay: Equatable {
  
  let userName:     String
  let userImageUrl: String
  let location:     String
  let title:        String
  let description:  String
  let imageUrls:    [String?]
  
  static func == (lhs: ItemDisplay, rhs: ItemDisplay) -> Bool {
    return
      lhs.userName == rhs.userName &&
      lhs.userImageUrl == rhs.userImageUrl &&
      lhs.location == rhs.location &&
      lhs.title == rhs.title &&
      lhs.description == rhs.description &&
      lhs.imageUrls == rhs.imageUrls
  }
}

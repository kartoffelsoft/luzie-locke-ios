//
//  Item.swift
//  luzie-locke-ios
//
//  Created by Harry on 25.10.21.
//

import Foundation

struct Item: Codable, Hashable {
  let id: String?
  let user: UserProfile?
  let title: String?
  let price: String?
  let description: String?
  let imageUrls: [String?]?
  let counts: Counts?
  let state: String?
  let createdAt: Date?
  
  init(id: String? = nil, user: UserProfile? = nil, title: String? = nil,
       price: String? = nil, description: String? = nil, imageUrls: [String?]? = nil,
       counts: Counts? = nil, state: String? = nil, createdAt: Date? = nil) {
    self.id           = id
    self.user         = user
    self.title        = title
    self.price        = price
    self.description  = description
    self.imageUrls    = imageUrls
    self.counts       = counts
    self.state        = state
    self.createdAt    = createdAt
  }
}

struct Counts: Codable, Hashable {
  let chat: Int?
  let favorite: Int?
  let view: Int?
}

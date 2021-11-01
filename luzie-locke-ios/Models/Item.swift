//
//  Item.swift
//  luzie-locke-ios
//
//  Created by Harry on 25.10.21.
//

import Foundation

struct Item: Codable, Hashable {
  let _id: String?
  let user: User?
  let title: String?
  let price: String?
  let description: String?
  let images: [String?]?
  let counts: Counts?
  let state: String?
  let createdAt: Date?
  
  init(_id: String? = nil, user: User? = nil, title: String? = nil,
       price: String? = nil, description: String? = nil, images: [String?]? = nil,
       counts: Counts? = nil, state: String? = nil, createdAt: Date? = nil) {
    self._id          = _id
    self.user         = user
    self.title        = title
    self.price        = price
    self.description  = description
    self.images       = images
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

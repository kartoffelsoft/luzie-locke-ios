//
//  Item.swift
//  luzie-locke-ios
//
//  Created by Harry on 25.10.21.
//

import Foundation

struct Item: Codable, Hashable {
  let _id: String
  let owner: Profile?
  let title: String
  let price: String
  let description: String
  let images: [String]
  let counts: Counts?
  let state: String
  let createdAt: Date
}

struct Counts: Codable, Hashable {
  let chat: Int
  let favorite: Int
  let view: Int
}

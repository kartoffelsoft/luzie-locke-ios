//
//  ItemListElementDTO.swift
//  luzie-locke-ios
//
//  Created by Harry on 13.12.21.
//

import Foundation

struct ItemListElementDTO: Decodable, Hashable {
  let id:           String?
  let user:         User?
  let title:        String?
  let price:        String?
  let description:  String?
  let imageUrls:    [String?]?
  let counts:       Counts?
  let state:        String?
  let createdAt:    TimeInterval?
  let modifiedAt:   TimeInterval?
  
  struct User: Decodable, Hashable {
    let city: String
  }
  
  struct Counts: Codable, Hashable {
    let chat: Int?
    let favorite: Int?
    let view: Int?
  }
}

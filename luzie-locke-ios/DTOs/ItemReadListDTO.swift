//
//  ItemReadDTO.swift
//  luzie-locke-ios
//
//  Created by Harry on 01.11.21.
//

import Foundation

struct ItemReadListRequestDTO: APIRequest {
  
  typealias Response = ItemReadListResponseDTO
  
  var resourceName: String {
    return "/api/items"
  }
  
  let cursor: Double
  let limit: Int
  
  func toDictionary() -> [String: Any] {
    return [ "cursor":  cursor,
             "limit":   limit   ]
  }
}

struct ItemReadListSearchRequestDTO: APIRequest {
  
  typealias Response = ItemReadListResponseDTO
  
  var resourceName: String {
    return "/api/items/search"
  }
  
  let q: String
  let cursor: Double
  let limit: Int
  
  func toDictionary() -> [String: Any] {
    return [ "q":       q,
             "cursor":  cursor,
             "limit":   limit   ]
  }
}

struct ItemReadListUserListingsRequestDTO: APIRequest {
  
  typealias Response = ItemReadListResponseDTO
  
  var resourceName: String {
    return "/api/items/user"
  }
  
  let cursor: Double
  let limit: Int
  
  func toDictionary() -> [String: Any] {
    return [ "cursor":  cursor,
             "limit":   limit   ]
  }
}

struct ItemListDTO: Decodable, Hashable {
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

struct ItemReadListResponseDTO: Decodable {
  let list: [ItemListDTO]
  let nextCursor: Double
}

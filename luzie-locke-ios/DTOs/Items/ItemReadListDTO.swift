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
    return "/api/users/" + id + "/open-items"
  }
  
  let id: String
  let cursor: Double
  let limit: Int
  
  func toDictionary() -> [String: Any] {
    return [ "cursor":  cursor,
             "limit":   limit   ]
  }
}

struct ItemReadListUserListingsClosedRequestDTO: APIRequest {
  
  typealias Response = ItemReadListResponseDTO
  
  var resourceName: String {
    return "/api/users/" + id + "/sold-items"
  }
  
  let id: String
  let cursor: Double
  let limit: Int
  
  func toDictionary() -> [String: Any] {
    return [ "cursor":  cursor,
             "limit":   limit   ]
  }
}

struct ItemReadListUserPurchasesRequestDTO: APIRequest {
  
  typealias Response = ItemReadListResponseDTO
  
  var resourceName: String {
    return "/api/users/" + id + "/bought-items"
  }
  
  let id:     String
  let cursor: Double
  let limit:  Int
  
  func toDictionary() -> [String: Any] {
    return [ "cursor":  cursor,
             "limit":   limit   ]
  }
}

struct ItemReadListResponseDTO: Decodable {
  let list: [ItemListElementDTO]
  let nextCursor: Double
}

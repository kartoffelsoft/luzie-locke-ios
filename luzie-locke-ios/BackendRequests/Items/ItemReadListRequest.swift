//
//  ItemReadDTO.swift
//  luzie-locke-ios
//
//  Created by Harry on 01.11.21.
//

import Foundation

struct ItemReadListRequest: APIRequest {
  
  typealias Response = ItemReadListResponse
  
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

struct ItemReadListSearchRequest: APIRequest {
  
  typealias Response = ItemReadListResponse
  
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

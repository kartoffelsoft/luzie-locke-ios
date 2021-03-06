//
//  ItemReadDTO.swift
//  luzie-locke-ios
//
//  Created by Harry on 01.11.21.
//

import Foundation

struct ItemListReadRequest: APIRequest {
  
  typealias Response = ItemListReadResponse
  
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
  
  typealias Response = ItemListReadResponse
  
  var resourceName: String {
    return "/api/items/search"
  }
  
  let q: SearchString
  let cursor: Double
  let limit: Int
  
  func toDictionary() -> [String: Any] {
    
    
    return [ "q":       q.toString(),
             "cursor":  cursor,
             "limit":   limit   ]
  }
}

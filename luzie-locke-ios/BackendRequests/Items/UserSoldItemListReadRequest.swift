//
//  UserSoldItemListReadRequest.swift
//  luzie-locke-ios
//
//  Created by Harry on 13.12.21.
//

import Foundation

struct UserSoldItemListReadRequest: APIRequest {
  
  typealias Response = ItemListReadResponse
  
  var resourceName: String {
    return "/api/users/" + userId + "/sold-items"
  }
  
  let userId: String
  let cursor: Double
  let limit:  Int
  
  func toDictionary() -> [String: Any] {
    return [ "cursor":  cursor,
             "limit":   limit   ]
  }
}

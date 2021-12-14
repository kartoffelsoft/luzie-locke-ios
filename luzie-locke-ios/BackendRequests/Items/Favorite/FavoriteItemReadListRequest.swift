//
//  FavoriteItemReadListDTO.swift
//  luzie-locke-ios
//
//  Created by Harry on 13.12.21.
//

import Foundation

struct FavoriteItemListReadRequest: APIRequest {
  
  typealias Response = FavoriteItemListReadResponse
  
  var resourceName: String {
    return "/api/users/" + userId + "/favorite-items"
  }
  
  let userId: String
  let cursor: Double
  let limit: Int
  
  func toDictionary() -> [String: Any] {
    return [ "cursor":  cursor,
             "limit":   limit   ]
  }
}

struct FavoriteItemListReadResponse: Decodable {
  let list: [ItemListElementDTO]
  let nextCursor: Double
}

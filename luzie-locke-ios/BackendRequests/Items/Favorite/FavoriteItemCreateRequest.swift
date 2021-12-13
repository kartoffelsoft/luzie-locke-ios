//
//  FavoriteItemCreateDTO.swift
//  luzie-locke-ios
//
//  Created by Harry on 03.12.21.
//

import Foundation

struct FavoriteItemCreateRequest: APIRequest {
  
  typealias Response = VoidResponse
  
  var resourceName: String {
    return "/api/users/" + userId + "/favorite-items"
  }
  
  let userId: String
  let itemId: String
  
  func toDictionary() -> [String: Any] {
    return [ "itemId": itemId ]
  }
}

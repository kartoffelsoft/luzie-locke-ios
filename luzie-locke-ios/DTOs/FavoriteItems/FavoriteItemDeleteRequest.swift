//
//  FavoriteItemDeleteDTO.swift
//  luzie-locke-ios
//
//  Created by Harry on 03.12.21.
//

import Foundation

struct FavoriteItemDeleteRequest: APIRequest {
  
  typealias Response = VoidResponseDTO
  
  var resourceName: String {
    return "/api/users/" + userId + "/favorite-items/" + itemId
  }
  
  let userId: String
  let itemId: String
  
  func toDictionary() -> [String: Any] {
    return [ : ]
  }
}

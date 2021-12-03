//
//  FavoriteItemCreateDTO.swift
//  luzie-locke-ios
//
//  Created by Harry on 03.12.21.
//

import Foundation

struct FavoriteItemCreateRequestDTO: APIRequest {
  
  typealias Response = VoidResponseDTO
  
  var resourceName: String {
    return "/api/items/user/favorite"
  }
  
  let itemId: String
  
  func toDictionary() -> [String: Any] {
    return [ "itemId": itemId ]
  }
}

//
//  FavoriteItemReadExist.swift
//  luzie-locke-ios
//
//  Created by Harry on 03.12.21.
//

import Foundation

struct FavoriteItemReadExistRequestDTO: APIRequest {
  
  typealias Response = FavoriteItemReadExistResponseDTO
  
  var resourceName: String {
    return "/api/items/user/favorite/" + itemId
  }

  let itemId: String
  
  func toDictionary() -> [String: Any] {
    return [ : ]
  }
}

struct FavoriteItemReadExistResponseDTO: Decodable {
  let exist: Bool
}

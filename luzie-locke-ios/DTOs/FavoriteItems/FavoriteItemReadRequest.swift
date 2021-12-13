//
//  FavoriteItemReadDTO.swift
//  luzie-locke-ios
//
//  Created by Harry on 03.12.21.
//

import Foundation

struct FavoriteItemReadRequest: APIRequest {
  
  typealias Response = FavoriteItemReadResponse
  
  var resourceName: String {
    return "/api/users/" + userId + "/favorite-items/" + itemId
  }

  let userId: String
  let itemId: String
  
  func toDictionary() -> [String: Any] {
    return [ : ]
  }
}

struct FavoriteItemDTO: Decodable, Hashable {
  let id: String
  let user: String
  let item: String
  let createdAt: TimeInterval
}

struct FavoriteItemReadResponse: Decodable {
  let favorite: FavoriteItemDTO?
}

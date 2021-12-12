//
//  ItemStateReadDTO.swift
//  luzie-locke-ios
//
//  Created by Harry on 11.12.21.
//

import Foundation

struct ItemTradeStateReadRequestDTO: APIRequest {
  
  typealias Response = ItemTradeStateReadResponseDTO
  
  var resourceName: String {
    return "/api/items/" + id + "/trade-state"
  }
  
  let id: String
  
  func toDictionary() -> [String: Any] {
    return [ : ]
  }
}

struct ItemTradeStateReadResponseDTO: Decodable {
  let state: String
  let sellerId: String
  let buyerId: String
}

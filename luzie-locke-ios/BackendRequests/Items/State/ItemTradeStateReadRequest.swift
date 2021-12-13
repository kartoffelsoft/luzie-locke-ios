//
//  ItemStateReadDTO.swift
//  luzie-locke-ios
//
//  Created by Harry on 11.12.21.
//

import Foundation

struct ItemTradeStateReadRequest: APIRequest {
  
  typealias Response = ItemTradeStateReadResponse
  
  var resourceName: String {
    return "/api/items/" + id + "/trade-state"
  }
  
  let id: String
  
  func toDictionary() -> [String: Any] {
    return [ : ]
  }
}

struct ItemTradeStateReadResponse: Decodable {
  let state: String
  let sellerId: String
  let buyerId: String
}

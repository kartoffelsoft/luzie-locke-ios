//
//  ItemTradeStateUpdateDTO.swift
//  luzie-locke-ios
//
//  Created by Harry on 11.12.21.
//

import Foundation

struct ItemTradeStateUpdateRequestDTO: APIRequest {
  
  typealias Response = ItemTradeStateUpdateResponseDTO
  
  var resourceName: String {
    return "/api/items/" + id + "/trade-state"
  }
  
  let id:           String
  let state:        String
  let buyerId:      String
  
  func toDictionary() -> [String: Any] {
    return [ "state":   state,
             "buyerId": buyerId ]
  }
}

struct ItemTradeStateUpdateResponseDTO: Decodable {
  let state: String
  let sellerId: String
  let buyerId: String
}

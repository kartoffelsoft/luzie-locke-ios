//
//  ItemTradeStateUpdateDTO.swift
//  luzie-locke-ios
//
//  Created by Harry on 11.12.21.
//

import Foundation

struct ItemStateUpdateRequest: APIRequest {
  
  typealias Response = VoidResponse
  
  var resourceName: String {
    return "/api/items/" + id
  }
  
  let id:           String
  let state:        String
  let buyerId:      String
  
  func toDictionary() -> [String: Any] {
    return [ "state":   state,
             "buyerId": buyerId ]
  }
}

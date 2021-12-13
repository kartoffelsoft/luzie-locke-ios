//
//  ItemReadDTO.swift
//  luzie-locke-ios
//
//  Created by Harry on 01.11.21.
//

import Foundation

struct ItemReadRequest: APIRequest {
  
  typealias Response = ItemReadResponse
  
  var resourceName: String {
    return "/api/items/" + id
  }
  
  let id: String
  
  func toDictionary() -> [String: Any] {
    return [ : ]
  }
}

struct ItemReadResponse: Decodable {
  let item: ItemDTO
}

//
//  ItemStateReadDTO.swift
//  luzie-locke-ios
//
//  Created by Harry on 11.12.21.
//

import Foundation

struct ItemStateReadRequestDTO: APIRequest {
  
  typealias Response = ItemStateReadResponseDTO
  
  var resourceName: String {
    return "/api/items/" + id + "/state"
  }
  
  let id: String
  
  func toDictionary() -> [String: Any] {
    return [ : ]
  }
}

struct ItemStateReadResponseDTO: Decodable {
  let state: String
}

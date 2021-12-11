//
//  ItemImageUrlReadDTO.swift
//  luzie-locke-ios
//
//  Created by Harry on 10.12.21.
//

import Foundation

struct ItemImageUrlReadRequestDTO: APIRequest {
  
  typealias Response = ItemImageUrlReadResponseDTO
  
  var resourceName: String {
    return "/api/items/" + id + "/image"
  }
  
  let id: String
  
  func toDictionary() -> [String: Any] {
    return [ : ]
  }
}

struct ItemImageUrlReadResponseDTO: Decodable {
  let url: String
}

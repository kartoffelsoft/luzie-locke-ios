//
//  ItemImageUrlReadDTO.swift
//  luzie-locke-ios
//
//  Created by Harry on 10.12.21.
//

import Foundation

struct ItemImageUrlReadRequest: APIRequest {
  
  typealias Response = ItemImageUrlReadResponse
  
  var resourceName: String {
    return "/api/items/" + id + "/image"
  }
  
  let id: String
  
  func toDictionary() -> [String: Any] {
    return [ : ]
  }
}

struct ItemImageUrlReadResponse: Decodable {
  let url: String
}

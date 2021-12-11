//
//  ItemDelete.swift
//  luzie-locke-ios
//
//  Created by Harry on 28.11.21.
//

import Foundation

struct ItemDeleteRequestDTO: APIRequest {
  
  typealias Response = VoidResponseDTO
  
  var resourceName: String {
    return "/api/items/" + id
  }
  
  let id: String
  
  func toDictionary() -> [String: Any] {
    return [ : ]
  }
}

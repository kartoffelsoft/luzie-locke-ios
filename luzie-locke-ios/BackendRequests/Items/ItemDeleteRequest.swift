//
//  ItemDelete.swift
//  luzie-locke-ios
//
//  Created by Harry on 28.11.21.
//

import Foundation

struct ItemDeleteRequest: APIRequest {
  
  typealias Response = VoidResponse
  
  var resourceName: String {
    return "/api/items/" + id
  }
  
  let id: String
  
  func toDictionary() -> [String: Any] {
    return [ : ]
  }
}

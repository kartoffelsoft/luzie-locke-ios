//
//  ItemCreateRequest.swift
//  luzie-locke-ios
//
//  Created by Harry on 30.10.21.
//

import Foundation

struct ItemCreateRequestDTO: APIRequest {
  
  typealias Response = VoidResponseDTO
  
  var resourceName: String {
    return "/api/items/"
  }
  
  let title:        String
  let price:        String
  let description:  String
  let images:       [String?]
  
  init(domain: Item) {
    self.title        = domain.title!
    self.price        = domain.price!
    self.description  = domain.description!
    self.images       = domain.images!
  }
  
  func toDictionary() -> [String: Any] {
    return [ "title":       title,
             "price":       price,
             "description": description,
             "images":      images       ]
  }
}

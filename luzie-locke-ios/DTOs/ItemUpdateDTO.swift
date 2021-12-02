//
//  ItemUpdateDTO.swift
//  luzie-locke-ios
//
//  Created by Harry on 02.12.21.
//

import Foundation

struct ItemUpdateRequestDTO: APIRequest {
  
  typealias Response = VoidResponseDTO
  
  var resourceName: String {
    return "/api/items/" + id
  }
  
  let id:           String
  let title:        String
  let price:        String
  let description:  String
  let imageUrls:    [String?]
  
  init(domain: Item) {
    self.id           = domain.id!
    self.title        = domain.title!
    self.price        = domain.price!
    self.description  = domain.description!
    self.imageUrls    = domain.imageUrls!
  }
  
  func toDictionary() -> [String: Any] {
    return [ "title":       title,
             "price":       price,
             "description": description,
             "imageUrls":   imageUrls      ]
  }
}

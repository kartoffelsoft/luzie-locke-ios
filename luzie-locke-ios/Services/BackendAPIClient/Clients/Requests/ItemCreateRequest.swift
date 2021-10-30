//
//  ItemCreateRequest.swift
//  luzie-locke-ios
//
//  Created by Harry on 30.10.21.
//

import Foundation

struct ItemCreateRequest: APIRequest {
  
  typealias Response = NoDataResponse
  
  var resourceName: String {
    return "/api/items/"
  }
  
  let title:        String
  let price:        String
  let description:  String
  let images:       [String?]
  
  init(title: String, price: String, description: String, images: [String?]) {
    self.title        = title
    self.price        = price
    self.description  = description
    self.images       = images
  }
  
  func toDictionary() -> [String: Any] {
    return [ "title":       title,
             "price":       price,
             "description": description,
             "images":      images       ]
  }
}

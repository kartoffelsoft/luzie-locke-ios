//
//  ItemReadDTO.swift
//  luzie-locke-ios
//
//  Created by Harry on 01.11.21.
//

import Foundation

struct ItemReadRequestDTO: APIRequest {
  
  typealias Response = ItemReadResponseDTO
  
  var resourceName: String {
    return "/api/items/" + id
  }
  
  let id: String
  
  func toDictionary() -> [String: Any] {
    return [ : ]
  }
}

struct ItemDTO: Decodable, Hashable {
  let _id:          String?
  let user:         UserProfile?
  let title:        String?
  let price:        String?
  let description:  String?
  let images:       [String?]?
  let counts:       Counts?
  let state:        String?
  let createdAt:    Date?
  
  struct UserProfile: Decodable, Hashable {
    let _id: String?
    let name: String?
    let email: String?
    let reputation: Int?
    let pictureURI: String?
    let location: Location?
    
    struct Location: Decodable, Hashable {
      let name: String?
      let geoJSON: GeoJSON?
    }

    struct GeoJSON: Codable, Hashable {
      let type: String?
      let coordinates: [Double]?
    }
  }
  
  struct Counts: Decodable, Hashable {
    let chat: Int?
    let favorite: Int?
    let view: Int?
  }
}

struct ItemReadResponseDTO: Decodable {
  
  let item: ItemDTO
}

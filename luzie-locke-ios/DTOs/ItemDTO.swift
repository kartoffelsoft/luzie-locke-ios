//
//  ItemDTO.swift
//  luzie-locke-ios
//
//  Created by Harry on 13.12.21.
//

import Foundation

struct ItemDTO: Decodable, Hashable {
  let id:           String?
  let user:         UserProfile?
  let title:        String?
  let price:        String?
  let description:  String?
  let imageUrls:    [String?]?
  let counts:       Counts?
  let state:        String?
  let createdAt:    TimeInterval?
  let modifiedAt:   TimeInterval?
  
  struct UserProfile: Decodable, Hashable {
    let id: String?
    let name: String?
    let email: String?
    let reputation: Int?
    let imageUrl: String?
    let city: String?
    let location: Location?

    struct Location: Codable, Hashable {
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

//
//  UserProfile.swift
//  luzie-locke-ios
//
//  Created by Harry on 11.11.21.
//

import Foundation

struct UserProfile: Codable, Hashable {
  
  let id: String?
  let name: String?
  let email: String?
  let reputation: Int?
  let imageUrl: String?
  let localLevel: Int?
  let city: String?
  let location: Location?

  init(id: String? = nil, name: String? = nil, email: String? = nil, reputation: Int? = nil,
       imageUrl: String? = nil, localLevel: Int? = nil, city: String? = nil, location: Location? = nil) {
    self.id         = id
    self.name       = name
    self.email      = email
    self.reputation = reputation
    self.imageUrl   = imageUrl
    self.localLevel = localLevel
    self.city       = city
    self.location   = location
  }
  
  struct Location: Codable, Hashable {
    let type: String?
    let coordinates: [Double]?
  }
}

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
  let locationName: String?
  let locationCoordinates: Coordinates?

  init(id: String? = nil, name: String? = nil, email: String? = nil, reputation: Int? = nil,
       imageUrl: String? = nil, locationName: String? = nil, locationCoordinates: Coordinates? = nil) {
    self.id                   = id
    self.name                 = name
    self.email                = email
    self.reputation           = reputation
    self.imageUrl             = imageUrl
    self.locationName         = locationName
    self.locationCoordinates  = locationCoordinates
  }
  
  struct Coordinates: Codable, Hashable {
    let type: String?
    let coordinates: [Double]?
  }
}

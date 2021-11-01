//
//  User.swift
//  luzie-locke-ios
//
//  Created by Harry on 11.10.21.
//

import Foundation

struct User: Codable, Hashable {
  let _id: String?
  let name: String?
  let email: String?
  let reputation: Int?
  let pictureURI: String?
  let location: Location?
  
  init(_id: String? = nil, name: String? = nil, email: String? = nil,
       reputation: Int? = nil, pictureURI: String? = nil, location: Location? = nil) {
    self._id        = _id
    self.name       = name
    self.email      = email
    self.reputation = reputation
    self.pictureURI = pictureURI
    self.location   = location
  }
}

struct Location: Codable, Hashable {
  let name: String?
  let geoJSON: GeoJSON?
  
  init(name: String? = nil, geoJSON: GeoJSON? = nil) {
    self.name = name
    self.geoJSON = geoJSON
  }
}

struct GeoJSON: Codable, Hashable {
  let type: String
  let coordinates: [Double]
}

//
//  User.swift
//  luzie-locke-ios
//
//  Created by Harry on 11.10.21.
//

import Foundation

struct User: Codable, Hashable {
  let uid: String
  let name: String
  let email: String
  let reputation: Int
  let pictureURI: String
  let location: Location
}

struct Location: Codable, Hashable {
  let name: String
  let geoJSON: GeoJSON
}

struct GeoJSON: Codable, Hashable {
  let type: String
  let coordinates: [Double]
}

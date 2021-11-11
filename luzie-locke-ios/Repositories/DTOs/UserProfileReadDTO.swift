//
//  RemoteUserReadDTO.swift
//  luzie-locke-ios
//
//  Created by Harry on 11.11.21.
//

import Foundation

struct UserProfileReadRequestDTO: APIRequest {
  
  typealias Response = UserProfileReadResponseDTO
  
  var resourceName: String {
    return "/api/users/" + id
  }
  
  let id: String
  
  func toDictionary() -> [String: Any] {
    return [ : ]
  }
}

struct UserProfileReadResponseDTO: Decodable {
  
  let profile: UserProfileDTO
}

struct UserProfileDTO: Decodable, Hashable {
  
  let _id: String?
  let name: String?
  let email: String?
  let reputation: Int?
  let pictureURI: String?
  let location: Location?

  struct Location: Codable, Hashable {
    let name: String?
    let geoJSON: GeoJSON?
    
    init(name: String? = nil, geoJSON: GeoJSON? = nil) {
      self.name = name
      self.geoJSON = geoJSON
    }
  }

  struct GeoJSON: Codable, Hashable {
    let type: String?
    let coordinates: [Double]?
  }
}


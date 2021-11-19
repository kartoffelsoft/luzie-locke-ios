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
  
  let user: UserProfileDTO
}

struct UserProfileDTO: Decodable, Hashable {
  
  let id: String?
  let name: String?
  let email: String?
  let reputation: Int?
  let imageUrl: String?
  let locationName: String?
  let locationCoordinates: Coordinates?

  struct Coordinates: Codable, Hashable {
    let type: String?
    let coordinates: [Double]?
  }
}


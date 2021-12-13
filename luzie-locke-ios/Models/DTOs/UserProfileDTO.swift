//
//  RemoteUserReadDTO.swift
//  luzie-locke-ios
//
//  Created by Harry on 11.11.21.
//

import Foundation

struct UserProfileDTO: Decodable, Hashable {
  
  let id: String?
  let name: String?
  let email: String?
  let reputation: Int?
  let imageUrl: String?
  let localLevel: Int?
  let city: String?
  let location: Location?

  struct Location: Codable, Hashable {
    let type: String?
    let coordinates: [Double]?
  }
}

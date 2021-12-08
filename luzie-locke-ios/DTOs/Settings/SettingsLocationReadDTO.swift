//
//  SettingsLocationReadRequestDTO.swift
//  luzie-locke-ios
//
//  Created by Harry on 07.12.21.
//

import Foundation

struct SettingsLocationReadRequestDTO: APIRequest {
  
  typealias Response = SettingsLocationReadResponseDTO
  
  var resourceName: String {
    return "/api/settings/location"
  }
  
  func toDictionary() -> [String: Any] {
    return [ : ]
  }
}

struct SettingsLocationReadResponseDTO: Decodable {
  
  let city: String
  let lat: Double
  let lng: Double
}

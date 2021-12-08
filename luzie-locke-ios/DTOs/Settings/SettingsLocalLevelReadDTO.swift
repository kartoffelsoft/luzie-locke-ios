//
//  SettingsLocalLevelReadDTO.swift
//  luzie-locke-ios
//
//  Created by Harry on 07.12.21.
//

import Foundation

struct SettingsLocalLevelReadRequestDTO: APIRequest {
  
  typealias Response = SettingsLocalLevelReadResponseDTO
  
  var resourceName: String {
    return "/api/settings/local-level"
  }
  
  func toDictionary() -> [String: Any] {
    return [ : ]
  }
}

struct SettingsLocalLevelReadResponseDTO: Decodable {
  
  let localLevel: Int
}

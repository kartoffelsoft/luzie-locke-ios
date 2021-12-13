//
//  SettingsLocalLevelReadDTO.swift
//  luzie-locke-ios
//
//  Created by Harry on 07.12.21.
//

import Foundation

struct SettingsLocalLevelReadRequest: APIRequest {
  
  typealias Response = SettingsLocalLevelReadResponse
  
  var resourceName: String {
    return "/api/settings/local-level"
  }
  
  func toDictionary() -> [String: Any] {
    return [ : ]
  }
}

struct SettingsLocalLevelReadResponse: Decodable {
  
  let localLevel: Int
}

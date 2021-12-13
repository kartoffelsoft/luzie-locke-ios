//
//  SettingsLocalLevelUpdateDTO.swift
//  luzie-locke-ios
//
//  Created by Harry on 07.12.21.
//

import Foundation

struct SettingsLocalLevelUpdateRequest: APIRequest {
  
  typealias Response = VoidResponse
  
  var resourceName: String {
    return "/api/settings/local-level"
  }
  
  let localLevel: Int

  func toDictionary() -> [String: Any] {
    return [ "localLevel":  localLevel ]
  }
}

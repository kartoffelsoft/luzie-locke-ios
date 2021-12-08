//
//  SettingsLocalLevelUpdateDTO.swift
//  luzie-locke-ios
//
//  Created by Harry on 07.12.21.
//

import Foundation

struct SettingsLocalLevelUpdateRequestDTO: APIRequest {
  
  typealias Response = VoidResponseDTO
  
  var resourceName: String {
    return "/api/users/self/settings/local-level"
  }
  
  let localLevel: Int

  func toDictionary() -> [String: Any] {
    return [ "localLevel":  localLevel ]
  }
}

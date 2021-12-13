//
//  UserProfileRequest.swift
//  luzie-locke-ios
//
//  Created by Harry on 13.12.21.
//

import Foundation

struct UserProfileReadRequest: APIRequest {
  
  typealias Response = UserProfileReadResponse
  
  var resourceName: String {
    return "/api/users/" + id
  }
  
  let id: String
  
  func toDictionary() -> [String: Any] {
    return [ : ]
  }
}

struct UserProfileReadResponse: Decodable {
  
  let user: UserProfileDTO
}

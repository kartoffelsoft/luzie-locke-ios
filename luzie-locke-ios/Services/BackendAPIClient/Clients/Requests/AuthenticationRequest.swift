//
//  PostAuthentication.swift
//  luzie-locke-ios
//
//  Created by Harry on 18.10.21.
//

import Foundation

struct AuthenticationRequest: APIRequest {
  
  typealias Response = AuthenticationResponse
  
  var resourceName: String {
    return "/api/auth/google"
  }
  
  let id:     String
  let token:  String
  
  init(id: String, token: String) {
    self.id     = id
    self.token  = token
  }
  
  func toDictionary() -> [String: Any] {
    return [ "id":     id,
             "token":  token  ]
  }
}

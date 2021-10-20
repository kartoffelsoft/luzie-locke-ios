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
    return "/api/users/login/google"
  }
  
  let uid:    String
  let token:  String
  
  init(uid: String, token: String) {
    self.uid    = uid
    self.token  = token
  }
  
  func toDictionary() -> [String: Any] {
    return [ "uid":    uid,
             "token":  token  ]
  }
}

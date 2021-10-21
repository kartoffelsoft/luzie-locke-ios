//
//  BackendAuthService.swift
//  luzie-locke-ios
//
//  Created by Harry on 20.10.21.
//

import Foundation

protocol BackendAuthable {
  
  func authenticate(uid: String, token: String, completion: @escaping (Result<Profile, LLError>?) -> Void)
  
  func isAuthenticated() -> Bool
}

class BackendAuthService: BackendAuthable {
  
  let backendClient:        BackendAPIClient
  let profileStorage:       AnyStorage<Profile>
  let accessTokenStorage:   AnyStorage<String>
  let refreshTokenStorage:  AnyStorage<String>

  init(backendClient:         BackendAPIClient,
       profileStorage:        AnyStorage<Profile>,
       accessTokenStorage:    AnyStorage<String>,
       refreshTokenStorage:   AnyStorage<String>) {
    self.backendClient        = backendClient
    self.profileStorage       = profileStorage
    self.accessTokenStorage   = accessTokenStorage
    self.refreshTokenStorage  = refreshTokenStorage
  }
  
  func authenticate(uid: String, token: String, completion: @escaping (Result<Profile, LLError>?) -> Void) {
    backendClient.user.authenticate(uid: uid, token: token) { [weak self] result in
      guard let self = self else { return }
      switch result {
      case .success(let data):
        self.profileStorage.set(data.profile)
        self.accessTokenStorage.set(data.accessToken)
        self.refreshTokenStorage.set(data.refreshToken)
        self.backendClient.configureTokenHeader(token: data.accessToken)
        completion(.success(data.profile))
        
      case .failure(let error):
        completion(.failure(error))
      case .none:
        ()
      }
    }
  }
  
  func isAuthenticated() -> Bool {
    let token = accessTokenStorage.get()
    if let token = token {
      let decoded = JWTDecode.decode(token: token)
      if Date(timeIntervalSince1970: decoded["exp"] as! TimeInterval) > Date() {
        return true
      }
    }

    return false
  }
}

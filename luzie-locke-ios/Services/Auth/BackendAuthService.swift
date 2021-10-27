//
//  BackendAuthService.swift
//  luzie-locke-ios
//
//  Created by Harry on 20.10.21.
//

import Foundation

protocol BackendAuth {
  
  func authenticate(uid: String, token: String, completion: @escaping (Result<User, LLError>?) -> Void)
  func isAuthenticated() -> Bool
  func logout()
}

class BackendAuthService: BackendAuth {
  
  let backendApiClient:     BackendAPIClient
  let profileStorage:       AnyStorage<User>
  let accessTokenStorage:   AnyStorage<String>
  let refreshTokenStorage:  AnyStorage<String>

  init(backendApiClient:      BackendAPIClient,
       profileStorage:        AnyStorage<User>,
       accessTokenStorage:    AnyStorage<String>,
       refreshTokenStorage:   AnyStorage<String>) {
    self.backendApiClient     = backendApiClient
    self.profileStorage       = profileStorage
    self.accessTokenStorage   = accessTokenStorage
    self.refreshTokenStorage  = refreshTokenStorage
    
    if let token = accessTokenStorage.get() {
      self.backendApiClient.configureTokenHeader(token: token)
    }
  }
  
  func authenticate(uid: String, token: String, completion: @escaping (Result<User, LLError>?) -> Void) {
    backendApiClient.userApi.authenticate(uid: uid, token: token) { [weak self] result in
      guard let self = self else { return }
      switch result {
      case .success(let data):
        self.profileStorage.set(data.profile)
        self.accessTokenStorage.set(data.accessToken)
        self.refreshTokenStorage.set(data.refreshToken)
        self.backendApiClient.configureTokenHeader(token: data.accessToken)
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
  
  func logout() {
    self.profileStorage.clear()
    self.accessTokenStorage.clear()
    self.refreshTokenStorage.clear()
    self.backendApiClient.configureTokenHeader(token: "")
  }
}

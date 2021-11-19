//
//  BackendAuthService.swift
//  luzie-locke-ios
//
//  Created by Harry on 20.10.21.
//

import Foundation

protocol BackendAuth {
  
  func authenticate(uid: String, token: String, completion: @escaping (Result<UserProfile, LLError>?) -> Void)
  func isAuthenticated() -> Bool
  func logout()
}

class BackendAuthService: BackendAuth {
  
  let backendApiClient:       BackendAPIClient
  let localProfileRepository: LocalProfileRepositoryProtocol
  let accessTokenStorage:     AnyStorage<String>
  let refreshTokenStorage:    AnyStorage<String>

  init(backendApiClient:        BackendAPIClient,
       localProfileRepository:  LocalProfileRepositoryProtocol,
       accessTokenStorage:      AnyStorage<String>,
       refreshTokenStorage:     AnyStorage<String>) {
    self.backendApiClient       = backendApiClient
    self.localProfileRepository = localProfileRepository
    self.accessTokenStorage     = accessTokenStorage
    self.refreshTokenStorage    = refreshTokenStorage
    
    if let token = accessTokenStorage.get() {
      self.backendApiClient.configureTokenHeader(token: token)
    }
  }
  
  func authenticate(uid: String, token: String, completion: @escaping (Result<UserProfile, LLError>?) -> Void) {
    print("@1")
    backendApiClient.userApi.authenticate(uid: uid, token: token) { [weak self] result in
      print("@2")
      guard let self = self else { return }
      switch result {
      case .success(let data):
        print("@3")
        self.localProfileRepository.update(data.profile)
        self.accessTokenStorage.set(data.accessToken)
        self.refreshTokenStorage.set(data.refreshToken)
        self.backendApiClient.configureTokenHeader(token: data.accessToken)
        completion(.success(data.profile))
        
      case .failure(let error):
        print("@4")
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
    self.localProfileRepository.delete()
    self.accessTokenStorage.clear()
    self.refreshTokenStorage.clear()
    self.backendApiClient.configureTokenHeader(token: "")
  }
}

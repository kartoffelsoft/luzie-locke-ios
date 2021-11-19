//
//  UserAPIClient.swift
//  luzie-locke-ios
//
//  Created by Harry on 19.10.21.
//

import Foundation

protocol UserAPI {
  func authenticate(uid: String, token: String, completion: @escaping (Result<(profile: UserProfile, accessToken: String, refreshToken: String), LLError>?) -> Void)
  
  func updateLocation(name: String, lat: Double, lng: Double, completion: @escaping (Result<UserProfile, LLError>?) -> Void)
}

class UserAPIClient: UserAPI {
  
  private let client: BackendClient
  
  init(client: BackendClient) {
    self.client = client
  }
  
  func authenticate(uid: String, token: String, completion: @escaping (Result<(profile: UserProfile, accessToken: String, refreshToken: String), LLError>?) -> Void) {
    client.POST(AuthenticationRequest(id: uid, token: token)) { result in
      switch result {
      case .success(let response):
        if let profile = response?.user,
           let accessToken = response?.accessToken,
           let refreshToken = response?.refreshToken {
          completion(.success((profile: profile, accessToken: accessToken, refreshToken: refreshToken)))
        }
      case .failure(let error):
        print(error)
        completion(.failure(.unableToComplete))
      }
    }
  }
  
  func updateLocation(name: String, lat: Double, lng: Double, completion: @escaping (Result<UserProfile, LLError>?) -> Void) {
    client.PATCH(UpdateLocationRequest(name: name, lat: lat, lng: lng)) { result in
      switch result {
      case .success(let response):
        if let profile = response?.profile {
          completion(.success(profile))
        } else {
          completion(.failure(.unexpectedServerResponse))
        }
        
      case .failure(let error):
        print("error:", error)
        completion(.failure(.unableToComplete))
      }
    }
  }
}

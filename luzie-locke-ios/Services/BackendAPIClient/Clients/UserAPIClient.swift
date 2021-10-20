//
//  UserAPIClient.swift
//  luzie-locke-ios
//
//  Created by Harry on 19.10.21.
//

import Foundation

class UserAPIClient {
  
  let client: KHTTPAPIClient
  
  init(client: KHTTPAPIClient) {
    self.client = client
  }
  
  func authenticate(uid: String, token: String, completion: @escaping (Result<(profile: Profile, accessToken: String, refreshToken: String), LLError>?) -> Void) {
    client.POST(AuthenticationRequest(uid: uid, token: token)) { result in
      switch result {
      case .success(let response):
        if let profile = response?.profile,
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
  
  func updateLocation(name: String, lat: Double, lng: Double, completion: @escaping (Result<Profile, LLError>?) -> Void) {
    client.PATCH(UpdateLocationRequest(name: name, lat: lat, lng: lng)) { result in
      switch result {
      case .success(let response):
        if let profile = response?.profile {
          completion(.success(profile))
        } else {
          completion(.failure(.unexpectedServerResponse))
        }
        
      case .failure(let error):
        completion(.failure(.unableToComplete))
      }
    }
  }
}

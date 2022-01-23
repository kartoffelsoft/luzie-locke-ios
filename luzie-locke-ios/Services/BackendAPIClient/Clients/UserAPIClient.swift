//
//  UserAPIClient.swift
//  luzie-locke-ios
//
//  Created by Harry on 19.10.21.
//

import Foundation
import Combine

protocol UserAPI {
  func authenticate(uid: String, token: String, completion: @escaping (Result<(profile: UserProfile, accessToken: String, refreshToken: String), LLError>?) -> Void)
  
  func updateLocation(city: String, lat: Double, lng: Double, completion: @escaping (Result<UserProfile, LLError>?) -> Void)
}

class UserAPIClient: UserAPI {
  
  private let client: BackendClient
  private var cancellables = Set<AnyCancellable>()
  
  init(client: BackendClient) {
    self.client = client
  }
  
  func authenticate(uid: String, token: String, completion: @escaping (Result<(profile: UserProfile, accessToken: String, refreshToken: String), LLError>?) -> Void) {
    client.POST(AuthenticationRequest(id: uid, token: token))
      .tryMap { response -> AuthenticationRequest.Response in
        guard let response = response else { throw LLError.invalidData }
        return response
      }
      .sink { result in
        switch result {
        case .failure(let error):
          print("[Error:\(#file):\(#line)] \(error.localizedDescription)")
          completion(.failure(.unableToComplete))
        case .finished: ()
        }
      } receiveValue: { response in
        completion(.success((profile: response.user, accessToken: response.accessToken, refreshToken: response.refreshToken)))
      }
      .store(in: &self.cancellables)
  }
  
  func updateLocation(city: String, lat: Double, lng: Double, completion: @escaping (Result<UserProfile, LLError>?) -> Void) {
    client.PATCH(UpdateLocationRequest(city: city, lat: lat, lng: lng))
      .tryMap { response -> UpdateLocationRequest.Response in
        guard let response = response else { throw LLError.invalidData }
        return response
      }
      .sink { result in
        switch result {
        case .failure(let error):
          print("[Error:\(#file):\(#line)] \(error.localizedDescription)")
          completion(.failure(.unableToComplete))
        case .finished: ()
        }
      } receiveValue: { response in
        completion(.success(response.user))
      }
      .store(in: &cancellables)
  }
}

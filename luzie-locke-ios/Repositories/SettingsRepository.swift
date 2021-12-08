//
//  UserSettingsRepository.swift
//  luzie-locke-ios
//
//  Created by Harry on 07.12.21.
//

import Foundation

protocol SettingsRepositoryProtocol {

  func readLocalLevel(completion: @escaping (Result<Int, LLError>) -> Void)
  func updateLocalLevel(localLevel: Int, completion: @escaping (Result<Void, LLError>) -> Void)
  
  func readLocation(completion: @escaping (Result<(String, Double, Double), LLError>) -> Void)
}

class SettingsRepository: SettingsRepositoryProtocol {
  
  private let backendClient: BackendClient
  
  init(backendClient: BackendClient) {
    self.backendClient = backendClient
  }
  
  func readLocalLevel(completion: @escaping (Result<Int, LLError>) -> Void) {
    backendClient.GET(SettingsLocalLevelReadRequestDTO()) { result in
      switch result {
      case .success(let response):
        if let response = response {
          completion(.success(response.localLevel))
        } else {
          completion(.failure(.unableToComplete))
        }
        
      case .failure(let err):
        print("[Error:\(#file):\(#line)] \(err)")
        completion(.failure(.unableToComplete))
      }
    }
  }
  
  func updateLocalLevel(localLevel: Int, completion: @escaping (Result<Void, LLError>) -> Void) {
    backendClient.PATCH(SettingsLocalLevelUpdateRequestDTO(localLevel: localLevel)) { result in
      switch result {
      case .success:
        completion(.success(()))
      case .failure(let error):
        print("[Error:\(#file):\(#line)] \(error)")
        completion(.failure(.unableToComplete))
      }
    }
  }
  
  func readLocation(completion: @escaping (Result<(String, Double, Double), LLError>) -> Void) {
    backendClient.GET(SettingsLocationReadRequestDTO()) { result in
      switch result {
      case .success(let response):
        if let response = response {
          completion(.success((response.city, response.lat, response.lng)))
        } else {
          completion(.failure(.unableToComplete))
        }
        
      case .failure(let err):
        print("[Error:\(#file):\(#line)] \(err)")
        completion(.failure(.unableToComplete))
      }
    }
  }
  
  func updateLocation(city: String, lat: Double, lng: Double, completion: @escaping (Result<Void, LLError>) -> Void) {
    backendClient.PATCH(SettingsLocationUpdateRequestDTO(city: city, lat: lat, lng: lng)) { result in
      switch result {
      case .success:
        completion(.success(()))
      case .failure(let error):
        print("[Error:\(#file):\(#line)] \(error)")
        completion(.failure(.unableToComplete))
      }
    }
  }
}

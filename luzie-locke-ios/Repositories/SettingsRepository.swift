//
//  UserSettingsRepository.swift
//  luzie-locke-ios
//
//  Created by Harry on 07.12.21.
//

import Foundation
import Combine

protocol SettingsRepositoryProtocol {

  func readLocalLevel(completion: @escaping (Result<Int, LLError>) -> Void)
  func updateLocalLevel(localLevel: Int, completion: @escaping (Result<Void, LLError>) -> Void)
  
  func readLocation(completion: @escaping (Result<(String, Double, Double), LLError>) -> Void)
  func updateLocation(city: String, lat: Double, lng: Double, completion: @escaping (Result<Void, LLError>) -> Void)
}

class SettingsRepository: SettingsRepositoryProtocol {
  
  private let backendClient: BackendClient
  private var cancellables = Set<AnyCancellable>()
  
  init(backendClient: BackendClient) {
    self.backendClient = backendClient
  }
  
  func readLocalLevel(completion: @escaping (Result<Int, LLError>) -> Void) {
    backendClient.GET(SettingsLocalLevelReadRequest())
      .tryMap { response -> SettingsLocalLevelReadRequest.Response in
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
        completion(.success(response.localLevel))
      }
      .store(in: &cancellables)
  }
  
  func updateLocalLevel(localLevel: Int, completion: @escaping (Result<Void, LLError>) -> Void) {
    backendClient.PATCH(SettingsLocalLevelUpdateRequest(localLevel: localLevel))
      .sink { result in
        switch result {
        case .failure(let error):
          print("[Error:\(#file):\(#line)] \(error.localizedDescription)")
          completion(.failure(.unableToComplete))
        case .finished: ()
        }
      } receiveValue: { _ in
        completion(.success(()))
      }
      .store(in: &cancellables)
  }
  
  func readLocation(completion: @escaping (Result<(String, Double, Double), LLError>) -> Void) {
    backendClient.GET(SettingsLocationReadRequest())
      .tryMap { response -> SettingsLocationReadRequest.Response in
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
        completion(.success((response.city, response.lat, response.lng)))
      }
      .store(in: &cancellables)
  }
  
  func updateLocation(city: String, lat: Double, lng: Double, completion: @escaping (Result<Void, LLError>) -> Void) {
    backendClient.PATCH(SettingsLocationUpdateRequest(city: city, lat: lat, lng: lng))
      .sink { result in
        switch result {
        case .failure(let error):
          print("[Error:\(#file):\(#line)] \(error.localizedDescription)")
          completion(.failure(.unableToComplete))
        case .finished: ()
        }
      } receiveValue: { _ in
        completion(.success(()))
      }
      .store(in: &cancellables)
  }
}

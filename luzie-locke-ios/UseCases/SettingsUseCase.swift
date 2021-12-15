//
//  SettingsUseCase.swift
//  luzie-locke-ios
//
//  Created by Harry on 15.12.21.
//

import Foundation

protocol SettingsUseCaseProtocol {
  
  func getLocalLevel(completion: @escaping (Result<Int, LLError>) -> Void)
  func setLocalLevel(localLevel: Int, completion: @escaping (Result<Void, LLError>) -> Void)
  
  func getLocation(completion: @escaping (Result<(String, Double, Double), LLError>) -> Void)
  func setLocation(city: String, lat: Double, lng: Double, completion: @escaping (Result<Void, LLError>) -> Void)
}

class SettingsUseCase: SettingsUseCaseProtocol {
  
  private let settingsRepository: SettingsRepositoryProtocol
  private let myProfileUseCase:   MyProfileUseCaseProtocol
  
  init(settingsRepository:  SettingsRepositoryProtocol,
       myProfileUseCase:    MyProfileUseCaseProtocol) {
    self.settingsRepository = settingsRepository
    self.myProfileUseCase   = myProfileUseCase
  }
  
  func getLocalLevel(completion: @escaping (Result<Int, LLError>) -> Void) {
    settingsRepository.readLocalLevel(completion: completion)
  }

  func setLocalLevel(localLevel: Int, completion: @escaping (Result<Void, LLError>) -> Void) {
    settingsRepository.updateLocalLevel(localLevel: localLevel) { [weak self] result in
      switch(result) {
      case .success:
        self?.myProfileUseCase.setLocalLevel(localLevel: localLevel)
        completion(.success(()))
      case .failure(let error):
        print("[Error:\(#file):\(#line)] \(error)")
        completion(.failure(.unableToComplete))
      }
    }
  }
  
  func getLocation(completion: @escaping (Result<(String, Double, Double), LLError>) -> Void) {
    settingsRepository.readLocation(completion: completion)
  }
  
  func setLocation(city: String, lat: Double, lng: Double, completion: @escaping (Result<Void, LLError>) -> Void) {
    settingsRepository.updateLocation(city: city, lat: lat, lng: lng) { [weak self] result in
      switch result {
      case .success:
        self?.myProfileUseCase.setLocation(city: city, lat: lat, lng: lng)
        completion(.success(()))
      case .failure(let error):
        print("[Error:\(#file):\(#line)] \(error)")
        completion(.failure(.unableToComplete))
      }
    }
  }
}

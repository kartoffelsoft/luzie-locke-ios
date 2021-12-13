//
//  RemoteUserRepository.swift
//  luzie-locke-ios
//
//  Created by Harry on 11.11.21.
//

import Foundation

protocol UserProfileRepositoryProtocol {

  func readLocal(completion: @escaping (Result<UserProfile, LLError>) -> Void)
  func readRemote(_ id: String, completion: @escaping (Result<UserProfile, LLError>) -> Void)
}

class UserProfileRepository: UserProfileRepositoryProtocol {
  
  private let backendClient: BackendClient
  private let localProfileRepository: LocalProfileRepository
  
  init(backendClient: BackendClient, localProfileRepository: LocalProfileRepository) {
    self.backendClient          = backendClient
    self.localProfileRepository = localProfileRepository
  }
  
  func readLocal(completion: @escaping (Result<UserProfile, LLError>) -> Void) {
    if let profile = localProfileRepository.read() {
      completion(.success(profile))
    } else {
      completion(.failure(.unableToComplete))
    }
  }
  
  func readRemote(_ id: String, completion: @escaping (Result<UserProfile, LLError>) -> Void) {
    backendClient.GET(UserProfileReadRequest(id: id)) { result in
      switch result {
      case .success(let response):
        if let response = response {
          let user = UserTranslator.translateUserProfileDTOToUser(dto: response.user)
          completion(.success(user))
        } else {
          completion(.failure(.unableToComplete))
        }
        
      case .failure(let err):
        print("[Error:\(#file):\(#line)] \(err)")
        completion(.failure(.unableToComplete))
      }
    }
  }
}

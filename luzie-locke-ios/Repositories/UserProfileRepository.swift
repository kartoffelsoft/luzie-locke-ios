//
//  RemoteUserRepository.swift
//  luzie-locke-ios
//
//  Created by Harry on 11.11.21.
//

import Foundation

protocol UserProfileRepositoryProtocol {

  func read(_ id: String, completion: @escaping (Result<UserProfile, LLError>) -> Void)
}

class UserProfileRepository: UserProfileRepositoryProtocol {
  
  private let backendClient: BackendClient
  
  init(backendClient: BackendClient) {
    self.backendClient = backendClient
  }
  
  func read(_ id: String, completion: @escaping (Result<UserProfile, LLError>) -> Void) {
    backendClient.GET(UserProfileReadRequestDTO(id: id)) { result in
      switch result {
      case .success(let response):
        if let response = response {
          let user = UserTranslator.translateUserProfileDTOToUser(dto: response.profile)
          completion(.success(user))
        } else {
          completion(.failure(.unableToComplete))
        }
        
      case .failure(let error):
        print("[Error:\(#file):\(#line)] \(error)")
        completion(.failure(.unableToComplete))
      }
    }
  }
}

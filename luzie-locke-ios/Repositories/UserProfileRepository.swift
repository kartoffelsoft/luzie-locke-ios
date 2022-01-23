//
//  RemoteUserRepository.swift
//  luzie-locke-ios
//
//  Created by Harry on 11.11.21.
//

import Foundation
import Combine

protocol UserProfileRepositoryProtocol {

  func readLocal(completion: @escaping (Result<UserProfile, LLError>) -> Void)
  func readRemote(_ id: String, completion: @escaping (Result<UserProfile, LLError>) -> Void)
}

class UserProfileRepository: UserProfileRepositoryProtocol {
  
  private let backendClient: BackendClient
  private let localProfileRepository: LocalProfileRepository
  private var cancellables = Set<AnyCancellable>()
  
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
    backendClient.GET(UserProfileReadRequest(id: id))
      .tryMap { response -> UserProfileReadRequest.Response in
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
        completion(.success(UserTranslator.translateUserProfileDTOToUser(dto: response.user)))
      }
      .store(in: &cancellables)
  }
}

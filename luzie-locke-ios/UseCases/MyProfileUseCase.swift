//
//  MyProfileUseCase.swift
//  luzie-locke-ios
//
//  Created by Harry on 12.12.21.
//

import Foundation

protocol MyProfileUseCaseProtocol {
  
  func getId() -> String?
}

class MyProfileUseCase: MyProfileUseCaseProtocol {
  
  private let localProfileRepository: LocalProfileRepositoryProtocol
  
  init(localProfileRepository: LocalProfileRepositoryProtocol) {
    self.localProfileRepository = localProfileRepository
  }
  
  func getId() -> String? {
    return localProfileRepository.read()?.id
  }
}

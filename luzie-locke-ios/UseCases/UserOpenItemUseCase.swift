//
//  UserOpenItemUseCase.swift
//  luzie-locke-ios
//
//  Created by Harry on 13.12.21.
//

import Foundation

protocol UserOpenItemUseCaseProtocol {
  
  func getItemList(cursor: TimeInterval, completion: @escaping (Result<([Item], TimeInterval), LLError>) -> Void)
}

class UserOpenItemUseCase: UserOpenItemUseCaseProtocol {
  
  private let localProfileRepository: LocalProfileRepositoryProtocol
  private let userOpenItemRepository: UserOpenItemRepositoryProtocol
  
  init(localProfileRepository:  LocalProfileRepositoryProtocol,
       userOpenItemRepository:  UserOpenItemRepositoryProtocol) {
    self.localProfileRepository = localProfileRepository
    self.userOpenItemRepository = userOpenItemRepository
  }
  
  func getItemList(cursor: TimeInterval, completion: @escaping (Result<([Item], TimeInterval), LLError>) -> Void) {
    guard let userId = localProfileRepository.read()?.id else { return }
    userOpenItemRepository.readItemList(userId: userId, cursor: cursor, completion: completion)
  }
}

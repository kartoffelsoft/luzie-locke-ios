//
//  UserBoughtItemUseCase.swift
//  luzie-locke-ios
//
//  Created by Harry on 13.12.21.
//

import Foundation

protocol UserBoughtItemUseCaseProtocol {
  
  func getItemList(cursor: TimeInterval, completion: @escaping (Result<([Item], TimeInterval), LLError>) -> Void)
}

class UserBoughtItemUseCase: UserBoughtItemUseCaseProtocol {
  
  private let localProfileRepository: LocalProfileRepositoryProtocol
  private let userBoughtItemRepository: UserBoughtItemRepositoryProtocol
  
  init(localProfileRepository: LocalProfileRepositoryProtocol,
       userBoughtItemRepository: UserBoughtItemRepositoryProtocol) {
    self.localProfileRepository = localProfileRepository
    self.userBoughtItemRepository = userBoughtItemRepository
  }
  
  func getItemList(cursor: TimeInterval, completion: @escaping (Result<([Item], TimeInterval), LLError>) -> Void) {
    guard let userId = localProfileRepository.read()?.id else { return }
    userBoughtItemRepository.readItemList(userId: userId, cursor: cursor, completion: completion)
  }
}

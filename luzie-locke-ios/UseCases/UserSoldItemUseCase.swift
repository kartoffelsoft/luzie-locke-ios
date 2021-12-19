//
//  UserSoldItemUseCase.swift
//  luzie-locke-ios
//
//  Created by Harry on 13.12.21.
//

import Foundation

protocol UserSoldItemUseCaseProtocol {
  
  func getItemList(cursor: TimeInterval, completion: @escaping (Result<([ItemListElement], TimeInterval), LLError>) -> Void)
}

class UserSoldItemUseCase: UserSoldItemUseCaseProtocol {
  
  private let localProfileRepository: LocalProfileRepositoryProtocol
  private let userSoldItemRepository: UserSoldItemRepositoryProtocol
  
  init(localProfileRepository:  LocalProfileRepositoryProtocol,
       userSoldItemRepository:  UserSoldItemRepositoryProtocol) {
    self.localProfileRepository = localProfileRepository
    self.userSoldItemRepository = userSoldItemRepository
  }
  
  func getItemList(cursor: TimeInterval, completion: @escaping (Result<([ItemListElement], TimeInterval), LLError>) -> Void) {
    guard let userId = localProfileRepository.read()?.id else { return }
    userSoldItemRepository.readItemList(userId: userId, cursor: cursor, completion: completion)
  }
}

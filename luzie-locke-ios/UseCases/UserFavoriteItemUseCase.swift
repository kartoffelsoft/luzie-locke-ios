//
//  FavoriteItemUseCase.swift
//  luzie-locke-ios
//
//  Created by Harry on 13.12.21.
//

import Foundation

protocol UserFavoriteItemUseCaseProtocol {
  
  func getMyList(cursor: TimeInterval, completion: @escaping (Result<([ItemListElement], TimeInterval), LLError>) -> Void)
  func add(itemId: String, completion: @escaping (Result<Void, LLError>) -> Void)
  func remove(itemId: String, completion: @escaping (Result<Void, LLError>) -> Void)
  func isAdded(itemId: String, completion: @escaping (Result<Bool, LLError>) -> Void)
}

class UserFavoriteItemUseCase: UserFavoriteItemUseCaseProtocol {
  
  private let localProfileRepository: LocalProfileRepositoryProtocol
  private let favoriteItemRepository: FavoriteItemRepositoryProtocol
  
  init(localProfileRepository: LocalProfileRepositoryProtocol,
       favoriteItemRepository: FavoriteItemRepositoryProtocol) {
    self.localProfileRepository = localProfileRepository
    self.favoriteItemRepository = favoriteItemRepository
  }
  
  func getMyList(cursor: TimeInterval, completion: @escaping (Result<([ItemListElement], TimeInterval), LLError>) -> Void) {
    guard let userId = localProfileRepository.read()?.id else { return }
    favoriteItemRepository.readItemList(userId: userId, cursor: cursor, completion: completion)
  }
  
  func add(itemId: String, completion: @escaping (Result<Void, LLError>) -> Void) {
    guard let userId = localProfileRepository.read()?.id else { return }
    favoriteItemRepository.create(userId: userId, itemId: itemId, completion: completion)
  }
  
  func remove(itemId: String, completion: @escaping (Result<Void, LLError>) -> Void) {
    guard let userId = localProfileRepository.read()?.id else { return }
    favoriteItemRepository.delete(userId: userId, itemId: itemId, completion: completion)
  }
  
  func isAdded(itemId: String, completion: @escaping (Result<Bool, LLError>) -> Void) {
    guard let userId = localProfileRepository.read()?.id else { return }
    favoriteItemRepository.read(userId: userId, itemId: itemId) { result in
      switch result {
      case .success(let favorite):
        completion(.success(favorite == nil ? false : true))
      case .failure(let error):
        print("[Error:\(#file):\(#line)] \(error)")
        completion(.failure(.unableToComplete))
      }
    }
  }
}

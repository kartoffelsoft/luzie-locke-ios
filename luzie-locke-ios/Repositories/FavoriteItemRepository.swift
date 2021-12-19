//
//  FavoriteItemRepository.swift
//  luzie-locke-ios
//
//  Created by Harry on 03.12.21.
//

import UIKit

protocol FavoriteItemRepositoryProtocol {

  func create(userId: String, itemId: String, completion: @escaping (Result<Void, LLError>) -> Void)
  func read(userId: String, itemId: String, completion: @escaping (Result<FavoriteItem?, LLError>) -> Void)
  func readItemList(userId: String, cursor: TimeInterval, completion: @escaping (Result<([ItemListElement], TimeInterval), LLError>) -> Void)
  func delete(userId: String, itemId: String, completion: @escaping (Result<Void, LLError>) -> Void)
}

class FavoriteItemRepository: FavoriteItemRepositoryProtocol {
  
  private let backendClient: BackendClient
  
  init(backendClient: BackendClient) {
    self.backendClient = backendClient
  }
  
  func create(userId: String, itemId: String, completion: @escaping (Result<Void, LLError>) -> Void) {
    self.backendClient.POST(FavoriteItemCreateRequest(userId: userId, itemId: itemId)) { result in
      switch result {
      case .success:
        completion(.success(()))
      case .failure(let error):
        print("[Error:\(#file):\(#line)] \(error)")
        completion(.failure(.unableToComplete))
      }
    }
  }
  
  func read(userId: String, itemId: String, completion: @escaping (Result<FavoriteItem?, LLError>) -> Void) {
    self.backendClient.GET(FavoriteItemReadRequest(userId: userId, itemId: itemId)) { result in
      switch result {
      case .success(let response):
        completion(.success(FavoriteItem(dto: response?.favorite)))
      case .failure(let error):
        print("[Error:\(#file):\(#line)] \(error)")
        completion(.failure(.unableToComplete))
      }
    }
  }
  
  func readItemList(userId: String, cursor: TimeInterval, completion: @escaping (Result<([ItemListElement], TimeInterval), LLError>) -> Void) {
    backendClient.GET(FavoriteItemListReadRequest(userId: userId, cursor: cursor, limit: 8)) { result in
      switch result {
      case .success(let response):
        if let response = response {
          completion(.success((
            ItemTranslator.translateItemDTOListToItemList(dtoList: response.list),
            response.nextCursor)))
        } else {
          completion(.failure(.unableToComplete))
        }

      case .failure(let error):
        print("[Error:\(#file):\(#line)] \(error)")
        completion(.failure(.unableToComplete))
      }
    }
  }
  
  func delete(userId: String, itemId: String, completion: @escaping (Result<Void, LLError>) -> Void) {
    self.backendClient.DELETE(FavoriteItemDeleteRequest(userId: userId, itemId: itemId)) { result in
      switch result {
      case .success:
        completion(.success(()))
      case .failure(let error):
        print("[Error:\(#file):\(#line)] \(error)")
        completion(.failure(.unableToComplete))
      }
    }
  }
}

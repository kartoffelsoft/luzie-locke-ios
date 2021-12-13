//
//  UserSoldItemRepository.swift
//  luzie-locke-ios
//
//  Created by Harry on 13.12.21.
//

import Foundation

protocol UserSoldItemRepositoryProtocol {

  func readItemList(userId: String, cursor: TimeInterval, completion: @escaping (Result<([Item], TimeInterval), LLError>) -> Void)
}

class UserSoldItemRepository: UserSoldItemRepositoryProtocol {
  
  private let backendClient: BackendClient
  
  init(backendClient: BackendClient) {
    self.backendClient = backendClient
  }
  
  func readItemList(userId: String, cursor: TimeInterval, completion: @escaping (Result<([Item], TimeInterval), LLError>) -> Void) {
    backendClient.GET(UserSoldItemListReadRequest(userId: userId, cursor: cursor, limit: 8)) { result in
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
}

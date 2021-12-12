//
//  ItemStateUseCases.swift
//  luzie-locke-ios
//
//  Created by Harry on 11.12.21.
//

import Foundation

protocol ItemTradeStateUseCaseProtocol {
  
  func getState(itemId: String, completion: @escaping (Result<(String, String, String), LLError>) -> Void)
  func setSold(itemId: String, buyerId: String, completion: @escaping (Result<(String, String, String), LLError>) -> Void)
  func setOpen(itemId: String, completion: @escaping (Result<(String, String, String), LLError>) -> Void)
}

class ItemTradeStateUseCase: ItemTradeStateUseCaseProtocol {
  
  private let itemRepository: ItemRepositoryProtocol
  
  init(itemRepository: ItemRepositoryProtocol) {
    self.itemRepository = itemRepository
  }
  
  func getState(itemId: String, completion: @escaping (Result<(String, String, String), LLError>) -> Void) {
    itemRepository.readTradeState(itemId) { result in
      switch result {
      case .success((let state, let sellerId, let buyerId)):
        completion(.success((state, sellerId, buyerId)))
        
      case .failure(let error):
        print("[Error:\(#file):\(#line)] \(error)")
        completion(.failure(.unableToComplete))
      }
    }
  }
  
  func setSold(itemId: String, buyerId: String, completion: @escaping (Result<(String, String, String), LLError>) -> Void) {
    itemRepository.updateTradeState(itemId, state: "sold", buyerId: buyerId) { result in
      switch result {
      case .success((let state, let sellerId, let buyerId)):
        completion(.success((state, sellerId, buyerId)))
        
      case .failure(let error):
        print("[Error:\(#file):\(#line)] \(error)")
        completion(.failure(.unableToComplete))
      }
    }
  }
  
  func setOpen(itemId: String, completion: @escaping (Result<(String, String, String), LLError>) -> Void) {
    itemRepository.updateTradeState(itemId, state: "open", buyerId: "") { result in
      switch result {
      case .success((let state, let sellerId, let buyerId)):
        completion(.success((state, sellerId, buyerId)))
        
      case .failure(let error):
        print("[Error:\(#file):\(#line)] \(error)")
        completion(.failure(.unableToComplete))
      }
    }
  }
}

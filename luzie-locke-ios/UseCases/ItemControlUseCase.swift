//
//  ItemStateUseCases.swift
//  luzie-locke-ios
//
//  Created by Harry on 11.12.21.
//

import Foundation

protocol ItemControlUseCaseProtocol {
  
  func getItem(itemId: String, completion: @escaping (Result<Item, LLError>) -> Void)
  func setSold(itemId: String, buyerId: String, completion: @escaping (Result<Void, LLError>) -> Void)
  func setOpen(itemId: String, completion: @escaping (Result<Void, LLError>) -> Void)
}

class ItemControlUseCase: ItemControlUseCaseProtocol {
  
  private let itemRepository: ItemRepositoryProtocol
  
  init(itemRepository: ItemRepositoryProtocol) {
    self.itemRepository = itemRepository
  }
  
  func getItem(itemId: String, completion: @escaping (Result<Item, LLError>) -> Void) {
    itemRepository.read(itemId, completion: completion)
  }
  
  func setSold(itemId: String, buyerId: String, completion: @escaping (Result<Void, LLError>) -> Void) {
    itemRepository.updateState(itemId, state: "sold", buyerId: buyerId) { result in
      switch result {
      case .success:
        completion(.success(()))
        
      case .failure(let error):
        print("[Error:\(#file):\(#line)] \(error)")
        completion(.failure(.unableToComplete))
      }
    }
  }
  
  func setOpen(itemId: String, completion: @escaping (Result<Void, LLError>) -> Void) {
    itemRepository.updateState(itemId, state: "open", buyerId: "") { result in
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

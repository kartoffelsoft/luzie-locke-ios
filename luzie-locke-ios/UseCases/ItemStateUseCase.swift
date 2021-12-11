//
//  ItemStateUseCases.swift
//  luzie-locke-ios
//
//  Created by Harry on 11.12.21.
//

import Foundation

protocol ItemStateUseCaseProtocol {
  
  func getState(itemId: String, completion: @escaping (Result<String, LLError>) -> Void)
  func setSold(itemId: String, completion: @escaping (Result<Void, LLError>) -> Void)
  func setOpen(itemId: String, completion: @escaping (Result<Void, LLError>) -> Void)
}

class ItemStateUseCase: ItemStateUseCaseProtocol {
  
  private let itemRepository: ItemRepositoryProtocol
  
  init(itemRepository: ItemRepositoryProtocol) {
    self.itemRepository = itemRepository
  }
  
  func getState(itemId: String, completion: @escaping (Result<String, LLError>) -> Void) {
    itemRepository.readState(itemId) { result in
      switch result {
      case .success(let state):
        completion(.success(state))
        
      case .failure(let error):
        print("[Error:\(#file):\(#line)] \(error)")
        completion(.failure(.unableToComplete))
      }
    }
  }
  
  func setSold(itemId: String, completion: @escaping (Result<Void, LLError>) -> Void) {
    
  }
  
  func setOpen(itemId: String, completion: @escaping (Result<Void, LLError>) -> Void) {
    
  }
}

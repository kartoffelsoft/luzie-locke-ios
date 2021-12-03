//
//  FavoriteItemRepository.swift
//  luzie-locke-ios
//
//  Created by Harry on 03.12.21.
//

import UIKit

protocol FavoriteItemRepositoryProtocol {

  func create(_ itemId: String, completion: @escaping (Result<Void, LLError>) -> Void)
  func read(_ itemId: String, completion: @escaping (Result<Bool, LLError>) -> Void)
  func delete(_ itemId: String, completion: @escaping (Result<Void, LLError>) -> Void)
}

class FavoriteItemRepository: FavoriteItemRepositoryProtocol {
  
  private let backendClient: BackendClient
  
  init(backendClient: BackendClient) {
    self.backendClient = backendClient
  }
  
  func create(_ itemId: String, completion: @escaping (Result<Void, LLError>) -> Void) {
    self.backendClient.POST(FavoriteItemCreateRequestDTO(itemId: itemId)) { result in
      switch result {
      case .success:
        completion(.success(()))
      case .failure(let error):
        print("[Error:\(#file):\(#line)] \(error)")
        completion(.failure(.unableToComplete))
      }
    }
  }
  
  func read(_ itemId: String, completion: @escaping (Result<Bool, LLError>) -> Void) {
    self.backendClient.GET(FavoriteItemReadExistRequestDTO(itemId: itemId)) { result in
      switch result {
      case .success(let response):
        if let response = response {
          completion(.success(response.exist))
        }
      case .failure(let error):
        print("[Error:\(#file):\(#line)] \(error)")
        completion(.failure(.unableToComplete))
      }
    }
  }
  
  func delete(_ itemId: String, completion: @escaping (Result<Void, LLError>) -> Void) {
    self.backendClient.DELETE(FavoriteItemDeleteRequestDTO(itemId: itemId)) { result in
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

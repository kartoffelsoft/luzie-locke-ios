//
//  Repository.swift
//  luzie-locke-ios
//
//  Created by Harry on 31.10.21.
//

import Foundation

protocol ItemRepositoryProtocol {

  func create(_ item: Item, completion: @escaping (Result<Void, LLError>) -> Void)
  func read(_ id: String, completion: @escaping (Result<Item, LLError>) -> Void)
  func readListLocal(cursor: TimeInterval, completion: @escaping (Result<([Item], TimeInterval), LLError>) -> Void)
  func readListSearch(keyword: String, cursor: TimeInterval, completion: @escaping (Result<([Item], TimeInterval), LLError>) -> Void)
  func readListUserListings(cursor: TimeInterval, completion: @escaping (Result<([Item], TimeInterval), LLError>) -> Void)
  func readListUserListingsClosed(cursor: TimeInterval, completion: @escaping (Result<([Item], TimeInterval), LLError>) -> Void)
  func readListUserPurchases(cursor: TimeInterval, completion: @escaping (Result<([Item], TimeInterval), LLError>) -> Void)
//  func update(_ item: T, completion: (Result<Void, LLError>) -> Void)
//  func delete(_ item: T, completion: (Result<Void, LLError>) -> Void)
}

class ItemRepository: ItemRepositoryProtocol {
  
  private let backendClient: BackendClient
  
  init(backendClient: BackendClient) {
    self.backendClient = backendClient
  }
  
  func create(_ item: Item, completion: @escaping (Result<Void, LLError>) -> Void) {
    backendClient.POST(ItemCreateRequestDTO(domain: item)) { result in
      DispatchQueue.main.async {
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
  
  func read(_ id: String, completion: @escaping (Result<Item, LLError>) -> Void) {
    backendClient.GET(ItemReadRequestDTO(id: id)) { result in
      DispatchQueue.main.async {
        switch result {
        case .success(let response):
          if let response = response {
            let item = ItemTranslator.translateItemDTOToItem(dto: response.item)
            completion(.success(item))
          } else {
            completion(.failure(.unableToComplete))
          }

        case .failure(let err):
          print("[Error:\(#file):\(#line)] \(err)")
          completion(.failure(.unableToComplete))
        }
      }
    }
  }
  
  func readListLocal(cursor: TimeInterval, completion: @escaping (Result<([Item], TimeInterval), LLError>) -> Void) {
    backendClient.GET(ItemReadListRequestDTO(cursor: cursor, limit: 8)) { result in
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
  
  func readListSearch(keyword: String, cursor: TimeInterval, completion: @escaping (Result<([Item], TimeInterval), LLError>) -> Void) {
    backendClient.GET(ItemReadListSearchRequestDTO(q: keyword, cursor: cursor, limit: 8)) { result in
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
  
  func readListUserListings(cursor: TimeInterval, completion: @escaping (Result<([Item], TimeInterval), LLError>) -> Void) {
    backendClient.GET(ItemReadListUserListingsRequestDTO(cursor: cursor, limit: 8)) { result in
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
  
  func readListUserListingsClosed(cursor: TimeInterval, completion: @escaping (Result<([Item], TimeInterval), LLError>) -> Void) {
    backendClient.GET(ItemReadListUserListingsClosedRequestDTO(cursor: cursor, limit: 8)) { result in
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
  
  func readListUserPurchases(cursor: TimeInterval, completion: @escaping (Result<([Item], TimeInterval), LLError>) -> Void) {
    backendClient.GET(ItemReadListUserPurchasesRequestDTO(cursor: cursor, limit: 8)) { result in
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

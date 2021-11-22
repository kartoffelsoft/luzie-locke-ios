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
  func readListAll(cursor: TimeInterval, completion: @escaping (Result<([Item], TimeInterval), LLError>) -> Void)
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
  
  func readListAll(cursor: TimeInterval, completion: @escaping (Result<([Item], TimeInterval), LLError>) -> Void) {
    backendClient.GET(ItemListReadAllRequestDTO(cursor: cursor, limit: 8)) { result in
      switch result {
      case .success(let response):
        if let response = response {
          let items = response.list.reduce([Item](), { output, dto in
            let item = Item(id: dto.id,
                            user: UserProfile(city: dto.user?.city),
                            title: dto.title,
                            price: dto.price,
                            description: dto.description,
                            imageUrls: dto.imageUrls,
                            counts: Counts(chat: dto.counts?.chat,
                                           favorite: dto.counts?.favorite,
                                           view: dto.counts?.view),
                            state: dto.state,
                            createdAt: Date(timeIntervalSince1970: dto.createdAt ?? 0),
                            modifiedAt: Date(timeIntervalSince1970: dto.modifiedAt ?? 0))
            return output + [item]
          })
          completion(.success((items, response.nextCursor)))
        } else {
          completion(.failure(.unableToComplete))
        }

      case .failure(let error):
        print("[Error:\(#file):\(#line)] \(error)")
        completion(.failure(.unableToComplete))
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
}

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
  func readListAll(completion: @escaping (Result<[Item], LLError>) -> Void)
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
  
  func readListAll(completion: @escaping (Result<[Item], LLError>) -> Void) {
    backendClient.GET(ItemListReadAllRequestDTO(page: 1, limit: 8)) { result in
      DispatchQueue.main.async {
        switch result {
        case .success(let response):
          if let response = response {
            let items = response.items.reduce([Item](), { output, dto in
              let item = Item(_id: dto._id,
                              user: UserProfile(location: UserProfile.Location(name: dto.user?.location.name)),
                              title: dto.title,
                              price: dto.price,
                              description: dto.description,
                              images: dto.images,
                              counts: Counts(chat: dto.counts?.chat,
                                             favorite: dto.counts?.favorite,
                                             view: dto.counts?.view),
                              state: dto.state,
                              createdAt: dto.createdAt)
              return output + [item]
            })
            completion(.success(items))
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

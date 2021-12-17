//
//  Repository.swift
//  luzie-locke-ios
//
//  Created by Harry on 31.10.21.
//

import UIKit

protocol ItemRepositoryProtocol {

  func create(title: String, price: String, description: String, images: [UIImage], completion: @escaping (Result<Void, LLError>) -> Void)
  
  func read(_ id: String, completion: @escaping (Result<Item, LLError>) -> Void)
  func readListLocal(cursor: TimeInterval, completion: @escaping (Result<([Item], TimeInterval), LLError>) -> Void)
  func readListSearch(keyword: String, cursor: TimeInterval, completion: @escaping (Result<([Item], TimeInterval), LLError>) -> Void)
  
  func update(_ id: String, title: String, price: String, description: String, images: [UIImage], oldImageUrls: [String?]?, completion: @escaping (Result<Void, LLError>) -> Void)
  func updateState(_ id: String, state: String, buyerId: String, completion: @escaping (Result<Void, LLError>) -> Void)
  func delete(_ id: String, imageUrls: [String?]?, completion: @escaping (Result<Void, LLError>) -> Void)
}

class ItemRepository: ItemRepositoryProtocol {

  private let backendClient: BackendClient
  private let imageRepository: ImageRepositoryProtocol
  
  init(backendClient: BackendClient, imageRepository: ImageRepositoryProtocol) {
    self.backendClient = backendClient
    self.imageRepository = imageRepository
  }
  
  func create(title: String, price: String, description: String, images: [UIImage], completion: @escaping (Result<Void, LLError>) -> Void) {
    createImageUrls(images: images) { result in
      switch result {
      case .success(let imageUrls):
        self.backendClient.POST(ItemCreateRequest(domain: Item(title: title, price: price, description: description, imageUrls: imageUrls))) { result in
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
      case .failure(let error):
        completion(.failure(error))
        return
      }
    }
  }
  
  func read(_ id: String, completion: @escaping (Result<Item, LLError>) -> Void) {
    backendClient.GET(ItemReadRequest(id: id)) { result in
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
    backendClient.GET(ItemListReadRequest(cursor: cursor, limit: 8)) { result in
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
    backendClient.GET(ItemReadListSearchRequest(q: SearchString(keyword), cursor: cursor, limit: 8)) { result in
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
  
  func update(_ id: String, title: String, price: String, description: String, images: [UIImage], oldImageUrls: [String?]?, completion: @escaping (Result<Void, LLError>) -> Void) {
    
    deleteImageUrls(imageUrls: oldImageUrls) { [weak self] result in
      guard let self = self else { return }
      switch result {
      case .success:
        self.createImageUrls(images: images) { result in
          switch result {
          case .success(let imageUrls):
            self.backendClient.PATCH(ItemUpdateRequest(domain: Item(id: id, title: title, price: price, description: description, imageUrls: imageUrls))) { result in
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
          case .failure(let error):
            completion(.failure(error))
            return
          }
        }
      case .failure(let error):
        print("[Error:\(#file):\(#line)] \(error)")
        completion(.failure(.unableToComplete))
      }
    }
  }
  
  func updateState(_ id: String, state: String, buyerId: String, completion: @escaping (Result<Void, LLError>) -> Void) {
    backendClient.PATCH(ItemStateUpdateRequest(id: id, state: state, buyerId: buyerId)) { result in
      switch result {
      case .success:
        completion(.success(()))
        
      case .failure(let error):
        print("[Error:\(#file):\(#line)] \(error)")
        completion(.failure(.unableToComplete))
      }
    }
  }
  
  func delete(_ id: String, imageUrls: [String?]?, completion: @escaping (Result<Void, LLError>) -> Void) {
    deleteImageUrls(imageUrls: imageUrls) { result in
      switch result {
      case .success:
        self.backendClient.DELETE(ItemDeleteRequest(id: id)) { result in
          switch result {
          case .success:
            completion(.success(()))
          case .failure(let error):
            print("[Error:\(#file):\(#line)] \(error)")
            completion(.failure(.unableToComplete))
          }
        }
      case .failure(let error):
        print("[Error:\(#file):\(#line)] \(error)")
        completion(.failure(.unableToComplete))
      }
    }
  }
  
  private func createImageUrls(images: [UIImage], completion: @escaping (Result<[String?], LLError>) -> Void) {
    var imageUrls = [String?](repeating: nil, count: images.count)
    
    let dispatchGroup = DispatchGroup()

    for i in 0 ..< images.count {
      dispatchGroup.enter()
      imageRepository.create(image: images[i]) { result in
        switch result {
        case .success(let url):
          imageUrls[i] = url
          dispatchGroup.leave()
        case .failure(let error):
          print("[Error:\(#file):\(#line)] \(error)")
          completion(.failure(error))
          return
        }
      }
    }
  
    dispatchGroup.notify(queue: .main) {
      completion(.success(imageUrls))
    }
  }
  
  private func deleteImageUrls(imageUrls: [String?]?, completion: @escaping (Result<Void, LLError>) -> Void) {
    if let imageUrls = imageUrls {
      let dispatchGroup = DispatchGroup()
    
      imageUrls.forEach { url in
        if let url = url {
          dispatchGroup.enter()
          imageRepository.delete(url: url) { result in
            switch result {
            case .success:
              dispatchGroup.leave()
            case .failure(let error):
              print("[Error:\(#file):\(#line)] \(error)")
              dispatchGroup.leave()
            }
          }
        }
      }
      
      dispatchGroup.notify(queue: .main) {
        completion(.success(()))
      }
    }
  }
}

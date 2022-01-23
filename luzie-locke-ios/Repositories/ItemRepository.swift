//
//  Repository.swift
//  luzie-locke-ios
//
//  Created by Harry on 31.10.21.
//

import UIKit
import Combine

protocol ItemRepositoryProtocol {

  func create(title: String, price: String, description: String, images: [UIImage], completion: @escaping (Result<Void, LLError>) -> Void)
  
  func read(_ id: String, completion: @escaping (Result<Item, LLError>) -> Void)
  func readListLocal(cursor: TimeInterval, completion: @escaping (Result<([ItemListElement], TimeInterval), LLError>) -> Void)
  func readListSearch(keyword: String, cursor: TimeInterval, completion: @escaping (Result<([ItemListElement], TimeInterval), LLError>) -> Void)
  
  func update(_ id: String, title: String, price: String, description: String, images: [UIImage], oldImageUrls: [String?]?, completion: @escaping (Result<Void, LLError>) -> Void)
  func updateState(_ id: String, state: String, buyerId: String, completion: @escaping (Result<Void, LLError>) -> Void)
  func delete(_ id: String, imageUrls: [String?]?, completion: @escaping (Result<Void, LLError>) -> Void)
}

class ItemRepository: ItemRepositoryProtocol {

  private let backendClient: BackendClient
  private let imageRepository: ImageRepositoryProtocol
  
  private var cancellables = Set<AnyCancellable>()
  
  init(backendClient: BackendClient, imageRepository: ImageRepositoryProtocol) {
    self.backendClient = backendClient
    self.imageRepository = imageRepository
  }
  
  func create(title: String, price: String, description: String, images: [UIImage], completion: @escaping (Result<Void, LLError>) -> Void) {
    createImageUrls(images: images) { [unowned self] result in
      switch result {
      case .success(let imageUrls):
        self.backendClient.POST(ItemCreateRequest(domain: Item(title: title, price: price, description: description, imageUrls: imageUrls)))
          .sink { result in
            switch result {
            case .failure(let error):
              print("[Error:\(#file):\(#line)] \(error.localizedDescription)")
              completion(.failure(.unableToComplete))
            case .finished: ()
            }
          } receiveValue: { _ in
            completion(.success(()))
          }
          .store(in: &self.cancellables)

      case .failure(let error):
        completion(.failure(error))
        return
      }
    }
  }
  
  func read(_ id: String, completion: @escaping (Result<Item, LLError>) -> Void) {
    backendClient.GET(ItemReadRequest(id: id))
      .tryMap { response -> ItemReadRequest.Response in
        guard let response = response else { throw LLError.invalidData }
        return response
      }
      .sink { result in
        switch result {
        case .failure(let error):
          print("[Error:\(#file):\(#line)] \(error.localizedDescription)")
          completion(.failure(.unableToComplete))
        case .finished: ()
        }
      } receiveValue: { response in
        completion(.success(ItemTranslator.translateItemDTOToItem(dto: response.item)))
      }
      .store(in: &cancellables)
  }
  
  func readListLocal(cursor: TimeInterval, completion: @escaping (Result<([ItemListElement], TimeInterval), LLError>) -> Void) {
    backendClient.GET(ItemListReadRequest(cursor: cursor, limit: 8))
      .tryMap { response -> ItemListReadRequest.Response in
        guard let response = response else { throw LLError.invalidData }
        return response
      }
      .sink { result in
        switch result {
        case .failure(let error):
          print("[Error:\(#file):\(#line)] \(error.localizedDescription)")
          completion(.failure(.unableToComplete))
        case .finished: ()
        }
      } receiveValue: { response in
        completion(.success((
          ItemTranslator.translateItemDTOListToItemList(dtoList: response.list),
          response.nextCursor)))
      }
      .store(in: &cancellables)
  }
  
  func readListSearch(keyword: String, cursor: TimeInterval, completion: @escaping (Result<([ItemListElement], TimeInterval), LLError>) -> Void) {
    backendClient.GET(ItemReadListSearchRequest(q: SearchString(keyword), cursor: cursor, limit: 8))
      .tryMap { response -> ItemReadListSearchRequest.Response in
        guard let response = response else { throw LLError.invalidData }
        return response
      }
      .sink { result in
        switch result {
        case .failure(let error):
          print("[Error:\(#file):\(#line)] \(error.localizedDescription)")
          completion(.failure(.unableToComplete))
        case .finished: ()
        }
      } receiveValue: { response in
        completion(.success((
          ItemTranslator.translateItemDTOListToItemList(dtoList: response.list),
          response.nextCursor)))
      }
      .store(in: &cancellables)
  }
  
  func update(_ id: String, title: String, price: String, description: String, images: [UIImage], oldImageUrls: [String?]?, completion: @escaping (Result<Void, LLError>) -> Void) {
    
    deleteImageUrls(imageUrls: oldImageUrls) { [weak self] result in
      guard let self = self else { return }
      switch result {
      case .success:
        self.createImageUrls(images: images) { result in
          switch result {
          case .success(let imageUrls):
            self.backendClient.PATCH(ItemUpdateRequest(domain: Item(id: id, title: title, price: price, description: description, imageUrls: imageUrls)))
              .sink { result in
                switch result {
                case .failure(let error):
                  print("[Error:\(#file):\(#line)] \(error.localizedDescription)")
                  completion(.failure(.unableToComplete))
                case .finished: ()
                }
              } receiveValue: { _ in
                completion(.success(()))
              }
              .store(in: &self.cancellables)
                           
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
    backendClient.PATCH(ItemStateUpdateRequest(id: id, state: state, buyerId: buyerId))
      .sink { result in
        switch result {
        case .failure(let error):
          print("[Error:\(#file):\(#line)] \(error.localizedDescription)")
          completion(.failure(.unableToComplete))
        case .finished: ()
        }
      } receiveValue: { _ in
        completion(.success(()))
      }
      .store(in: &cancellables)
  }
  
  func delete(_ id: String, imageUrls: [String?]?, completion: @escaping (Result<Void, LLError>) -> Void) {
    deleteImageUrls(imageUrls: imageUrls) { [unowned self] result in
      switch result {
      case .success:
        self.backendClient.DELETE(ItemDeleteRequest(id: id))
          .sink { result in
            switch result {
            case .failure(let error):
              print("[Error:\(#file):\(#line)] \(error.localizedDescription)")
              completion(.failure(.unableToComplete))
            case .finished: ()
            }
          } receiveValue: { _ in
            completion(.success(()))
          }
          .store(in: &self.cancellables)
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

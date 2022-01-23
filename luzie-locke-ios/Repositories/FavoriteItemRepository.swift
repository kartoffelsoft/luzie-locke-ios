//
//  FavoriteItemRepository.swift
//  luzie-locke-ios
//
//  Created by Harry on 03.12.21.
//

import UIKit
import Combine

protocol FavoriteItemRepositoryProtocol {

  func create(userId: String, itemId: String, completion: @escaping (Result<Void, LLError>) -> Void)
  func read(userId: String, itemId: String, completion: @escaping (Result<FavoriteItem?, LLError>) -> Void)
  func readItemList(userId: String, cursor: TimeInterval, completion: @escaping (Result<([ItemListElement], TimeInterval), LLError>) -> Void)
  func delete(userId: String, itemId: String, completion: @escaping (Result<Void, LLError>) -> Void)
}

class FavoriteItemRepository: FavoriteItemRepositoryProtocol {
  
  private let backendClient: BackendClient
  private var cancellables = Set<AnyCancellable>()
  
  init(backendClient: BackendClient) {
    self.backendClient = backendClient
  }
  
  func create(userId: String, itemId: String, completion: @escaping (Result<Void, LLError>) -> Void) {
    backendClient.POST(FavoriteItemCreateRequest(userId: userId, itemId: itemId))
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
  }
  
  func read(userId: String, itemId: String, completion: @escaping (Result<FavoriteItem?, LLError>) -> Void) {
    backendClient.GET(FavoriteItemReadRequest(userId: userId, itemId: itemId))
      .tryMap { response -> FavoriteItemReadRequest.Response in
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
        completion(.success(FavoriteItem(dto: response.favorite)))
      }
      .store(in: &cancellables)
  }
  
  func readItemList(userId: String, cursor: TimeInterval, completion: @escaping (Result<([ItemListElement], TimeInterval), LLError>) -> Void) {
    backendClient.GET(FavoriteItemListReadRequest(userId: userId, cursor: cursor, limit: 8))
      .tryMap { response -> FavoriteItemListReadRequest.Response in
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
  
  func delete(userId: String, itemId: String, completion: @escaping (Result<Void, LLError>) -> Void) {
    backendClient.DELETE(FavoriteItemDeleteRequest(userId: userId, itemId: itemId))
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
}

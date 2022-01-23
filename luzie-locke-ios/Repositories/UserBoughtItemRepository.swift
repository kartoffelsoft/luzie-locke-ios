//
//  UserBoughtItemRepository.swift
//  luzie-locke-ios
//
//  Created by Harry on 13.12.21.
//

import Foundation
import Combine

protocol UserBoughtItemRepositoryProtocol {

  func readItemList(userId: String, cursor: TimeInterval, completion: @escaping (Result<([ItemListElement], TimeInterval), LLError>) -> Void)
}

class UserBoughtItemRepository: UserBoughtItemRepositoryProtocol {
  
  private let backendClient: BackendClient
  private var cancellables = Set<AnyCancellable>()
  
  init(backendClient: BackendClient) {
    self.backendClient = backendClient
  }
  
  func readItemList(userId: String, cursor: TimeInterval, completion: @escaping (Result<([ItemListElement], TimeInterval), LLError>) -> Void) {
    backendClient.GET(ItemBoughtItemListReadRequest(userId: userId, cursor: cursor, limit: 8))
      .tryMap { response -> ItemBoughtItemListReadRequest.Response in
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
}

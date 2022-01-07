//
//  UserFavoriteUseCaseMock.swift
//  luzie-locke-iosTests
//
//  Created by Harry on 05.01.22.
//

import UIKit
@testable import luzie_locke_ios

class UserFavoriteItemUseCaseMock: UserFavoriteItemUseCaseProtocol {
  
  var fakeItemList = [ItemListElement]()
  
  func getMyList(cursor: TimeInterval, completion: @escaping (Result<([ItemListElement], TimeInterval), LLError>) -> Void) {
    completion(.success((fakeItemList, 999)))
  }
  
  func add(itemId: String, completion: @escaping (Result<Void, LLError>) -> Void) {
    fakeItemList.append(FakeModels.itemListElement(id: itemId))
    completion(.success(()))
  }
  
  func remove(itemId: String, completion: @escaping (Result<Void, LLError>) -> Void) {
    fakeItemList = fakeItemList.filter { item in
      return item.id != itemId
    }
    completion(.success(()))
  }
  
  func isAdded(itemId: String, completion: @escaping (Result<Bool, LLError>) -> Void) {
    let isContain = fakeItemList.contains { item in
      return item.id == itemId
    }
    completion(.success(isContain))
  }
}

//
//  ImageUseCaseMock.swift
//  luzie-locke-iosTests
//
//  Created by Harry on 07.01.22.
//

import UIKit
@testable import luzie_locke_ios

class ImageUseCaseMock: ImageUseCaseProtocol {
  
  var fakeResult: Result<UIImage?, LLError>?
  
  func setFakeResult(_ fakeResult: Result<UIImage?, LLError>?) {
    self.fakeResult = fakeResult
  }
  
  func getImage(url: String, completion: @escaping (Result<UIImage?, LLError>) -> Void) {
    guard let fakeResult = fakeResult else { return }
    completion(fakeResult)
  }
  
  func getImage(itemId: String, completion: @escaping (Result<UIImage?, LLError>) -> Void) {
    guard let fakeResult = fakeResult else { return }
    completion(fakeResult)
  }
  
  func getImage(userId: String, completion: @escaping (Result<UIImage?, LLError>) -> Void) {
    guard let fakeResult = fakeResult else { return }
    completion(fakeResult)
  }
}

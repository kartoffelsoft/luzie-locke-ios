//
//  ImageUseCaseSpy.swift
//  luzie-locke-iosTests
//
//  Created by Harry on 19.12.21.
//

import UIKit
@testable import luzie_locke_ios

class ImageUseCaseSpy: ImageUseCaseProtocol {
  
  var getImageIsCalled = false
  private var completionCallback: ((Result<UIImage?, LLError>) -> Void)?
  
  func getImage(url: String, completion: @escaping (Result<UIImage?, LLError>) -> Void) {
    getImageIsCalled = true
    completionCallback = completion
  }
  
  func getImage(itemId: String, completion: @escaping (Result<UIImage?, LLError>) -> Void) {
    getImageIsCalled = true
    completionCallback = completion
  }
  
  func getImage(userId: String, completion: @escaping (Result<UIImage?, LLError>) -> Void) {
    getImageIsCalled = true
    completionCallback = completion
  }
  
  func fetchCompletionWith(_ result:  (Result<UIImage?, LLError>)) {
    completionCallback?(result)
  }
}

//
//  ImageUseCaseSpy.swift
//  luzie-locke-iosTests
//
//  Created by Harry on 19.12.21.
//

import UIKit
@testable import luzie_locke_ios

class ImageUseCaseSpy: ImageUseCaseProtocol {
  
  var getImageWithUrlIsCalled     = false
  var getImageWithItemIdIsCalled  = false
  var getImageWithUserIdIsCalled  = false
  
  var completionCallbackWithUrl: ((Result<UIImage?, LLError>) -> Void)?
  var completionCallbackWithItemId: ((Result<UIImage?, LLError>) -> Void)?
  var completionCallbackWithUserId: ((Result<UIImage?, LLError>) -> Void)?
  
  func getImage(url: String, completion: @escaping (Result<UIImage?, LLError>) -> Void) {
    getImageWithUrlIsCalled   = true
    completionCallbackWithUrl = completion
  }
  
  func getImage(itemId: String, completion: @escaping (Result<UIImage?, LLError>) -> Void) {
    getImageWithItemIdIsCalled    = true
    completionCallbackWithItemId  = completion
  }
  
  func getImage(userId: String, completion: @escaping (Result<UIImage?, LLError>) -> Void) {
    getImageWithUserIdIsCalled    = true
    completionCallbackWithUserId  = completion
  }
//  
//  func fetchCompletionWith(_ result:  (Result<UIImage?, LLError>)) {
//    completionCallback?(result)
//  }
}

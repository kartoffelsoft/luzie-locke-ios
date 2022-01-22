//
//  OpenHTTPClientMock.swift
//  luzie-locke-iosTests
//
//  Created by Harry on 26.10.21.
//

import UIKit
import Combine

@testable import luzie_locke_ios

class OpenHTTPClientMock: OpenHTTP {
  
  func downloadImage(from urlString: String) -> AnyPublisher<UIImage, Error> {
    
  }
  
  var isDownloadImageCalled = false
  var downloadImageCompletion: ((Result<UIImage?, LLError>) -> Void)?
  
  
  func downloadImage(from urlString: String, completion: @escaping (Result<UIImage?, LLError>) -> Void) {
    isDownloadImageCalled   = true
    downloadImageCompletion = completion
  }
  
  func fetchDownloadImageCompletionWith(result: (Result<UIImage?, LLError>)) {
    downloadImageCompletion?(result)
  }
}

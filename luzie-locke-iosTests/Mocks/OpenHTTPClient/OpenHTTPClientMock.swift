//
//  OpenHTTPClientMock.swift
//  luzie-locke-iosTests
//
//  Created by Harry on 26.10.21.
//

import UIKit
@testable import luzie_locke_ios

class OpenHTTPClientMock: OpenHTTP {
  
  func downloadImage(from urlString: String, completion: @escaping (Result<UIImage?, LLError>) -> Void) {

  }
}

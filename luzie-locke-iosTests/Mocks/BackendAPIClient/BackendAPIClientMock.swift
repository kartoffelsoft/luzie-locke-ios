//
//  BackendAPIClientMock.swift
//  luzie-locke-iosTests
//
//  Created by Harry on 26.10.21.
//

import Foundation
@testable import luzie_locke_ios

class BackendAPIClientMock: BackendAPI {
  
  func downloadImage(from urlString: String, completion: @escaping (Result<UIImage?, LLError>) -> Void) {

  }
}

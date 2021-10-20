//
//  TokenHeaderRequestInterceptor.swift
//  luzie-locke-ios
//
//  Created by Harry on 19.10.21.
//

import Foundation

class TokenHeaderRequestInterceptor: KHTTPRequestInterceptor {
  
  private let token: String
  
  init(token: String) {
    self.token = token
  }
  
  func intercept(_ request: URLRequest) -> URLRequest {
    var interceptedRequest = request
    interceptedRequest.setValue("Bearer " + token, forHTTPHeaderField: "Authorization")
    return interceptedRequest
  }
}

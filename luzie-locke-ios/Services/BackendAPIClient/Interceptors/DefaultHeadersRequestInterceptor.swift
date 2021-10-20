//
//  Default.swift
//  luzie-locke-ios
//
//  Created by Harry on 19.10.21.
//

import Foundation

class DefaultHeadersRequestInterceptor: KHTTPRequestInterceptor {
  
  func intercept(_ request: URLRequest) -> URLRequest {
    var interceptedRequest = request
    BackendConfig.defaultHeaders.forEach({ (key, value) in
      interceptedRequest.setValue(value, forHTTPHeaderField: key)
    })
    return interceptedRequest
  }
}

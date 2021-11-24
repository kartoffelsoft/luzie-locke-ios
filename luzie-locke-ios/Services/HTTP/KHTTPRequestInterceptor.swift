//
//  Interceptor.swift
//  luzie-locke-ios
//
//  Created by Harry on 19.10.21.
//

import Foundation

public protocol KHTTPRequestInterceptor {
  
  func intercept(_ request: URLRequest) -> URLRequest
}

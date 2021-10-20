//
//  APIClient.swift
//  luzie-locke-ios
//
//  Created by Harry on 18.10.21.
//

import Foundation

typealias APIResultCallback<Value> = (Result<Value, LLError>) -> Void

protocol APIClient {
  
  func post<T: APIRequest>(
    _ request: T,
    completion: @escaping APIResultCallback<T.Response>)
}

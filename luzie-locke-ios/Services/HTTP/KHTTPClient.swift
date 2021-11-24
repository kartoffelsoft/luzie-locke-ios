//
//  KHTTPClient.swift
//  luzie-locke-ios
//
//  Created by Harry on 22.10.21.
//

import Foundation

class KHTTPClient {
  
  func send(with url: URL, completion: @escaping (Result<(URLResponse?, Data?), Error>) -> Void) {
    URLSession.shared.dataTask(with: url) { data, response, error in
      if let error = error {
        completion(.failure(error))
        return
      }
      
      completion(.success((response, data)))
    }.resume()
  }
  
  func send(with request: URLRequest, completion: @escaping (Result<(URLResponse?, Data?), Error>) -> Void) {
    URLSession.shared.dataTask(with: request) { data, response, error in
      if let error = error {
        completion(.failure(error))
        return
      }
      
      completion(.success((response, data)))
    }.resume()
  }
}

//
//  KHTTPClient.swift
//  luzie-locke-ios
//
//  Created by Harry on 22.10.21.
//

import Foundation
import Combine

class KHTTPClient {
  
  func send(with url: URL) -> AnyPublisher<Data, Error> {
    return URLSession.shared.dataTaskPublisher(for: url)
      .subscribe(on: DispatchQueue.global(qos: .default))
      .tryMap({ try self.handleURLResponse(result: $0, url: url) })
      .receive(on: DispatchQueue.main)
      .eraseToAnyPublisher()
  }
  
//  func send(with url: URL, completion: @escaping (Result<(URLResponse?, Data?), Error>) -> Void) {
//    URLSession.shared.dataTask(with: url) { data, response, error in
//      if let error = error {
//        completion(.failure(error))
//        return
//      }
//
//      completion(.success((response, data)))
//    }.resume()
//  }
  
  func send(with request: URLRequest, completion: @escaping (Result<(URLResponse?, Data?), Error>) -> Void) {
    URLSession.shared.dataTask(with: request) { data, response, error in
      if let error = error {
        completion(.failure(error))
        return
      }
      
      completion(.success((response, data)))
    }.resume()
  }
  
  private func handleURLResponse(result: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data {
    guard let response = result.response as? HTTPURLResponse,
          response.statusCode >= 200 && response.statusCode < 300 else {
            throw LLError.badServerResponse
    }
    return result.data
  }
}

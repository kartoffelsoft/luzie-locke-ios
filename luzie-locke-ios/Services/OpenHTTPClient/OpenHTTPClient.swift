//
//  HTTPClient.swift
//  luzie-locke-ios
//
//  Created by Harry on 22.10.21.
//

import UIKit
import Combine

protocol OpenHTTP {
  
  func downloadImage(from urlString: String) -> AnyPublisher<UIImage, Error>
  func downloadImage(from urlString: String, completion: @escaping (Result<UIImage?, LLError>) -> Void)
}

class OpenHTTPClient: OpenHTTP {
  
  let client:     KHTTPClient
  let cache:      NSCache<NSString, UIImage>

  private var cancellables = Set<AnyCancellable>()
  
  init(client: KHTTPClient) {
    self.client   = client
    self.cache    = NSCache<NSString, UIImage>()
  }
  
  func downloadImage(from urlString: String) -> AnyPublisher<UIImage, Error> {
    let cacheKey = NSString(string: urlString)
    
    if let image = cache.object(forKey: cacheKey) {
      return Just(image)
        .setFailureType(to: Error.self)
        .eraseToAnyPublisher()
    }
    
    guard let url = URL(string: urlString) else {
      return Fail(error: LLError.unableToComplete)
        .eraseToAnyPublisher()
    }
    
    return client.send(with: url)
      .tryMap { data in
        guard let image = UIImage(data: data) else {
          throw LLError.unableToComplete
        }
        return image
      }
      .eraseToAnyPublisher()
  }
  
  func downloadImage(from urlString: String, completion: @escaping (Result<UIImage?, LLError>) -> Void) {
    let cacheKey = NSString(string: urlString)
    
    if let image = cache.object(forKey: cacheKey) {
      completion(.success(image))
      return
    }
    
    guard let url = URL(string: urlString) else {
      completion(.failure(.unableToComplete))
      return
    }
    
    client.send(with: url)
      .sink { result in
        switch result {
        case .failure(let error):
          completion(.failure(.unableToComplete))
        case .finished: ()
        }
      } receiveValue: { [weak self] data in
        guard let image = UIImage(data: data) else {
          completion(.failure(.unableToComplete))
          return
        }
        self?.cache.setObject(image, forKey: cacheKey)
        completion(.success(image))
      }
      .store(in: &cancellables)
  }
}

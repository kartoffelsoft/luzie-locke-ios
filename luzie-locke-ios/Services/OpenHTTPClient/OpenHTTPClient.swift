//
//  HTTPClient.swift
//  luzie-locke-ios
//
//  Created by Harry on 22.10.21.
//

import UIKit

class OpenHTTPClient {
  
  let client:     KHTTPClient
  let cache:      NSCache<NSString, UIImage>

  init(client: KHTTPClient) {
    self.client   = client
    self.cache    = NSCache<NSString, UIImage>()
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
    
    client.send(with: url) { [weak self] result in
      guard let self = self else { return }
      
      switch(result) {
      case .success((let response, let data)):
        if let response = response as? HTTPURLResponse, response.statusCode == 200,
           let data = data, let image = UIImage(data: data) {
          self.cache.setObject(image, forKey: cacheKey)
          completion(.success(image))
        } else {
          completion(.failure(.unableToComplete))
        }
      case .failure(let error):
        completion(.failure(.unableToComplete))
      }
    }
  }
}

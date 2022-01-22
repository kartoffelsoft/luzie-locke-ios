//
//  ImageRepository.swift
//  luzie-locke-ios
//
//  Created by Harry on 29.11.21.
//

import UIKit
import Firebase
import Combine

protocol ImageRepositoryProtocol {
  
  func create(image: UIImage, completion: @escaping (Result<String, LLError>) -> Void)
  func read(url: String) -> AnyPublisher<UIImage, Error>
  func delete(url: String, completion: @escaping (Result<Void, LLError>) -> Void)
}

class ImageRepository: ImageRepositoryProtocol {
  
  private let httpClient: KHTTPClient
  private let cloudStorage: CloudStorage

  private let cache = NSCache<NSString, UIImage>()
  private var cancellables = Set<AnyCancellable>()
  
  init(httpClient: KHTTPClient, cloudStorage: CloudStorage) {
    self.httpClient = httpClient
    self.cloudStorage = cloudStorage
  }
  
  func create(image: UIImage, completion: @escaping (Result<String, LLError>) -> Void) {
    cloudStorage.uploadImage(image: image, completion: completion)
  }
  
  func read(url: String) -> AnyPublisher<UIImage, Error> {
    let cacheKey = NSString(string: url)
    
    if let image = cache.object(forKey: cacheKey) {
      return Just(image)
        .setFailureType(to: Error.self)
        .eraseToAnyPublisher()
    }
    
    guard let url = URL(string: url) else {
      return Fail(error: LLError.unableToComplete)
        .eraseToAnyPublisher()
    }
    
    return httpClient.send(with: url)
      .tryMap { data in
        guard let image = UIImage(data: data) else {
          throw LLError.unableToComplete
        }
        return image
      }
      .eraseToAnyPublisher()
  }

  
  func delete(url: String, completion: @escaping (Result<Void, LLError>) -> Void) {
    cloudStorage.deleteImage(url: url, completion: completion)
  }
}


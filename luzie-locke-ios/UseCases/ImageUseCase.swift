//
//  ImageUseCase.swift
//  luzie-locke-ios
//
//  Created by Harry on 10.12.21.
//

import UIKit
import Combine

protocol ImageUseCaseProtocol {
  
  func getImage(url: String, completion: @escaping (Result<UIImage?, LLError>) -> Void)
  func getImage(itemId: String, completion: @escaping (Result<UIImage?, LLError>) -> Void)
  func getImage(userId: String, completion: @escaping (Result<UIImage?, LLError>) -> Void)
}

class ImageUseCase: ImageUseCaseProtocol {
  
  private let openHttpClient: OpenHTTPClient
  private let backendClient:  BackendClient
  
  private var cancellables = Set<AnyCancellable>()
  
  init(openHttpClient: OpenHTTPClient, backendClient: BackendClient) {
    self.openHttpClient = openHttpClient
    self.backendClient  = backendClient
  }
  
  func getImage(url: String, completion: @escaping (Result<UIImage?, LLError>) -> Void) {
    openHttpClient.downloadImage(from: url)
      .sink { result in
        switch result {
        case .failure(let error):
          completion(.failure(.unableToComplete))
        case .finished: ()
        }
      } receiveValue: { image in
        completion(.success(image))
      }
      .store(in: &cancellables)
    
//    openHttpClient.downloadImage(from: url) { result in
//      switch result {
//      case .success(let image):
//        completion(.success(image))
//      case .failure:
//        completion(.failure(.unableToComplete))
//      }
//    }
  }
  
  func getImage(itemId: String, completion: @escaping (Result<UIImage?, LLError>) -> Void) {
    backendClient.GET(ItemImageUrlReadRequest(id: itemId)) { [weak self] result in
      switch result {
      case .success(let response):
        if let response = response {
          self?.getImage(url: response.url, completion: completion)
        } else {
          completion(.failure(.unableToComplete))
        }
        
      case .failure(let error):
        print("[Error:\(#file):\(#line)] \(error)")
        completion(.failure(.unableToComplete))
      }
    }
  }
  
  func getImage(userId: String, completion: @escaping (Result<UIImage?, LLError>) -> Void) {
    backendClient.GET(UserImageUrlReadRequest(id: userId)) { [weak self] result in
      switch result {
      case .success(let response):
        if let response = response {
          self?.getImage(url: response.url, completion: completion)
        } else {
          completion(.failure(.unableToComplete))
        }
        
      case .failure(let error):
        print("[Error:\(#file):\(#line)] \(error)")
        completion(.failure(.unableToComplete))
      }
    }
  }
}


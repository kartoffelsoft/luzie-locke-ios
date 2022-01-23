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
  
  private let imageRepository: ImageRepository
  private let backendClient:  BackendClient
  private var cancellables = Set<AnyCancellable>()
  
  init(imageRepository: ImageRepository, backendClient: BackendClient) {
    self.imageRepository = imageRepository
    self.backendClient  = backendClient
  }
  
  func getImage(url: String, completion: @escaping (Result<UIImage?, LLError>) -> Void) {
    imageRepository.read(url: url)
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
  }
  
  func getImage(itemId: String, completion: @escaping (Result<UIImage?, LLError>) -> Void) {
    backendClient.GET(ItemImageUrlReadRequest(id: itemId))
      .tryMap { response -> ItemImageUrlReadRequest.Response in
        guard let response = response else { throw LLError.invalidData }
        return response
      }
      .sink { result in
        switch result {
        case .failure(let error):
          print("[Error:\(#file):\(#line)] \(error.localizedDescription)")
          completion(.failure(.unableToComplete))
        case .finished: ()
        }
      } receiveValue: { [weak self] response in
        self?.getImage(url: response.url, completion: completion)
      }
      .store(in: &cancellables)
  }
  
  func getImage(userId: String, completion: @escaping (Result<UIImage?, LLError>) -> Void) {
    backendClient.GET(UserImageUrlReadRequest(id: userId))
      .tryMap { response -> UserImageUrlReadRequest.Response in
        guard let response = response else { throw LLError.invalidData }
        return response
      }
      .sink { result in
        switch result {
        case .failure(let error):
          print("[Error:\(#file):\(#line)] \(error.localizedDescription)")
          completion(.failure(.unableToComplete))
        case .finished: ()
        }
      } receiveValue: { [weak self] response in
        self?.getImage(url: response.url, completion: completion)
      }
      .store(in: &cancellables)
  }
}


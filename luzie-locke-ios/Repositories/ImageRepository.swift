//
//  ImageRepository.swift
//  luzie-locke-ios
//
//  Created by Harry on 29.11.21.
//

import Firebase
import UIKit

protocol ImageRepositoryProtocol {
  
  func create(image: UIImage, completion: @escaping (Result<String, LLError>) -> Void)
  func delete(url: String, completion: @escaping (Result<Void, LLError>) -> Void)
}

class ImageRepository: ImageRepositoryProtocol {
  
  private let cloudStorage: CloudStorage

  init(cloudStorage: CloudStorage) {
    self.cloudStorage = cloudStorage
  }
  
  func create(image: UIImage, completion: @escaping (Result<String, LLError>) -> Void) {
    cloudStorage.uploadImage(image: image, completion: completion)
  }
  
  func delete(url: String, completion: @escaping (Result<Void, LLError>) -> Void) {
    cloudStorage.deleteImage(url: url, completion: completion)
  }
}

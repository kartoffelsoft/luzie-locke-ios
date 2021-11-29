//
//  CloudStorage.swift
//  luzie-locke-ios
//
//  Created by Harry on 29.10.21.
//

import UIKit

protocol CloudStorage {
  
  func uploadImage(image: UIImage, completion: @escaping (Result<String, LLError>) -> Void)
  func deleteImage(url: String, completion: @escaping (Result<Void, LLError>) -> Void) 
}

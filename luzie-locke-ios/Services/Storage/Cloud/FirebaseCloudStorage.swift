//
//  FirebaseCloudStorage.swift
//  luzie-locke-ios
//
//  Created by Harry on 29.10.21.
//

import UIKit
import Firebase

class FirebaseCloudStorage: CloudStorage {
  
  func uploadImage(image: UIImage, completion: @escaping (Result<String, LLError>) -> Void) {
    guard let imageData = image.jpegData(compressionQuality: 0.1) else { return }
    
    let filename = UUID().uuidString
    let ref = Storage.storage().reference(withPath: "/images/item/\(filename)")
    
    ref.putData(imageData, metadata: nil) { (_, err) in
      if let err = err {
        print("Failed to upload image to storage: ", err)
        completion(.failure(.unableToCompleteUpload))
        return
      }
      
      ref.downloadURL(completion: { (url, err) in
        if let err = err {
          print("Failed to retrieve download URL: ", err)
          completion(.failure(.unableToCompleteUpload))
          return
        }
        
        if let url = url {
          completion(.success(url.absoluteString))
        } else {
          print("Failed to retrieve download URL: nil")
          completion(.failure(.unableToCompleteUpload))
        }
      })
    }
  }
}

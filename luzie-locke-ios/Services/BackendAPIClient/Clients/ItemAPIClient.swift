//
//  ItemAPIClient.swift
//  luzie-locke-ios
//
//  Created by Harry on 30.10.21.
//

import Foundation

protocol ItemAPI {
  
  func create(title: String, price: String, description: String, images: [String?], completion: @escaping (Result<Void, LLError>) -> Void)
}

class ItemAPIClient: ItemAPI {
  
  private let client: KHTTPAPIClient
  
  init(client: KHTTPAPIClient) {
    self.client = client
  }

  func create(title: String, price: String, description: String, images: [String?], completion: @escaping (Result<Void, LLError>) -> Void) {
//    client.POST(ItemCreateRequest(title: title, price: price, description: description, images: images)) { result in
//      DispatchQueue.main.async {
//        switch result {
//        case .success:
//          completion(.success(()))
//        case .failure(let error):
//          print("[Error:\(#file):\(#line)] \(error)")
//          completion(.failure(.unableToComplete))
//        }
//      }
//    }
  }
}

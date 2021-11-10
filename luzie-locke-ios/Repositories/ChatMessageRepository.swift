//
//  ChatMessageRepository.swift
//  luzie-locke-ios
//
//  Created by Harry on 10.11.21.
//

import Foundation


protocol ChatRepositoryProtocol {

}

class ChatRepository: ChatRepositoryProtocol {
  
  private let backendClient: KHTTPAPIClient
  
  init(backendClient: KHTTPAPIClient) {
    self.backendClient = backendClient
  }
}

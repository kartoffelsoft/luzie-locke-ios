//
//  BackendAPIClient.swift
//  luzie-locke-ios
//
//  Created by Harry on 18.10.21.
//

import Foundation

class BackendAPIClient {
  
  let client: KHTTPAPIClient
  let user:   UserAPIClient
  
  init(client: KHTTPAPIClient) {
    self.client = client
    self.user   = UserAPIClient(client: client)
    
    configureDefaultHeaders()
  }
  
  private func configureDefaultHeaders() {
    client.globalRequestInterceptors.append(DefaultHeadersRequestInterceptor())
  }
  
  func configureTokenHeader(token: String) {
    client.globalRequestInterceptors.append(TokenHeaderRequestInterceptor(token: token))
  }
}

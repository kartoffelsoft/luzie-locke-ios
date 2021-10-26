//
//  BackendAPIClient.swift
//  luzie-locke-ios
//
//  Created by Harry on 18.10.21.
//

import Foundation

class BackendAPIClient {
  
  let client:   KHTTPAPIClient
  let userApi:  UserAPI
  
  init(client: KHTTPAPIClient, userApi: UserAPI) {
    self.client   = client
    self.userApi  = userApi
    
    configureDefaultHeaders()
  }
  
  private func configureDefaultHeaders() {
    client.globalRequestInterceptors.append(DefaultHeadersRequestInterceptor())
  }
  
  func configureTokenHeader(token: String) {
    client.globalRequestInterceptors.append(TokenHeaderRequestInterceptor(token: token))
  }
}

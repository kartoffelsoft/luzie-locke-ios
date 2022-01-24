//
//  KHTTPClient.swift
//  luzie-locke-ios
//
//  Created by Harry on 19.10.21.
//

import Foundation
import Combine

public class BackendClient {
  
  public var globalRequestInterceptors = [HTTPRequestInterceptor]()
  
  private let baseEndpoint: String
  private let httpClient = HTTPClient()
  private let decoder = JSONDecoder()
  
  public init(baseEndpoint: String) {
    self.baseEndpoint = baseEndpoint
    self.decoder.dateDecodingStrategy = .formatted(Formatter.iso8601)
  }
  
  func GET<T>(_ request: T) -> AnyPublisher<T.Response?, Error> where T : APIRequest {
    guard
      let url = URL(string: baseEndpoint + request.resourceName + request.toDictionary().urlQueryString)
    else {
      return Fail(error: LLError.invalidURL).eraseToAnyPublisher()
    }
    
    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = "GET"
    let interceptedRequest = applyRequestInterceptors(urlRequest)
    
    return httpClient.send(for: interceptedRequest)
      .decode(type: BackendResponse<T.Response>.self, decoder: decoder)
      .map { response in
        return response.data as T.Response?
      }
      .receive(on: DispatchQueue.main)
      .eraseToAnyPublisher()
  }
  
  func POST<T>(_ request: T) -> AnyPublisher<T.Response?, Error> where T : APIRequest {
    guard
      let url = URL(string: baseEndpoint + request.resourceName)
    else {
      return Fail(error: LLError.invalidURL).eraseToAnyPublisher()
    }
    
    var urlRequest = URLRequest(url: url)
    
    do {
      urlRequest.httpBody = try JSONSerialization.data(withJSONObject: request.toDictionary(), options: .init())
      urlRequest.httpMethod = "POST"
    } catch(let error){
      return Fail(error: error).eraseToAnyPublisher()
    }

    let interceptedRequest  = applyRequestInterceptors(urlRequest)
    
    return httpClient.send(for: interceptedRequest)
      .decode(type: BackendResponse<T.Response>.self, decoder: decoder)
      .map { response in
        return response.data as T.Response?
      }
      .receive(on: DispatchQueue.main)
      .eraseToAnyPublisher()
  }
  
  func PATCH<T>(_ request: T) -> AnyPublisher<T.Response?, Error> where T : APIRequest {
    guard
      let url = URL(string: baseEndpoint + request.resourceName)
    else {
      return Fail(error: LLError.invalidURL).eraseToAnyPublisher()
    }
    
    var urlRequest = URLRequest(url: url)
    
    do {
      urlRequest.httpBody = try JSONSerialization.data(withJSONObject: request.toDictionary(), options: .init())
      urlRequest.httpMethod = "PATCH"
    } catch(let error){
      return Fail(error: error).eraseToAnyPublisher()
    }

    let interceptedRequest  = applyRequestInterceptors(urlRequest)
    
    return httpClient.send(for: interceptedRequest)
      .decode(type: BackendResponse<T.Response>.self, decoder: decoder)
      .map { response in
        return response.data as T.Response?
      }
      .receive(on: DispatchQueue.main)
      .eraseToAnyPublisher()
  }
  
  func DELETE<T>(_ request: T) -> AnyPublisher<T.Response?, Error> where T : APIRequest {
    guard
      let url = URL(string: baseEndpoint + request.resourceName)
    else {
      return Fail(error: LLError.invalidURL).eraseToAnyPublisher()
    }
    
    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = "DELETE"
    let interceptedRequest = applyRequestInterceptors(urlRequest)
    
    return httpClient.send(for: interceptedRequest)
      .decode(type: BackendResponse<T.Response>.self, decoder: decoder)
      .map { response in
        return response.data as T.Response?
      }
      .receive(on: DispatchQueue.main)
      .eraseToAnyPublisher()
  }
  
  private func applyRequestInterceptors(_ request: URLRequest) -> URLRequest {
    var interceptedRequest = request
    globalRequestInterceptors.forEach { interceptor in
      interceptedRequest = interceptor.intercept(interceptedRequest)
    }
    return interceptedRequest
  }
}

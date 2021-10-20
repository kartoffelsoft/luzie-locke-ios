//
//  KHTTPClient.swift
//  luzie-locke-ios
//
//  Created by Harry on 19.10.21.
//

import Foundation

public class KHTTPAPIClient {
  
  public var globalRequestInterceptors = [KHTTPRequestInterceptor]()
  
  let baseEndpoint: String
  
  public init(baseEndpoint: String) {
    self.baseEndpoint = baseEndpoint
  }
  
  func POST<T>(_ request: T, completion: @escaping APIResultCallback<T.Response?>) where T : APIRequest {
    guard let url = URL(string: baseEndpoint + request.resourceName) else { return }
    
    do {
      let body                = try JSONSerialization.data(withJSONObject: request.toDictionary(), options: .init())
      
      var urlRequest          = URLRequest(url: url)
      urlRequest.httpBody     = body
      urlRequest.httpMethod   = "POST"
      let interceptedRequest  = applyRequestInterceptors(urlRequest)
      
      URLSession.shared.dataTask(with: interceptedRequest) { data, response, error in
        if let _ = error {
          completion(.failure(.unableToComplete))
          return
        }
        
        if let data = data {
          do {
            let response = try JSONDecoder().decode(BackendResponse<T.Response>.self, from: data)
            
            if response.status == "OK" {
              completion(.success(response.data as T.Response?))
            } else {
              print("[Error:\(#file):\(#line)] \(response.message ?? "")")
              completion(.failure(.serverErrorResponse))
            }
          } catch {
            print("[Error:\(#file):\(#line)] \(error)")
            completion(.failure(.unableToComplete))
          }
        } else {
          completion(.failure(.unableToComplete))
        }
      }.resume()
    } catch {
      print("[Error:\(#file):\(#line)] \(error)")
      completion(.failure(.unableToComplete))
    }
  }
  
  func PATCH<T>(_ request: T, completion: @escaping APIResultCallback<T.Response?>) where T: APIRequest {
    guard let url = URL(string: baseEndpoint + request.resourceName) else { return }
    
    do {
      let body                = try JSONSerialization.data(withJSONObject: request.toDictionary(), options: .init())
      
      var urlRequest          = URLRequest(url: url)
      urlRequest.httpBody     = body
      urlRequest.httpMethod   = "PATCH"
      let interceptedRequest  = applyRequestInterceptors(urlRequest)
      
      URLSession.shared.dataTask(with: interceptedRequest) { data, response, error in
        if let error = error {
          print("[Error:\(#file):\(#line)] \(error)")
          completion(.failure(.unableToComplete))
          return
        }
        
        if let data = data {
          do {
            let response = try JSONDecoder().decode(BackendResponse<T.Response>.self, from: data)
            if response.status == "OK" {
              completion(.success(response.data as T.Response?))
            } else {
              print("[Error:\(#file):\(#line)] \(response.message ?? "")")
              completion(.failure(.serverErrorResponse))
            }
          } catch {
            print("[Error:\(#file):\(#line)] \(error)")
            completion(.failure(.unableToComplete))
          }
        } else {
          completion(.failure(.unableToComplete))
        }
      }.resume()
    } catch {
      print("[Error:\(#file):\(#line)] \(error)")
      completion(.failure(.unableToComplete))
    }
  }
  
  private func applyRequestInterceptors(_ request: URLRequest) -> URLRequest {
    var interceptedRequest = request
    globalRequestInterceptors.forEach { interceptor in
      interceptedRequest = interceptor.intercept(interceptedRequest)
    }
    return interceptedRequest
  }
}

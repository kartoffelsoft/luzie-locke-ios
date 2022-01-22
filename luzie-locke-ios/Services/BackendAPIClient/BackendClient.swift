//
//  KHTTPClient.swift
//  luzie-locke-ios
//
//  Created by Harry on 19.10.21.
//

import Foundation

public class BackendClient {
  
  public var globalRequestInterceptors = [HTTPRequestInterceptor]()
  
  let baseEndpoint: String
  let httpClient = HTTPClient()
  
  public init(baseEndpoint: String) {
    self.baseEndpoint = baseEndpoint
  }
  
  func GET<T>(_ request: T, completion: @escaping APIResultCallback<T.Response?>) where T : APIRequest {
    guard
      let url = URL(string: baseEndpoint + request.resourceName + request.toDictionary().urlQueryString)
    else { return }
    
    var urlRequest          = URLRequest(url: url)
    urlRequest.httpMethod   = "GET"
    let interceptedRequest  = applyRequestInterceptors(urlRequest)
    
    httpClient.send(for: interceptedRequest) { result in
      switch result {
      case .success((_, let data)):
        if let data = data {
          do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .formatted(Formatter.iso8601)
            
            let response = try decoder.decode(BackendResponse<T.Response>.self, from: data)
            if response.success {
              completion(.success(response.data as T.Response?))
            } else {
              print("[Error:\(#file):\(#line)] \(response.message )")
              completion(.failure(.badServerResponse))
            }
          } catch {
            print("[Error:\(#file):\(#line)] \(error)")
            completion(.failure(.unableToComplete))
          }
        } else {
          completion(.failure(.unableToComplete))
        }
      case .failure(let error):
        print("[Error:\(#file):\(#line)] \(error)")
        completion(.failure(.unableToComplete))
      }
    }
  }
  
  func POST<T>(_ request: T, completion: @escaping APIResultCallback<T.Response?>) where T : APIRequest {
    guard let url = URL(string: baseEndpoint + request.resourceName) else { return }
    
    do {
      let body                = try JSONSerialization.data(withJSONObject: request.toDictionary(), options: .init())
      
      var urlRequest          = URLRequest(url: url)
      urlRequest.httpBody     = body
      urlRequest.httpMethod   = "POST"
      let interceptedRequest  = applyRequestInterceptors(urlRequest)
      
      httpClient.send(for: interceptedRequest) { result in
        switch result {
        case .success((_, let data)):
          if let data = data {
            do {
              let response = try JSONDecoder().decode(BackendResponse<T.Response>.self, from: data)
              if response.success {
                completion(.success(response.data as T.Response?))
              } else {
                print("[Error:\(#file):\(#line)] \(response.message )")
                completion(.failure(.badServerResponse))
              }
            } catch {
              print("[Error:\(#file):\(#line)] \(error)")
              completion(.failure(.unableToComplete))
            }
          } else {
            completion(.failure(.unableToComplete))
          }
        case .failure:
          completion(.failure(.unableToComplete))
        }
      }
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
      
      httpClient.send(for: interceptedRequest) { result in
        switch result {
        case .success((_, let data)):
          if let data = data {
            do {
              let response = try JSONDecoder().decode(BackendResponse<T.Response>.self, from: data)
              if response.success {
                completion(.success(response.data as T.Response?))
              } else {
                print("[Error:\(#file):\(#line)] \(response.message )")
                completion(.failure(.badServerResponse))
              }
            } catch {
              print("[Error:\(#file):\(#line)] \(error)")
              completion(.failure(.unableToComplete))
            }
          } else {
            completion(.failure(.unableToComplete))
          }
        case .failure:
          completion(.failure(.unableToComplete))
        }
      }
    } catch {
      print("[Error:\(#file):\(#line)] \(error)")
      completion(.failure(.unableToComplete))
    }
  }
  
  func DELETE<T>(_ request: T, completion: @escaping APIResultCallback<T.Response?>) where T : APIRequest {
    guard let url = URL(string: baseEndpoint + request.resourceName) else { return }
    
    var urlRequest          = URLRequest(url: url)
    urlRequest.httpMethod   = "DELETE"
    let interceptedRequest  = applyRequestInterceptors(urlRequest)
    
    httpClient.send(for: interceptedRequest) { result in
      switch result {
      case .success((_, let data)):
        if let data = data {
          do {
            let response = try JSONDecoder().decode(BackendResponse<T.Response>.self, from: data)
            if response.success {
              completion(.success(response.data as T.Response?))
            } else {
              print("[Error:\(#file):\(#line)] \(response.message )")
              completion(.failure(.badServerResponse))
            }
          } catch {
            print("[Error:\(#file):\(#line)] \(error)")
            completion(.failure(.unableToComplete))
          }
        } else {
          completion(.failure(.unableToComplete))
        }
      case .failure:
        completion(.failure(.unableToComplete))
      }
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

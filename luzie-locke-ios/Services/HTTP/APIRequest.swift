//
//  APIRequest.swift
//  luzie-locke-ios
//
//  Created by Harry on 18.10.21.
//

import Foundation

protocol APIRequest: Encodable {
  
  associatedtype Response: Decodable
  var resourceName: String { get }
  
  func toDictionary() -> [String: Any]
}

//
//  BackendConfig.swift
//  luzie-locke-ios
//
//  Created by Harry on 19.10.21.
//

import Foundation

struct BackendConfig {
  
  static let host = ProcessInfo.processInfo.environment["BACKEND_URL"] ?? ""
  static let defaultHeaders = ["Accept": "application/json", "Content-Type": "application/json"]
}

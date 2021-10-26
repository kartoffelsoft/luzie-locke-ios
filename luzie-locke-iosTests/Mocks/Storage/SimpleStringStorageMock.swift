//
//  SimpleStringStorageMock.swift
//  luzie-locke-iosTests
//
//  Created by Harry on 26.10.21.
//

import Foundation
@testable import luzie_locke_ios

class SimpleStringStorageMock: Storage {
  
  private var data: String = ""
  private let key: String
  
  init(key: String) {
    self.key = key
  }
  
  func get() -> String? {
    return data
  }
  
  func set(_ data: String) {
    self.data = data
  }
  
  func clear() {
    self.data = ""
  }
}

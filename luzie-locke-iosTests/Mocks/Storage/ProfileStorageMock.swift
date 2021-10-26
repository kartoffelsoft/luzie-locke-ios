//
//  ProfileStorageMock.swift
//  luzie-locke-iosTests
//
//  Created by Harry on 26.10.21.
//

import Foundation
@testable import luzie_locke_ios

class ProfileStorageMock: Storage {
  
  private var data: Profile?
  private let key: String
  
  init(key: String) {
    self.key = key
  }
  
  func get() -> Profile? {
    return data
  }
  
  func set(_ data: Profile) {
    self.data = data
  }
  
  func clear() {
    self.data = nil
  }
}

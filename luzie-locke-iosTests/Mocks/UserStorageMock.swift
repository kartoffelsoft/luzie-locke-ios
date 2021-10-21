//
//  UserStorageMock.swift
//  luzie-locke-iosTests
//
//  Created by Harry on 13.10.21.
//

import UIKit
@testable import luzie_locke_ios

class UserStorageMock: UserStorable {
  
  private var empty = false
  
  func get() -> User? { return nil }
  func set(_ data: User) {}
  func clear() {}
  
  func isEmpty() -> Bool {
    return empty
  }
  
  func setIsEmpty(empty: Bool) {
    self.empty = empty
  }
}

//
//  AccessTokenStorage.swift
//  luzie-locke-ios
//
//  Created by Harry on 20.10.21.
//

import Foundation

class SimpleStringStorage: Storage {
  
  private var data: String = ""
  private let key:  String
  
  init(key: String) {
    self.key = key
    
    if let stored = UserDefaults.standard.string(forKey: self.key) {
      self.data = stored
    }
  }
  
  func get() -> String? {
    return data
  }
  
  func set(_ data: String) {
      UserDefaults.standard.set(data, forKey: self.key)
      self.data = data
  }
  
  func clear() {
    data = ""
  }
  
  func isEmpty() -> Bool {
    return data.isEmpty
  }
}

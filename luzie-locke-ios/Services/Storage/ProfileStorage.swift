//
//  ProfileStorage.swift
//  luzie-locke-ios
//
//  Created by Harry on 20.10.21.
//

import Foundation

class ProfileStorage: Storage {
  
  private var data: Profile?
  private let key: String
  
  init(key: String) {
    self.key = key
    
    if let stored = UserDefaults.standard.object(forKey: self.key) as? Data {
      let decoder = JSONDecoder()
      if let data = try? decoder.decode(Profile.self, from: stored) {
        self.data = data
      }
    }
  }
  
  func get() -> Profile? {
    return data
  }
  
  func set(_ data: Profile) {
    let encoder = JSONEncoder()
    if let encoded = try? encoder.encode(data) {
      UserDefaults.standard.set(encoded, forKey: self.key)
      self.data = data
    }
  }
  
  func clear() {
  }
}

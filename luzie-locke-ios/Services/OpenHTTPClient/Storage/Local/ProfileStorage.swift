//
//  ProfileStorage.swift
//  luzie-locke-ios
//
//  Created by Harry on 20.10.21.
//

import Foundation

class ProfileStorage: LocalStorage {
  
  private var data: UserProfile?
  private let key: String
  
  init(key: String) {
    self.key = key
    
    if let stored = UserDefaults.standard.object(forKey: self.key) as? Data {
      let decoder = JSONDecoder()
      if let data = try? decoder.decode(UserProfile.self, from: stored) {
        self.data = data
      }
    }
  }
  
  func get() -> UserProfile? {
    return data
  }
  
  func set(_ data: UserProfile) {
    let encoder = JSONEncoder()
    if let encoded = try? encoder.encode(data) {
      UserDefaults.standard.set(encoded, forKey: self.key)
      self.data = data
    }
  }
  
  func clear() {
  }
}

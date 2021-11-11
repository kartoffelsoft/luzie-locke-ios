//
//  ProfileRepository.swift
//  luzie-locke-ios
//
//  Created by Harry on 10.11.21.
//

import Foundation

protocol LocalProfileRepositoryProtocol {

  func read() -> UserProfile?
  func update(_ data: UserProfile)
  func delete()
}

class LocalProfileRepository: LocalProfileRepositoryProtocol {
  
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
  
  func read() -> UserProfile? {
    return data
  }
  
  func update(_ data: UserProfile) {
    let encoder = JSONEncoder()
    if let encoded = try? encoder.encode(data) {
      UserDefaults.standard.set(encoded, forKey: self.key)
      self.data = data
    }
  }
  
  func delete() {
    data = nil
    // delete UserDefault
  }
}

//
//  ProfileRepository.swift
//  luzie-locke-ios
//
//  Created by Harry on 10.11.21.
//

import Foundation

protocol ProfileRepositoryProtocol {

  func read() -> User?
  func update(_ data: User)
  func delete()
}

class ProfileRepository: ProfileRepositoryProtocol {
  
  private var data: User?
  private let key: String
  
  init(key: String) {
    self.key = key
    
    if let stored = UserDefaults.standard.object(forKey: self.key) as? Data {
      let decoder = JSONDecoder()
      if let data = try? decoder.decode(User.self, from: stored) {
        self.data = data
      }
    }
  }
  
  func read() -> User? {
    return data
  }
  
  func update(_ data: User) {
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

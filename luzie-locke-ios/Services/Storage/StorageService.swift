//
//  StorageService.swift
//  luzie-locke-ios
//
//  Created by Harry on 20.10.21.
//

import Foundation

class StorageService {
  
  let profile:      AnyStorage<User>
  let accessToken:  AnyStorage<String>
  let refreshToken: AnyStorage<String>
  
  init(profile: AnyStorage<User>, accessToken: AnyStorage<String>, refreshToken: AnyStorage<String>) {
    self.profile      = profile
    self.accessToken  = accessToken
    self.refreshToken = refreshToken
  }
}

//
//  UserAPIClientMock.swift
//  luzie-locke-iosTests
//
//  Created by Harry on 26.10.21.
//

import Foundation
@testable import luzie_locke_ios

class UserAPIClientMock: UserAPI {
  
  func authenticate(uid: String, token: String, completion: @escaping (Result<(profile: Profile, accessToken: String, refreshToken: String), LLError>?) -> Void) {
    
  }
  
  func updateLocation(name: String, lat: Double, lng: Double, completion: @escaping (Result<Profile, LLError>?) -> Void) {
    
  }
}

//
//  UserAPIClientMock.swift
//  luzie-locke-iosTests
//
//  Created by Harry on 26.10.21.
//

import Foundation
@testable import luzie_locke_ios

class UserAPIClientMock: UserAPI {
  
  func authenticate(uid: String, token: String, completion: @escaping (Result<(profile: UserProfile, accessToken: String, refreshToken: String), LLError>?) -> Void) {
    
  }
  
  func updateLocation(city: String, lat: Double, lng: Double, completion: @escaping (Result<UserProfile, LLError>?) -> Void) {
    
  }
}

//
//  AuthenticationRequest.swift
//  luzie-locke-ios
//
//  Created by Harry on 20.10.21.
//

import Foundation

struct AuthenticationResponse: Decodable {
  let profile: UserProfile
  let accessToken: String
  let refreshToken: String
}

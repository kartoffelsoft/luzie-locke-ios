//
//  User.swift
//  luzie-locke-ios
//
//  Created by Harry on 11.10.21.
//

import Foundation

struct User: Codable {
    let profile: Profile
    let accessToken: String
    let refreshToken: String
}

struct Profile: Codable {
    let googleId: String
    let name: String
    let email: String
    let pictureURI: String
}

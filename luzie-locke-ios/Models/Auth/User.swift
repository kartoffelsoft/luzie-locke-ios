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
    let uid: String
    let name: String
    let email: String
    let reputation: Int
    let pictureURI: String
    let location: Location
}

struct Location: Codable {
    let name: String
    let geoJSON: GeoJSON
}

struct GeoJSON: Codable {
    let type: String
    let coordinates: [Double]
}

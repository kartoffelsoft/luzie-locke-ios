//
//  UserTranslator.swift
//  luzie-locke-ios
//
//  Created by Harry on 11.11.21.
//

import Foundation

class UserTranslator {
  static func translateUserProfileDTOToUser(dto: UserProfileDTO) -> UserProfile {
    return UserProfile(_id: dto._id,
                       name: dto.name,
                       email: dto.email,
                       reputation: dto.reputation,
                       pictureURI: dto.pictureURI,
                       location: UserProfile.Location(
                                   name: dto.location?.name,
                                   geoJSON: UserProfile.GeoJSON(
                                              type: dto.location?.geoJSON?.type,
                                              coordinates: dto.location?.geoJSON?.coordinates)))
  }
}

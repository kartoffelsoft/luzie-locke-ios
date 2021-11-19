//
//  UserTranslator.swift
//  luzie-locke-ios
//
//  Created by Harry on 11.11.21.
//

import Foundation

class UserTranslator {
  static func translateUserProfileDTOToUser(dto: UserProfileDTO) -> UserProfile {
    return UserProfile(id: dto.id,
                       name: dto.name,
                       email: dto.email,
                       reputation: dto.reputation,
                       imageUrl: dto.imageUrl,
                       locationName: dto.locationName,
                       locationCoordinates: UserProfile.Coordinates(
                         type: dto.locationCoordinates?.type,
                         coordinates: dto.locationCoordinates?.coordinates
                       ))
  }
}

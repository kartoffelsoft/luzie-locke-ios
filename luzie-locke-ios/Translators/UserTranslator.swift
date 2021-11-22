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
                       city: dto.city,
                       location: UserProfile.Location(
                         type: dto.location?.type,
                         coordinates: dto.location?.coordinates
                       ))
  }
}

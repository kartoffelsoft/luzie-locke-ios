//
//  FakeModels+User.swift
//  luzie-locke-iosTests
//
//  Created by Harry on 08.01.22.
//

import Foundation

@testable import luzie_locke_ios

extension FakeModels {
  
  static func userProfile(
    id: String = Faker.datatype.id(),
    name: String = Faker.name.findName(),
    reputation: Int = Faker.datatype.int(),
    imageUrl: String = Faker.image.imageUrl(),
    city: String = Faker.address.city(),
    location: UserProfile.Location = UserProfile.Location(type: "2DPoint",
                                                          coordinates: [
                                                          Faker.datatype.double(),
                                                          Faker.datatype.double()])
  ) -> UserProfile {
    return UserProfile(id: id,
                       name: name,
                       reputation: reputation,
                       imageUrl: imageUrl,
                       city: city,
                       location: location)
  }
  
  static func userProfileBrief(
    name: String = Faker.name.findName(),
    imageUrl: String = Faker.image.imageUrl(),
    city: String = Faker.address.city()
  ) -> UserProfileBrief {
    return UserProfileBrief(name: name,
                            city: city,
                            imageUrl: imageUrl)
  }
}

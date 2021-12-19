//
//  FakeUserProfile.swift
//  luzie-locke-iosTests
//
//  Created by Harry on 19.12.21.
//

import Foundation

@testable import luzie_locke_ios

class FakeModels {
  
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
  
  static func myProfileCellModel(
    name: String = Faker.name.findName(),
    imageUrl: String = Faker.image.imageUrl(),
    city: String = Faker.address.city()
  ) -> MyProfileCellModel {
    return MyProfileCellModel(name: name,
                              city: city,
                              imageUrl: imageUrl)
  }
}

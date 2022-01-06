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
  
  static func userProfileBrief(
    name: String = Faker.name.findName(),
    imageUrl: String = Faker.image.imageUrl(),
    city: String = Faker.address.city()
  ) -> UserProfileBrief {
    return UserProfileBrief(name: name,
                            city: city,
                            imageUrl: imageUrl)
  }
  
  static func itemListElement(
    id: String = Faker.datatype.id(),
    title: String = Faker.lorem.sentenece(),
    city: String = Faker.address.city(),
    price: String = String(Faker.datatype.int()),
    imageUrl: String = Faker.image.imageUrl(),
    modifiedAt: Date = Date()
  ) -> ItemListElement {
    return ItemListElement(id: id,
                           title: title,
                           city: city,
                           price: price,
                           imageUrl: imageUrl,
                           modifiedAt: modifiedAt)
  }
  
  static func recentMessage(
    id: String = Faker.datatype.id(),
    userId: String = Faker.datatype.id(),
    itemId: String = Faker.datatype.id(),
    name: String = Faker.name.findName(),
    text: String = Faker.lorem.sentenece(),
    date: Date = Date()
  ) -> RecentMessage {
    return RecentMessage(id: id,
                         userId: userId,
                         itemId: itemId,
                         name: name,
                         text: text,
                         date: date)
  }
  
  static func itemActionPanel(
    id: String = Faker.datatype.id(),
    sellerId: String = Faker.datatype.id(),
    price: String = String(Faker.datatype.int())
  ) -> ItemActionPanel {
    return ItemActionPanel(id: id,
                           sellerId: sellerId,
                           price: price)
  }
}

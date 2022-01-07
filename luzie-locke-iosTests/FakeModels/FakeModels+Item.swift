//
//  FakeModels+Item.swift
//  luzie-locke-iosTests
//
//  Created by Harry on 07.01.22.
//

import Foundation

@testable import luzie_locke_ios

extension FakeModels {
  
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
  
  static func itemDisplay(
    userName: String = Faker.name.findName(),
    userImageUrl: String = Faker.image.imageUrl(),
    location: String = Faker.address.city(),
    title: String =  Faker.lorem.sentenece(),
    description: String = Faker.lorem.sentenece(),
    imageUrls: [String?] = Faker.image.imageUrls()
  ) -> ItemDisplay {
    return ItemDisplay(userName: userName,
                       userImageUrl: userImageUrl,
                       location: location,
                       title: title,
                       description: description,
                       imageUrls: imageUrls)
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

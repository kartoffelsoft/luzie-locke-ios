//
//  FakeModels+Message.swift
//  luzie-locke-iosTests
//
//  Created by Harry on 08.01.22.
//

import Foundation

@testable import luzie_locke_ios

extension FakeModels {
  
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
}

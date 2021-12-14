//
//  ItemListReadResponse.swift
//  luzie-locke-ios
//
//  Created by Harry on 13.12.21.
//

import Foundation

struct ItemListReadResponse: Decodable {
  let list: [ItemListElementDTO]
  let nextCursor: Double
}

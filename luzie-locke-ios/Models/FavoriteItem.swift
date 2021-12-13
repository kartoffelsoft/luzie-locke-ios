//
//  FavoriteItem.swift
//  luzie-locke-ios
//
//  Created by Harry on 13.12.21.
//

import Foundation

struct FavoriteItem {
  
  let id:         String
  let user:       String
  let item:       String
  let createdAt:  Date?
  
  init?(dto: FavoriteItemDTO?) {
    guard let dto = dto else { return nil }
    
    self.id         = dto.id
    self.user       = dto.user
    self.item       = dto.item
    self.createdAt  = Date(timeIntervalSince1970: dto.createdAt / 1000)

  }
}

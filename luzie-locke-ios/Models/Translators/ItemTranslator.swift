//
//  ItemTranslator.swift
//  luzie-locke-ios
//
//  Created by Harry on 01.11.21.
//

import Foundation

class ItemTranslator {
  
  static func translateItemDTOToItem(dto: ItemDTO) -> Item {
    return Item(id: dto.id,
                user: UserProfile(id: dto.user?.id,
                                  name: dto.user?.name,
                                  email: dto.user?.email,
                                  reputation: dto.user?.reputation,
                                  imageUrl: dto.user?.imageUrl,
                                  city: dto.user?.city,
                                  location: UserProfile.Location(
                                    type: dto.user?.location?.type,
                                    coordinates: dto.user?.location?.coordinates)),
                title: dto.title,
                price: dto.price,
                description: dto.description,
                imageUrls: dto.imageUrls,
                counts: Counts(chat: dto.counts?.chat, favorite: dto.counts?.favorite, view: dto.counts?.view),
                state: dto.state,
                createdAt: Date(timeIntervalSince1970: (dto.createdAt ?? 0) / 1000),
                modifiedAt: Date(timeIntervalSince1970: (dto.modifiedAt ?? 0) / 1000))
  }

  static func translateItemDTOListToItemList(dtoList: [ItemListElementDTO]) -> [ItemListElement] {
    return dtoList.reduce([ItemListElement](), { output, dto in
      guard let id          = dto.id            else { return output }
      guard let title       = dto.title         else { return output }
      guard let city        = dto.user?.city    else { return output }
      guard let price       = dto.price         else { return output }
      guard let imageUrl    = dto.imageUrls?[0] else { return output }
      guard let modifiedAt  = dto.modifiedAt    else { return output }
      
      let element = ItemListElement(id: id,
                                    title: title,
                                    city: city,
                                    price: price,
                                    imageUrl: imageUrl,
                                    modifiedAt: Date(timeIntervalSince1970: modifiedAt / 1000))
      
      return output + [element]
    })
  }
}

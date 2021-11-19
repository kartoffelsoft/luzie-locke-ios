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
                                  locationName: dto.user?.locationName,
                                  locationCoordinates: UserProfile.Coordinates(
                                    type: dto.user?.locationCoordinates?.type,
                                    coordinates: dto.user?.locationCoordinates?.coordinates)),
                title: dto.title,
                price: dto.price,
                description: dto.description,
                imageUrls: dto.imageUrls,
                counts: Counts(chat: dto.counts?.chat, favorite: dto.counts?.favorite, view: dto.counts?.view),
                state: dto.state,
                createdAt: dto.createdAt)
  }
}

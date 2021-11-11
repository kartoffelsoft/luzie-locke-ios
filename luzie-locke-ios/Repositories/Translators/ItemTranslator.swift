//
//  ItemTranslator.swift
//  luzie-locke-ios
//
//  Created by Harry on 01.11.21.
//

import Foundation

class ItemTranslator {
  static func translateItemDTOToItem(dto: ItemDTO) -> Item {
    return Item(_id: dto._id,
                user: UserProfile(_id: dto.user?._id,
                                  name: dto.user?.name,
                                  email: dto.user?.email,
                                  reputation: dto.user?.reputation,
                                  pictureURI: dto.user?.pictureURI,
                                  location: UserProfile.Location(
                                    name: dto.user?.location?.name,
                                    geoJSON: UserProfile.GeoJSON(
                                      type: dto.user?.location?.geoJSON?.type,
                                      coordinates: dto.user?.location?.geoJSON?.coordinates))),
                title: dto.title,
                price: dto.price,
                description: dto.description,
                images: dto.images,
                counts: Counts(chat: dto.counts?.chat, favorite: dto.counts?.favorite, view: dto.counts?.view),
                state: dto.state,
                createdAt: dto.createdAt)
  }
}

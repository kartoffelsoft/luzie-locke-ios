//
//  ItemActionPanelView.swift
//  luzie-locke-ios
//
//  Created by Harry on 02.11.21.
//

import UIKit

class ItemActionPanelViewModel {
  
  private let coordinator:            ItemDisplayCoordinator
  private let localProfileRepository: LocalProfileRepository
  
  let bindablePriceText = Bindable<NSAttributedString>()
  
  var item: Item? {
    didSet {
      if let item = item, let price = item.price {
        let priceText = NSMutableAttributedString(string: "€ ", attributes: [.font: Fonts.title])
        priceText.append(NSAttributedString(string: price, attributes: [.font: Fonts.titleLarge]))
        bindablePriceText.value = priceText
      }
    }
  }
  
  init(coordinator: ItemDisplayCoordinator, localProfileRepository: LocalProfileRepository) {
    self.coordinator            = coordinator
    self.localProfileRepository = localProfileRepository
  }
  
  func didTapChatButton() {
    print("Chat")
    guard let remoteUserId = item?.user?._id else { return }
    print(remoteUserId)
    coordinator.navigateToChat(remoteUserId: remoteUserId)
  }
  
  func didTapFavoriteButton() {
    print("Favorite")
  }
}

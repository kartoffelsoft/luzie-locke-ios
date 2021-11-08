//
//  ItemActionPanelView.swift
//  luzie-locke-ios
//
//  Created by Harry on 02.11.21.
//

import UIKit

class ItemActionPanelViewModel {
  
  private let coordinator:    ItemDisplayCoordinator
  private let profileStorage: AnyStorage<User>
  
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
  
  init(coordinator: ItemDisplayCoordinator, profileStorage: AnyStorage<User>) {
    self.coordinator = coordinator
    self.profileStorage = profileStorage
  }
  
  func didTapChatButton() {
    print("Chat")
    coordinator.navigateToChat()
  }
  
  func didTapFavoriteButton() {
    print("Favorite")
  }
}

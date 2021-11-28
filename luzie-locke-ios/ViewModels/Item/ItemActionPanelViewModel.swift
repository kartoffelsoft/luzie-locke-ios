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
  let bindableIsMine    = Bindable<Bool>()
  
  var item: Item? {
    didSet {
      guard let price = item?.price else { return }
      guard let sellerId  = item?.user?.id else { return }
      guard let localUserId  = localProfileRepository.read()?.id else { return }
      
      let priceText = NSMutableAttributedString(string: "€ ", attributes: [.font: Fonts.title])
      priceText.append(NSAttributedString(string: price, attributes: [.font: Fonts.titleLarge]))
      bindablePriceText.value = priceText

      bindableIsMine.value = (sellerId == localUserId)
    }
  }
  
  init(coordinator: ItemDisplayCoordinator, localProfileRepository: LocalProfileRepository) {
    self.coordinator            = coordinator
    self.localProfileRepository = localProfileRepository
  }
  
  func didTapFavoriteButton() {

  }
  
  func didTapChatButton() {
    guard let remoteUserId = item?.user?.id else { return }
    coordinator.navigateToChat(remoteUserId: remoteUserId)
  }

  func didTapEditButton() {
    print("Edit")
  }
}

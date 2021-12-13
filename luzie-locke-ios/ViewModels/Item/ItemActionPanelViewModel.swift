//
//  ItemActionPanelView.swift
//  luzie-locke-ios
//
//  Created by Harry on 02.11.21.
//

import UIKit

class ItemActionPanelViewModel {
  
  private let coordinator:          ItemDisplayCoordinator
  private let myProfileUseCase:     MyProfileUseCaseProtocol
  private let favoriteItemUseCase:  FavoriteItemUseCaseProtocol
  
  let bindablePriceText   = Bindable<NSAttributedString>()
  let bindableIsMine      = Bindable<Bool>()
  let bindableFavoriteOn  = Bindable<Bool>()
  
  var item: Item? {
    didSet {
      guard let itemId    = item?.id else { return }
      guard let price     = item?.price else { return }
      guard let sellerId  = item?.user?.id else { return }
      guard let userId    = myProfileUseCase.getId() else { return }
      
      let priceText = NSMutableAttributedString(string: "€ ", attributes: [.font: CustomUIFonts.title])
      priceText.append(NSAttributedString(string: price, attributes: [.font: CustomUIFonts.titleLarge]))
      bindablePriceText.value = priceText

      bindableIsMine.value = (sellerId == userId)
      
      favoriteItemUseCase.isAdded(itemId: itemId) { [weak self] result in
        guard let self = self else { return }

        switch result {
        case .success(let isAdded):
          self.bindableFavoriteOn.value = isAdded
          
        case .failure(let error):
          print("[Error:\(#file):\(#line)] \(error)")
          self.bindableFavoriteOn.value = false
        }
      }
    }
  }
  
  init(coordinator:           ItemDisplayCoordinator,
       myProfileUseCase:      MyProfileUseCaseProtocol,
       favoriteItemUseCase:   FavoriteItemUseCaseProtocol) {
    self.coordinator          = coordinator
    self.myProfileUseCase     = myProfileUseCase
    self.favoriteItemUseCase  = favoriteItemUseCase
  }
  
  func didTapFavoriteButton() {
    guard let itemId = item?.id else { return }
    guard let favoriteOn = bindableFavoriteOn.value  else { return }
    
    if favoriteOn {
      favoriteItemUseCase.remove(itemId: itemId) { [weak self] result in
        switch result {
        case .success:
          self?.bindableFavoriteOn.value = false
        case .failure(let error):
          print("[Error:\(#file):\(#line)] \(error)")
        }
      }
    } else {
      favoriteItemUseCase.add(itemId: itemId) { [weak self] result in
        switch result {
        case .success:
          self?.bindableFavoriteOn.value = true
        case .failure(let error):
          print("[Error:\(#file):\(#line)] \(error)")
        }
      }
    }
  }
  
  func didTapChatButton() {
    guard let remoteUserId  = item?.user?.id else { return }
    guard let itemId        = item?.id       else { return }
    coordinator.navigateToChat(remoteUserId: remoteUserId, itemId: itemId)
  }

  func didTapEditButton() {
    guard let item = item else { return }
    coordinator.navigateToItemUpdate(item: item)
  }
}

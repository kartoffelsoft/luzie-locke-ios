//
//  ItemActionPanelView.swift
//  luzie-locke-ios
//
//  Created by Harry on 02.11.21.
//

import UIKit

class ItemActionPanelViewModel {
  
  private let coordinator:              ItemDisplayCoordinatorProtocol
  private let myProfileUseCase:         MyProfileUseCaseProtocol
  private let userFavoriteItemUseCase:  UserFavoriteItemUseCaseProtocol
  
  let bindablePriceText   = Bindable<String>()
  let bindableIsMine      = Bindable<Bool>()
  let bindableFavoriteOn  = Bindable<Bool>()
  
  var model: ItemActionPanel? {
    didSet {
      guard let model = model else { return }
      let itemId    = model.id
      let price     = model.price
      let sellerId  = model.sellerId
      let userId    = myProfileUseCase.getId()
      
      bindablePriceText.value = price
      bindableIsMine.value    = (sellerId == userId)
      
      userFavoriteItemUseCase.isAdded(itemId: itemId) { [weak self] result in
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
  
  init(coordinator:               ItemDisplayCoordinatorProtocol,
       myProfileUseCase:          MyProfileUseCaseProtocol,
       userFavoriteItemUseCase:   UserFavoriteItemUseCaseProtocol) {
    self.coordinator              = coordinator
    self.myProfileUseCase         = myProfileUseCase
    self.userFavoriteItemUseCase  = userFavoriteItemUseCase
  }
  
  func didTapFavoriteButton() {
    guard let itemId = model?.id else { return }
    guard let favoriteOn = bindableFavoriteOn.value  else { return }
    
    if favoriteOn {
      userFavoriteItemUseCase.remove(itemId: itemId) { [weak self] result in
        switch result {
        case .success:
          self?.bindableFavoriteOn.value = false
        case .failure(let error):
          print("[Error:\(#file):\(#line)] \(error)")
        }
      }
    } else {
      userFavoriteItemUseCase.add(itemId: itemId) { [weak self] result in
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
    guard let remoteUserId  = model?.sellerId else { return }
    guard let itemId        = model?.id       else { return }
    coordinator.navigateToChat(remoteUserId: remoteUserId, itemId: itemId)
  }

  func didTapEditButton() {
    guard let model = model else { return }
    coordinator.navigateToItemUpdate(itemId: model.id)
  }
}

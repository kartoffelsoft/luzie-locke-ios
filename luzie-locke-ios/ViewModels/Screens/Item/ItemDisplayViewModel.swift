//
//  ItemDisplayViewModel.swift
//  luzie-locke-ios
//
//  Created by Harry on 01.11.21.
//

import UIKit

protocol ItemDisplayViewModelDelegate: AnyObject {
  
  func didGetError(_ error: LLError)
}

class ItemDisplayViewModel {
  
  weak var delegate:                  ItemDisplayViewModelDelegate?
  
  private let coordinator:            ItemDisplayCoordinator
  private let openHttpClient:         OpenHTTP
  private let itemRepository:         ItemRepositoryProtocol
  private let favoriteItemRepository: FavoriteItemRepositoryProtocol
  private let id:                     String
  
  var bindableIsLoading = Bindable<Bool>()
  let bindablePriceText = Bindable<NSAttributedString>()
  
  let itemDisplayBriefViewModel: ItemDisplayBriefViewModel
  let itemActionPanelViewModel:  ItemActionPanelViewModel
  
  var item: Item? {
    didSet {
      itemActionPanelViewModel.item = item
      itemDisplayBriefViewModel.item = item
      
      if let item = item, let price = item.price {
        let priceText = NSMutableAttributedString(string: "€ ", attributes: [.font: CustomUIFonts.title])
        priceText.append(NSAttributedString(string: price, attributes: [.font: CustomUIFonts.titleLarge]))
        bindablePriceText.value = priceText
      }
    }
  }
  
  init(coordinator:             ItemDisplayCoordinator,
       localProfileRepository:  LocalProfileRepository,
       openHttpClient:          OpenHTTP,
       itemRepository:          ItemRepositoryProtocol,
       favoriteItemRepository:  FavoriteItemRepositoryProtocol,
       id:                      String) {
    self.coordinator            = coordinator
    self.openHttpClient         = openHttpClient
    self.itemRepository         = itemRepository
    self.favoriteItemRepository = favoriteItemRepository
    self.id                     = id
    
    itemDisplayBriefViewModel = ItemDisplayBriefViewModel(coordinator: coordinator, openHttpClient: openHttpClient)
    itemActionPanelViewModel  = ItemActionPanelViewModel(coordinator: coordinator,
                                                         localProfileRepository: localProfileRepository,
                                                         favoriteItemRepository: favoriteItemRepository)
  }
  
  func viewDidLoad() {
    itemRepository.read(id) { [weak self] result in
      guard let self = self else { return }
      switch result {
      case .success(let item):
        self.item = item

      case .failure(let error):
        self.delegate?.didGetError(error)
      }
    }
  }
  
  func didTapDeleteButton() {
    guard let item = item else { return }
    itemRepository.delete(id, imageUrls: item.imageUrls) { [weak self] result in
      guard let self = self else { return }
      switch result {
      case .success():
        self.coordinator.popViewController()
        NotificationCenter.default.post(name: .didRequireItemListRefresh, object: nil)
      case .failure(let error):
        self.delegate?.didGetError(error)
      }
    }
  }
}

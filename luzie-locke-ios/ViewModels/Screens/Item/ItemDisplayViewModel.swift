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
  private let itemRepository:         ItemRepositoryProtocol
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
       myProfileUseCase:        MyProfileUseCase,
       openHttpClient:          OpenHTTP,
       itemRepository:          ItemRepositoryProtocol,
       userFavoriteItemUseCase: UserFavoriteItemUseCaseProtocol,
       id:                      String) {
    self.coordinator            = coordinator
    self.itemRepository         = itemRepository
    self.id                     = id
    
    itemDisplayBriefViewModel = ItemDisplayBriefViewModel(coordinator: coordinator, openHttpClient: openHttpClient)
    itemActionPanelViewModel  = ItemActionPanelViewModel(coordinator: coordinator,
                                                         myProfileUseCase: myProfileUseCase,
                                                         userFavoriteItemUseCase: userFavoriteItemUseCase)
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
        NotificationCenter.default.post(name: .didUpdateItem, object: nil)
      case .failure(let error):
        self.delegate?.didGetError(error)
      }
    }
  }
}

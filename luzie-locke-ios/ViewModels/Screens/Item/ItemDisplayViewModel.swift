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
  
  weak var delegate:                ItemDisplayViewModelDelegate?
  
  private let coordinator:          ItemDisplayCoordinator
  private let openHttpClient:       OpenHTTP
  private let itemRepository:       ItemRepositoryProtocol
  private let id:                   String
  
  var bindableIsLoading = Bindable<Bool>()
  let bindablePriceText = Bindable<NSAttributedString>()
  
  let itemDisplayBriefViewModel: ItemDisplayBriefViewModel
  let itemActionPanelViewModel:  ItemActionPanelViewModel
  
  var item: Item? {
    didSet {
      itemActionPanelViewModel.item = item
      itemDisplayBriefViewModel.item = item
      
      if let item = item, let price = item.price {
        let priceText = NSMutableAttributedString(string: "€ ", attributes: [.font: Fonts.title])
        priceText.append(NSAttributedString(string: price, attributes: [.font: Fonts.titleLarge]))
        bindablePriceText.value = priceText
      }
    }
  }
  
  init(coordinator:             ItemDisplayCoordinator,
       localProfileRepository:  LocalProfileRepository,
       openHttpClient:          OpenHTTP,
       itemRepository:          ItemRepositoryProtocol,
       id:                      String) {
    self.coordinator            = coordinator
    self.openHttpClient         = openHttpClient
    self.itemRepository         = itemRepository
    self.id                     = id
    
    itemDisplayBriefViewModel = ItemDisplayBriefViewModel(coordinator: coordinator, openHttpClient: openHttpClient)
    itemActionPanelViewModel  = ItemActionPanelViewModel(coordinator: coordinator, localProfileRepository: localProfileRepository)
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
    itemRepository.delete(id) { [weak self] result in
      guard let self = self else { return }
      switch result {
      case .success():
        NotificationCenter.default.post(name: .didUpdateItemList, object: nil)
        self.coordinator.popViewController()
      case .failure(let error):
        self.delegate?.didGetError(error)
      }
    }
  }
}

//
//  ItemDisplayViewModel.swift
//  luzie-locke-ios
//
//  Created by Harry on 01.11.21.
//

import UIKit

class ItemDisplayViewModel {
  
  private let coordinator:          ItemDisplayCoordinator
  private let profileStorage:       AnyStorage<User>
  private let openHttpClient:       OpenHTTP
  private let itemRepository:       ItemRepositoryProtocol
  private let id:                   String
  
  var bindableIsLoading       = Bindable<Bool>()
  
  let itemDisplayBriefViewModel: ItemDisplayBriefViewModel
  let itemActionPanelViewModel:  ItemActionPanelViewModel
  
  var item: Item? {
    didSet {
      itemActionPanelViewModel.item = item
      itemDisplayBriefViewModel.item = item
    }
  }
  
  init(coordinator:         ItemDisplayCoordinator,
       profileStorage:      AnyStorage<User>,
       openHttpClient:      OpenHTTP,
       itemRepository:      ItemRepositoryProtocol,
       id:                  String) {
    self.coordinator        = coordinator
    self.profileStorage     = profileStorage
    self.openHttpClient     = openHttpClient
    self.itemRepository     = itemRepository
    self.id                 = id
    
    itemDisplayBriefViewModel = ItemDisplayBriefViewModel(coordinator: coordinator, openHttpClient: openHttpClient)
    itemActionPanelViewModel  = ItemActionPanelViewModel()
  }
  
  func viewDidLoad() {
    itemRepository.read(id) { [weak self] result in
      switch result {
      case .success(let item): ()
        self?.item = item

      case .failure(let error):
        print("Failed")
      }
    }
  }
}

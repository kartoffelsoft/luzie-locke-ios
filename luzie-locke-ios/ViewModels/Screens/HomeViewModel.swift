//
//  HomeViewModel.swift
//  luzie-locke-ios
//
//  Created by Harry on 25.10.21.
//

import UIKit

class HomeViewModel {
  
  let coordinator:          HomeCoordinator
  let openHttpClient:       OpenHTTP
  let itemRepository:       ItemRepositoryProtocol
  
  var bindableItems       = Bindable<[Item]>()
  var itemCellViewModels  = [ItemCellViewModel]()

  init(coordinator:         HomeCoordinator,
       openHttpClient:      OpenHTTP,
       itemRepository:      ItemRepositoryProtocol) {
    self.coordinator          = coordinator
    self.openHttpClient       = openHttpClient
    self.itemRepository       = itemRepository
  }
  
  func queryAllItems() {
    itemRepository.readListAll { result in
      switch result {
      case .success(let items):
        self.itemCellViewModels = items.reduce([ItemCellViewModel](), { output, item in
          let vm = ItemCellViewModel(openHttpClient: self.openHttpClient)
          vm.item = item
          return output + [vm]
        })
        
        self.bindableItems.value = items
      case .failure(let error):
        print("Failed")
      }
    }
  }
  
  func navigateToItemCreate() {
    coordinator.navigateToItemCreate()
  }
  
  func didSelectItemAt(indexPath: IndexPath) {
    if let item = bindableItems.value?[indexPath.row], let id = item._id {
      coordinator.navigateToItemDisplay(id: id)
    }
  }
}

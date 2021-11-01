//
//  HomeViewModel.swift
//  luzie-locke-ios
//
//  Created by Harry on 25.10.21.
//

import UIKit

class HomeViewModel {
  
  let coordinator:        HomeCoordinator
  let profileStorage:     AnyStorage<User>
  let openHttpClient:     OpenHTTP
  let itemRepository:     ItemRepository
  
  var bindableItems      = Bindable<[Item]>()
  var itemCellViewModels = [ItemCellViewModel]()

  init(coordinator:       HomeCoordinator,
       profileStorage:    AnyStorage<User>,
       openHttpClient:    OpenHTTP,
       itemRepository:    ItemRepository) {
    self.coordinator      = coordinator
    self.profileStorage   = profileStorage
    self.openHttpClient   = openHttpClient
    self.itemRepository   = itemRepository
  }
  
  func queryAllItems() {
    itemRepository.readListAll { result in
      switch result {
      case .success(let items):
        print("Success")
        print(items)

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
}

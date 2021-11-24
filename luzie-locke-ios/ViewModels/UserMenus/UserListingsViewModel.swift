//
//  UserListingsViewModel.swift
//  luzie-locke-ios
//
//  Created by Harry on 23.11.21.
//

import Foundation

protocol UserListingsViewModelDelegate: AnyObject {
  
  func didGetError(_ error: LLError)
}

class UserListingsViewModel {
  
  weak var delegate:        UserListingsViewModelDelegate?
  
  let coordinator:          SettingsCoordinator
  let openHttpClient:       OpenHTTP
  let itemRepository:       ItemRepositoryProtocol
  
  var bindableItems         = Bindable<[Item]>()
  var itemCellViewModels    = [ItemCellViewModel]()
  
  private var segment: Int = 0
  private var itemsDictionary                 = [String: Item]()
  private var itemCellViewModelsDictionary    = [String: ItemCellViewModel]()
  
  private var isLoading: Bool = false
  
  var cursor: TimeInterval = Date().timeIntervalSince1970 * 1000
  
  init(coordinator:         SettingsCoordinator,
       openHttpClient:      OpenHTTP,
       itemRepository:      ItemRepositoryProtocol) {
    self.coordinator          = coordinator
    self.openHttpClient       = openHttpClient
    self.itemRepository       = itemRepository
  }
  
  private func reload() {
    itemCellViewModels = Array(itemCellViewModelsDictionary.values).sorted(by: { v1, v2 in
      return v1.item!.modifiedAt!.compare(v2.item!.modifiedAt!) == .orderedDescending
    })
    
    bindableItems.value = Array(itemsDictionary.values).sorted(by: { m1, m2 in
      return m1.modifiedAt!.compare(m2.modifiedAt!) == .orderedDescending
    })
  }
  
  private func fetchList() {
    if isLoading || cursor == -1 {
      return
    }
    
    isLoading = true
    
    if segment == 0 {
      

    itemRepository.readListUserListings(cursor: cursor) { [weak self] result in
      guard let self = self else { return }
      self.isLoading = false
      
      switch result {
      case .success((let items, let nextCursor)):
        print(items)
        items.forEach { item in
          if let id = item.id {
            self.itemsDictionary[id] = item
            
            if let viewModel = self.itemCellViewModelsDictionary[id] {
              viewModel.item = item
            } else {
              let viewModel = ItemCellViewModel(openHttpClient: self.openHttpClient)
              viewModel.item = item
              self.itemCellViewModelsDictionary[id] = viewModel
            }
          }
        }
        
        self.cursor = nextCursor
        self.reload()
      case .failure(let error):
        self.delegate?.didGetError(error)
      }
    }
    } else {
      itemRepository.readListUserListingsClosed(cursor: cursor) { [weak self] result in
        guard let self = self else { return }
        self.isLoading = false
        
        switch result {
        case .success((let items, let nextCursor)):
          print(items)
          items.forEach { item in
            if let id = item.id {
              self.itemsDictionary[id] = item
              
              if let viewModel = self.itemCellViewModelsDictionary[id] {
                viewModel.item = item
              } else {
                let viewModel = ItemCellViewModel(openHttpClient: self.openHttpClient)
                viewModel.item = item
                self.itemCellViewModelsDictionary[id] = viewModel
              }
            }
          }
          
          self.cursor = nextCursor
          self.reload()
        case .failure(let error):
          self.delegate?.didGetError(error)
        }
      }
    }
  }
  
  func viewDidLoad() {
    cursor                        = Date().timeIntervalSince1970 * 1000
    itemsDictionary               = [String: Item]()
    itemCellViewModelsDictionary  = [String: ItemCellViewModel]()
    
    fetchList()
  }
  
  func viewDidScrollToTop() {
    cursor                        = Date().timeIntervalSince1970 * 1000
    itemsDictionary               = [String: Item]()
    itemCellViewModelsDictionary  = [String: ItemCellViewModel]()
    
    fetchList()
  }
  
  func viewDidScrollToBottom() {
    fetchList()
  }
  
  func didChangeSegment(segment: Int) {
    self.segment = segment
    
    cursor                        = Date().timeIntervalSince1970 * 1000
    itemsDictionary               = [String: Item]()
    itemCellViewModelsDictionary  = [String: ItemCellViewModel]()
    
    fetchList()
  }
  
  func didSelectItemAt(indexPath: IndexPath) {
    if let item = bindableItems.value?[indexPath.row], let id = item.id {
      coordinator.navigateToItemDisplay(id: id)
    }
  }
}


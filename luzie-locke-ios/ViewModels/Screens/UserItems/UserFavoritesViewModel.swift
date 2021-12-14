//
//  UserFavoritesViewModel.swift
//  luzie-locke-ios
//
//  Created by Harry on 25.11.21.
//

import Foundation

protocol UserFavoritesViewModelDelegate: AnyObject {
  
  func didGetError(_ error: LLError)
}

class UserFavoritesViewModel {
  
  weak var delegate:        UserFavoritesViewModelDelegate?
  
  let coordinator:              SettingsCoordinator
  let userFavoriteItemUseCase:  UserFavoriteItemUseCaseProtocol
  let imageUseCase:             ImageUseCaseProtocol
  let itemRepository:           ItemRepositoryProtocol
  
  var bindableItems         = Bindable<[Item]>()
  var itemCellViewModels    = [ItemCellViewModel]()
  
  private var itemsDictionary                 = [String: Item]()
  private var itemCellViewModelsDictionary    = [String: ItemCellViewModel]()
  
  private var isLoading: Bool = false
  
  var cursor: TimeInterval = Date().timeIntervalSince1970 * 1000
  
  init(coordinator:               SettingsCoordinator,
       userFavoriteItemUseCase:   UserFavoriteItemUseCaseProtocol,
       imageUseCase:              ImageUseCaseProtocol,
       itemRepository:            ItemRepositoryProtocol) {
    self.coordinator              = coordinator
    self.userFavoriteItemUseCase  = userFavoriteItemUseCase
    self.imageUseCase             = imageUseCase
    self.itemRepository           = itemRepository
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
    
    userFavoriteItemUseCase.getMyList(cursor: cursor) { [weak self] result in
      guard let self = self else { return }
      self.isLoading = false
      
      switch result {
      case .success((let items, let nextCursor)):
        items.forEach { item in
          if let id = item.id {
            self.itemsDictionary[id] = item
            
            if let viewModel = self.itemCellViewModelsDictionary[id] {
              viewModel.item = item
            } else {
              let viewModel = ItemCellViewModel(imageUseCase: self.imageUseCase)
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
  
  func didSelectItemAt(indexPath: IndexPath) {
    if let item = bindableItems.value?[indexPath.row], let id = item.id {
      coordinator.navigateToItemDisplay(id: id)
    }
  }
}


//
//  ItemSearchViewModel.swift
//  luzie-locke-ios
//
//  Created by Harry on 22.11.21.
//

import UIKit

protocol ItemSearchViewModelDelegate: AnyObject {
  func didGetError(_ error: LLError)
}

class ItemSearchViewModel {
  
  weak var delegate:        ItemSearchViewModelDelegate?
  
  let coordinator:          ItemSearchCoordinator
  let imageUseCase:         ImageUseCaseProtocol
  let itemRepository:       ItemRepositoryProtocol
  
  var bindableItems         = Bindable<[ItemListElement]>()
  var itemCellViewModels    = [ItemCellViewModel]()
  
  private var itemsDictionary                 = [String: ItemListElement]()
  private var itemCellViewModelsDictionary    = [String: ItemCellViewModel]()
  
  private var isLoading: Bool = false
  
  private var cursor: TimeInterval = Date().timeIntervalSince1970 * 1000
  private var searchKeyword: String = ""
  
  init(coordinator:           ItemSearchCoordinator,
       imageUseCase:          ImageUseCaseProtocol,
       itemRepository:        ItemRepositoryProtocol) {
    self.coordinator          = coordinator
    self.imageUseCase         = imageUseCase
    self.itemRepository       = itemRepository
  }
  
  private func reload() {
    itemCellViewModels = Array(itemCellViewModelsDictionary.values).sorted(by: { v1, v2 in
      return v1.model!.modifiedAt.compare(v2.model!.modifiedAt) == .orderedDescending
    })
    
    bindableItems.value = Array(itemsDictionary.values).sorted(by: { m1, m2 in
      return m1.modifiedAt.compare(m2.modifiedAt) == .orderedDescending
    })
  }
  
  private func fetchList() {
    if isLoading || cursor == -1 {
      return
    }
    
    isLoading = true
    
    itemRepository.readListSearch(keyword: searchKeyword, cursor: cursor) { [weak self] result in
      guard let self = self else { return }
      self.isLoading = false
      
      switch result {
      case .success((let items, let nextCursor)):
        items.forEach { item in
          self.itemsDictionary[item.id] = item

          if let viewModel = self.itemCellViewModelsDictionary[item.id] {
            viewModel.model = item
          } else {
            let viewModel = ItemCellViewModel(imageUseCase: self.imageUseCase)
            viewModel.model = item
            self.itemCellViewModelsDictionary[item.id] = viewModel
          }
        }
        
        self.cursor = nextCursor
        self.reload()
      case .failure(let error):
        self.delegate?.didGetError(error)
      }
    }
  }
  
  func viewDidSetSearchKeyword(_ keyword: String) {
    searchKeyword                 = keyword
    cursor                        = Date().timeIntervalSince1970 * 1000
    itemsDictionary               = [String: ItemListElement]()
    itemCellViewModelsDictionary  = [String: ItemCellViewModel]()
    
    if searchKeyword.isEmpty || searchKeyword.count < 2{
      reload()
      return
    }
    
    fetchList()
  }
  
  func viewDidScrollToBottom() {
    fetchList()
  }
  
  func didSelectItemAt(indexPath: IndexPath) {
    if let item = bindableItems.value?[indexPath.row] {
      coordinator.navigateToItemDisplay(id: item.id)
    }
  }
}

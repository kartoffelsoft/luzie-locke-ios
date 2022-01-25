//
//  OpenItemsViewModel.swift
//  luzie-locke-ios
//
//  Created by Harry on 24.01.22.
//

import Foundation
import Combine

protocol OpenItemsViewModelDelegate: AnyObject {
  
  func didGetError(_ error: LLError)
}

class OpenItemsViewModel {

  weak var delegate: OpenItemsViewModelDelegate?
  
  let coordinator: SettingsCoordinator
  let imageUseCase: ImageUseCaseProtocol
  let userOpenItemUseCase: UserOpenItemUseCaseProtocol
  
  var observableItems = CurrentValueSubject<[ItemListElement], Never>([])
  var itemCellViewModels = [ItemCellViewModel]()
  
  private var itemsDictionary = [String: ItemListElement]()
  private var itemCellViewModelsDictionary = [String: ItemCellViewModel]()
  
  private var isLoading: Bool = false
  
  var cursor: TimeInterval = Date().timeIntervalSince1970 * 1000
  
  init(coordinator:           SettingsCoordinator,
       imageUseCase:          ImageUseCaseProtocol,
       userOpenItemUseCase:   UserOpenItemUseCaseProtocol) {
    self.coordinator          = coordinator
    self.imageUseCase         = imageUseCase
    self.userOpenItemUseCase  = userOpenItemUseCase
  }
  
  private func reload() {
    itemCellViewModels = Array(itemCellViewModelsDictionary.values).sorted(by: { v1, v2 in
      return v1.model!.modifiedAt.compare(v2.model!.modifiedAt) == .orderedDescending
    })
    
    observableItems.send(Array(itemsDictionary.values).sorted(by: { m1, m2 in
      return m1.modifiedAt.compare(m2.modifiedAt) == .orderedDescending
    }))
  }
  
  private func fetchList() {
    if isLoading || cursor == -1 {
      return
    }
    
    isLoading = true
    
    userOpenItemUseCase.getItemList(cursor: cursor) { [weak self] result in
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
        ()
//        self.delegate?.didGetError(error)
      }
    }
  }
  
  func viewDidLoad() {
    cursor                        = Date().timeIntervalSince1970 * 1000
    itemsDictionary               = [String: ItemListElement]()
    itemCellViewModelsDictionary  = [String: ItemCellViewModel]()
    
    fetchList()
  }
  
  func viewDidScrollToTop() {
    cursor                        = Date().timeIntervalSince1970 * 1000
    itemsDictionary               = [String: ItemListElement]()
    itemCellViewModelsDictionary  = [String: ItemCellViewModel]()
    
    fetchList()
  }
  
  func viewDidScrollToBottom() {
    fetchList()
  }
  
  func didSelectItemAt(indexPath: IndexPath) {
    coordinator.navigateToItemDisplay(itemId: observableItems.value[indexPath.row].id)
  }
}


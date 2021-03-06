//
//  UserPurchasesViewModel.swift
//  luzie-locke-ios
//
//  Created by Harry on 24.11.21.
//

import Foundation

protocol UserPurchasesViewModelDelegate: AnyObject {
  
  func didGetError(_ error: LLError)
}

class UserPurchasesViewModel {
  
  weak var delegate: UserPurchasesViewModelDelegate?
  
  private let coordinator:            SettingsCoordinator
  private let imageUseCase:           ImageUseCaseProtocol
  private let userBoughtItemUseCase:  UserBoughtItemUseCaseProtocol
  
  var bindableItems       = Bindable<[ItemListElement]>()
  var itemCellViewModels  = [ItemCellViewModel]()
  
  private var itemsDictionary              = [String: ItemListElement]()
  private var itemCellViewModelsDictionary = [String: ItemCellViewModel]()
  
  private var isLoading: Bool = false
  
  var cursor: TimeInterval = Date().timeIntervalSince1970 * 1000
  
  init(coordinator:             SettingsCoordinator,
       imageUseCase:            ImageUseCaseProtocol,
       userBoughtItemUseCase:   UserBoughtItemUseCaseProtocol) {
    self.coordinator            = coordinator
    self.imageUseCase           = imageUseCase
    self.userBoughtItemUseCase  = userBoughtItemUseCase
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
    
    userBoughtItemUseCase.getItemList(cursor: cursor) { [weak self] result in
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
    if let item = bindableItems.value?[indexPath.row] {
      coordinator.navigateToItemDisplay(itemId: item.id)
    }
  }
}


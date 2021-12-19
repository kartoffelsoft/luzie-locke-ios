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
  let imageUseCase:         ImageUseCaseProtocol
  let userOpenItemUseCase:  UserOpenItemUseCaseProtocol
  let userSoldItemUseCase:  UserSoldItemUseCaseProtocol
  
  var bindableItems         = Bindable<[ItemListElement]>()
  var itemCellViewModels    = [ItemCellViewModel]()
  
  private var segment: Int = 0
  private var itemsDictionary                 = [String: ItemListElement]()
  private var itemCellViewModelsDictionary    = [String: ItemCellViewModel]()
  
  private var isLoading: Bool = false
  
  var cursor: TimeInterval = Date().timeIntervalSince1970 * 1000
  
  init(coordinator:           SettingsCoordinator,
       imageUseCase:          ImageUseCaseProtocol,
       userOpenItemUseCase:   UserOpenItemUseCaseProtocol,
       userSoldItemUseCase:   UserSoldItemUseCaseProtocol) {
    self.coordinator          = coordinator
    self.imageUseCase         = imageUseCase
    self.userOpenItemUseCase  = userOpenItemUseCase
    self.userSoldItemUseCase  = userSoldItemUseCase
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
    
    let readList: (TimeInterval, @escaping (Result<(Array<ItemListElement>, Double), LLError>) -> ()) -> () = segment == 0 ? userOpenItemUseCase.getItemList : userSoldItemUseCase.getItemList

    readList(cursor) { [weak self] result in
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
  
  func didChangeSegment(segment: Int) {
    self.segment = segment
    
    cursor                        = Date().timeIntervalSince1970 * 1000
    itemsDictionary               = [String: ItemListElement]()
    itemCellViewModelsDictionary  = [String: ItemCellViewModel]()
    
    fetchList()
  }
  
  func didSelectItemAt(indexPath: IndexPath) {
    if let item = bindableItems.value?[indexPath.row] {
      coordinator.navigateToItemDisplay(id: item.id)
    }
  }
}


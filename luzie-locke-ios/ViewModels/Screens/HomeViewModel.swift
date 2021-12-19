//
//  HomeViewModel.swift
//  luzie-locke-ios
//
//  Created by Harry on 25.10.21.
//

import UIKit

protocol HomeViewModelDelegate: AnyObject {
  
  func didGetError(_ error: LLError)
}

class HomeViewModel {
  
  weak var delegate:            HomeViewModelDelegate?
  
  private let coordinator:      HomeCoordinator
  private let myProfileUseCase: MyProfileUseCaseProtocol
  private let imageUseCase:     ImageUseCaseProtocol
  private let itemRepository:   ItemRepositoryProtocol
  
  var itemCellViewModels        = [ItemCellViewModel]()
  
  var bindableItems             = Bindable<[Item]>()
  var bindableCityName          = Bindable<String>()
  
  private var isLoading                       = false
  private var itemsDictionary                 = [String: Item]()
  private var itemCellViewModelsDictionary    = [String: ItemCellViewModel]()
  
  var cursor: TimeInterval = Date().timeIntervalSince1970 * 1000

  init(coordinator:           HomeCoordinator,
       myProfileUseCase:      MyProfileUseCaseProtocol,
       imageUseCase:          ImageUseCaseProtocol,
       itemRepository:        ItemRepositoryProtocol) {
    self.coordinator          = coordinator
    self.myProfileUseCase     = myProfileUseCase
    self.imageUseCase         = imageUseCase
    self.itemRepository       = itemRepository
    
    bindableCityName.value = myProfileUseCase.getCity()
    
    NotificationCenter.default.addObserver(self, selector: #selector(handleRefreshRequest), name: .didUpdateItem, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(handleRefreshRequest), name: .didUpdateLocationSettings, object: nil)
  }
  
  private func loadData() {
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
    
    itemRepository.readListLocal(cursor: cursor) { [weak self] result in
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
        self.loadData()
      case .failure(let error):
        self.delegate?.didGetError(error)
      }
    }
  }
  
  private func refresh() {
    bindableCityName.value        = myProfileUseCase.getCity()
    cursor                        = Date().timeIntervalSince1970 * 1000
    itemsDictionary               = [String: Item]()
    itemCellViewModelsDictionary  = [String: ItemCellViewModel]()
    
    fetchList()
  }
  
  func viewDidLoad() {
    refresh()
  }
  
  func viewDidScrollToTop() {
    refresh()
  }
  
  func viewDidScrollToBottom() {
    fetchList()
  }
  
  func navigateToItemCreate() {
    coordinator.navigateToItemCreate()
  }
  
  func navigateToItemSearch() {
    coordinator.navigateToItemSearch()
  }
  
  func didSelectItemAt(indexPath: IndexPath) {
    if let item = bindableItems.value?[indexPath.row], let id = item.id {
      coordinator.navigateToItemDisplay(id: id)
    }
  }
  
  @objc private func handleRefreshRequest() {
    refresh()
  }
}

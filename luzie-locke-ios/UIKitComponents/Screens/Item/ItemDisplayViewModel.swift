//
//  ItemDisplayViewModel.swift
//  luzie-locke-ios
//
//  Created by Harry on 01.11.21.
//

import UIKit

protocol ItemDisplayViewModelDelegate: AnyObject {
  
  func didGetError(_ error: LLError)
}

class ItemDisplayViewModel {
  
  weak var delegate:          ItemDisplayViewModelDelegate?
  
  private let coordinator:    ItemDisplayCoordinator
  private let itemRepository: ItemRepositoryProtocol
  private let id:             String
  
  var bindableIsLoading = Bindable<Bool>()
  
  let itemDisplayBriefViewModel: ItemDisplayBriefViewModel
  let itemActionPanelViewModel:  ItemActionPanelViewModel
  
  var item: Item? {
    didSet {
      guard let item = item else { return }
      itemActionPanelViewModel.model = ItemActionPanel(id: item.id ?? "",
                                                       sellerId: item.user?.id ?? "" ,
                                                       price: item.price ?? "")
      itemDisplayBriefViewModel.model = ItemDisplay(userName: item.user?.name ?? "",
                                                    userImageUrl: item.user?.imageUrl ?? "",
                                                    location: item.user?.city ?? "",
                                                    title: item.title ?? "",
                                                    description: item.description ?? "",
                                                    imageUrls: item.imageUrls ?? [String]())
    }
  }
  
  init(coordinator:             ItemDisplayCoordinator,
       myProfileUseCase:        MyProfileUseCase,
       imageUseCase:            ImageUseCaseProtocol,
       itemRepository:          ItemRepositoryProtocol,
       userFavoriteItemUseCase: UserFavoriteItemUseCaseProtocol,
       id:                      String) {
    self.coordinator            = coordinator
    self.itemRepository         = itemRepository
    self.id                     = id
    
    itemDisplayBriefViewModel = ItemDisplayBriefViewModel(coordinator: coordinator, imageUseCase: imageUseCase)
    itemActionPanelViewModel  = ItemActionPanelViewModel(coordinator: coordinator,
                                                         myProfileUseCase: myProfileUseCase,
                                                         userFavoriteItemUseCase: userFavoriteItemUseCase)
  }
  
  func viewDidLoad() {
    itemRepository.read(id) { [weak self] result in
      guard let self = self else { return }
      switch result {
      case .success(let item):
        self.item = item

      case .failure(let error):
        self.delegate?.didGetError(error)
      }
    }
  }
  
  func didTapDeleteButton() {
    guard let item = item else { return }
    itemRepository.delete(id, imageUrls: item.imageUrls) { [weak self] result in
      guard let self = self else { return }
      switch result {
      case .success():
        self.coordinator.popViewController()
        NotificationCenter.default.post(name: .didUpdateItem, object: nil)
      case .failure(let error):
        self.delegate?.didGetError(error)
      }
    }
  }
}

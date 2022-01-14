//
//  MessageViewModel.swift
//  luzie-locke-ios
//
//  Created by Harry on 09.01.22.
//

import UIKit

class MessageViewModel {
  
  private let coordinator: CommunicationCoordinatorProtocol
  private let itemId: String
  private let imageUseCase: ImageUseCaseProtocol
  private let itemControlUseCase: ItemControlUseCaseProtocol
  
  var bindableItemImage = Bindable<UIImage>()
  var bindableStateText = Bindable<String>()
  var bindableTitleText = Bindable<String>()
  
  init(coordinator: CommunicationCoordinatorProtocol,
       itemId: String,
       imageUseCase: ImageUseCaseProtocol,
       itemControlUseCase: ItemControlUseCaseProtocol) {
    self.coordinator = coordinator
    self.itemId = itemId
    self.imageUseCase = imageUseCase
    self.itemControlUseCase = itemControlUseCase
  }
  
  func didLoad() {
    itemControlUseCase.getItem(itemId: itemId) { [weak self] result in
      guard let self = self else { return }
      
      switch(result) {
      case .success(let item):
        guard let title = item.title else { return }
        guard let state = item.state else { return }
        guard let imageUrl = item.imageUrls?[0] else { return }
        
        self.bindableTitleText.value = title
        self.bindableStateText.value = state == "sold" ? "SOLD" : ""
        self.configureItemImage(imageUrl: imageUrl)
        
      case .failure(let error):
        print(error)
      }
    }
  }
  
  func didTapItemView() {
    coordinator.navigateToItemDisplay(itemId: itemId)
  }
  
  private func configureItemImage(imageUrl: String) {
    self.imageUseCase.getImage(url: imageUrl, completion: { [weak self] result in
      switch result {
      case .success(let image):
        self?.bindableItemImage.value = image
      case .failure:
        ()
      }
    })
  }
}

//
//  ItemCreateViewModel.swift
//  luzie-locke-ios
//
//  Created by Harry on 29.10.21.
//

import UIKit

protocol ItemCreateViewModelDelegate: AnyObject {
  func didOpenImagePicker(controller: UIImagePickerController)
}

class ItemCreateViewModel {
  
  weak var delegate:          ItemCreateViewModelDelegate?
  
  let coordinator:            HomeCoordinator
  let itemRepository:         ItemRepository

  let imageSelectViewModel:   ImageSelectViewModel
  let titleViewModel:         InputViewModel
  let priceViewModel:         DecimalInputViewModel
  let descriptionViewModel:   InputViewModel
  
  var bindableIsLoading = Bindable<Bool>()
  
  init(coordinator:             HomeCoordinator,
       itemRepository:          ItemRepository) {
    self.coordinator            = coordinator
    self.itemRepository         = itemRepository
    
    imageSelectViewModel            = ImageSelectViewModel()
    titleViewModel                  = InputViewModel(placeholder: "Title")
    priceViewModel                  = DecimalInputViewModel(placeholder: "Price")
    descriptionViewModel            = InputViewModel(placeholder: "Description")
    
    imageSelectViewModel.onOpenImagePicker  = self.openImagePicker
  }
  
  private func validate() -> Result<Void, LLError> {
    
    if imageSelectViewModel.bindableImages.value?.count == 0 {
      return .failure(.photoNotSelected)
    }
    
    guard let title = titleViewModel.getText() else             { return .failure(.titleInvalid) }
    if title.count < 3                                          { return .failure(.titleInvalid) }

    guard let price = priceViewModel.getText() else             { return .failure(.priceInvalid) }
    if price.last == "."                                        { return .failure(.priceInvalid) }

    guard let description = descriptionViewModel.getText() else { return .failure(.descriptionInvalid) }
    if description.count < 3                                    { return .failure(.descriptionInvalid) }
    
    return .success(())
  }
  
  func upload(completion: @escaping (Result<Void, LLError>) -> Void) {
    switch validate() {
    case .success:
      bindableIsLoading.value = true
      
      guard let title = titleViewModel.getText(),
            let price = priceViewModel.getText(),
            let description = descriptionViewModel.getText(),
            let images = imageSelectViewModel.bindableImages.value
      else {
        return
      }
      
      itemRepository.create(title: title, price: price, description: description, images: images) { result in
        switch result {
        case .success:
          completion(.success(()))
          self.coordinator.popViewController()
          NotificationCenter.default.post(name: .didUpdateItemList, object: nil)
        case .failure(let error):
          completion(.failure(error))
        }
      }
    case .failure(let error):
      completion(.failure(error))
    }
  }
  
  private func openImagePicker(_ controller: UIImagePickerController) {
    delegate?.didOpenImagePicker(controller: controller)
  }
}

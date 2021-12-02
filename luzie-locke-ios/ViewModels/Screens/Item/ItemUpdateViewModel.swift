//
//  ItemUpdateViewModel.swift
//  luzie-locke-ios
//
//  Created by Harry on 02.12.21.
//

import UIKit

protocol ItemUpdateViewModelDelegate: AnyObject {
  func didOpenImagePicker(controller: UIImagePickerController)
  func didCloseImagePicker()
}

class ItemUpdateViewModel {
  
  weak var delegate:          ItemUpdateViewModelDelegate?
  
  private let coordinator:            ItemDisplayCoordinator
  private let openHttpClient:         OpenHTTP
  private let itemRepository:         ItemRepository
  
  var item: Item? {
    didSet {
      guard let item = item else { return }
      titleViewModel.setInitialText(item.title)
      priceViewModel.setInitialText(item.price)
      descriptionViewModel.setInitialText(item.description)
    }
  }

  let imageSelectViewModel:   ImageSelectViewModel
  let titleViewModel:         InputViewModel
  let priceViewModel:         DecimalInputViewModel
  let descriptionViewModel:   InputViewModel

  var bindableIsLoading = Bindable<Bool>()
  
  init(coordinator:         ItemDisplayCoordinator,
       openHttpClient:      OpenHTTP,
       itemRepository:      ItemRepository) {
    self.coordinator        = coordinator
    self.openHttpClient     = openHttpClient
    self.itemRepository     = itemRepository

    imageSelectViewModel            = ImageSelectViewModel()
    titleViewModel                  = InputViewModel(placeholder: "Title")
    priceViewModel                  = DecimalInputViewModel(placeholder: "Price")
    descriptionViewModel            = InputViewModel(placeholder: "Description")
    
    imageSelectViewModel.onOpenImagePicker  = self.openImagePicker
    imageSelectViewModel.onCloseImagePicker = self.closeImagePicker
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
  
  private func closeImagePicker() {
    delegate?.didCloseImagePicker()
  }
}

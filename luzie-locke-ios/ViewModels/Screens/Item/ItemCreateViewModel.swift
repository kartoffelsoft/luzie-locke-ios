//
//  ItemCreateViewModel.swift
//  luzie-locke-ios
//
//  Created by Harry on 29.10.21.
//

import UIKit

protocol ItemCreateViewModelDelegate: AnyObject {
  func didOpenImagePicker(controller: UIImagePickerController)
  func didCloseImagePicker()
}

class ItemCreateViewModel {
  
  weak var delegate:          ItemCreateViewModelDelegate?
  
  let coordinator:            HomeCoordinator
  let localProfileRepository: LocalProfileRepository
  let openHttpClient:         OpenHTTP
  let itemRepository:         ItemRepository

  let imageSelectViewModel:   ImageSelectViewModel
  let titleViewModel:         SingleLineTextInputViewModel
  let priceViewModel:         SingleLineDecimalInputViewModel
  let descriptionViewModel:   MultiLineTextInputViewModel
  
  var bindableIsLoading = Bindable<Bool>()
  
  init(coordinator:             HomeCoordinator,
       localProfileRepository:  LocalProfileRepository,
       openHttpClient:          OpenHTTP,
       itemRepository:          ItemRepository) {
    self.coordinator            = coordinator
    self.localProfileRepository = localProfileRepository
    self.openHttpClient         = openHttpClient
    self.itemRepository         = itemRepository
    
    imageSelectViewModel    = ImageSelectViewModel()
    titleViewModel          = SingleLineTextInputViewModel()
    priceViewModel          = SingleLineDecimalInputViewModel()
    descriptionViewModel    = MultiLineTextInputViewModel()
    
    imageSelectViewModel.onOpenImagePicker  = self.openImagePicker
    imageSelectViewModel.onCloseImagePicker = self.closeImagePicker
  }
  
  private func validate() -> Result<Void, LLError> {
    
    if imageSelectViewModel.bindableImages.value?.count == 0 {
      return .failure(.photoNotSelected)
    }
    
    guard let title = titleViewModel.text else             { return .failure(.titleInvalid) }
    if title.count < 3                                     { return .failure(.titleInvalid) }

    guard let price = priceViewModel.text else             { return .failure(.priceInvalid) }
    if price.last == "."                                   { return .failure(.priceInvalid) }

    guard let description = descriptionViewModel.text else { return .failure(.descriptionInvalid) }
    if description.count < 3                               { return .failure(.descriptionInvalid) }
    
    return .success(())
  }
  
  func upload(completion: @escaping (Result<Void, LLError>) -> Void) {
    switch validate() {
    case .success:
      bindableIsLoading.value = true
      executeBackendUpload { [weak self] result in
        guard let self = self else { return }
        self.bindableIsLoading.value = false
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

  private func executeBackendUpload(completion: @escaping (Result<Void, LLError>) -> Void) {
    if let title = titleViewModel.text,
       let price = priceViewModel.text,
       let description = descriptionViewModel.text,
       let images = imageSelectViewModel.bindableImages.value {
      itemRepository.create(title: title, price: price, description: description, images: images) { result in
        switch result {
        case .success:
          completion(.success(()))
        case .failure(let error):
          completion(.failure(error))
        }
      }
    } else {
      completion(.failure(.unableToComplete))
    }
  }
}

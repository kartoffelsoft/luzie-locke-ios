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
  
  weak var delegate:        ItemCreateViewModelDelegate?
  
  let coordinator:          HomeCoordinator
  let profileStorage:       AnyStorage<User>
  let cloudStorage:         CloudStorage
  let openHttpClient:       OpenHTTP
  let itemApiClient:        ItemAPI

  let imageSelectViewModel: ImageSelectCellViewModel
  let titleViewModel:       TextInputCellViewModel
  let priceViewModel:       DecimalInputCellViewModel
  let descriptionViewModel: TextInputCellViewModel
  
  var bindableIsLoading     = Bindable<Bool>()
  
  init(coordinator:         HomeCoordinator,
       profileStorage:      AnyStorage<User>,
       cloudStorage:        CloudStorage,
       openHttpClient:      OpenHTTP,
       itemApiClient:       ItemAPI) {
    self.coordinator        = coordinator
    self.profileStorage     = profileStorage
    self.cloudStorage       = cloudStorage
    self.openHttpClient     = openHttpClient
    self.itemApiClient      = itemApiClient
    
    imageSelectViewModel    = ImageSelectCellViewModel()
    titleViewModel          = TextInputCellViewModel()
    priceViewModel          = DecimalInputCellViewModel()
    descriptionViewModel    = TextInputCellViewModel()
    
    imageSelectViewModel.onOpenImagePicker  = self.openImagePicker
    imageSelectViewModel.onCloseImagePicker = self.closeImagePicker
  }
  
  private func validate() -> Result<Void, LLError> {
    
    if imageSelectViewModel.selectedImages[0] == nil &&
       imageSelectViewModel.selectedImages[1] == nil &&
       imageSelectViewModel.selectedImages[2] == nil {
      return .failure(.photoNotSelected)
    }
    
    guard let title = titleViewModel.text else             { return .failure(.titleInvalid) }
    if title.count < 3                                     { return .failure(.titleInvalid) }

    guard let price = priceViewModel.text else             { return .failure(.priceInvalid) }
    if price.last == "."                                   { return .failure(.priceInvalid)  }

    guard let description = descriptionViewModel.text else { return .failure(.descriptionInvalid) }
    if description.count < 3                               { return .failure(.descriptionInvalid) }
    
    return .success(())
  }
  
  func upload(completion: @escaping (Result<Void, LLError>) -> Void) {
    switch validate() {
    case .success:
      bindableIsLoading.value = true
      executeImageUpload { [weak self] result in
        switch result {
        case .success(let imageUrls):
          self?.executeBackendUpload(imageUrls: imageUrls, completion: { result in
            self?.bindableIsLoading.value = false
            switch result {
            case .success:
              completion(.success(()))
              self?.coordinator.popViewController()
            case .failure(let error):
              completion(.failure(error))
            }
          })
        case .failure(let error):
          self?.bindableIsLoading.value = false
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

  private func executeImageUpload(completion: @escaping (Result<[String?], LLError>) -> Void) {
    var imageUrls: [String?] = [ nil, nil, nil ]
    
    let dispatchGroup = DispatchGroup()

    for i in 0 ..< 3 {
      guard let image = imageSelectViewModel.selectedImages[i] else {
        imageUrls[i] = nil
        continue
      }
      
      dispatchGroup.enter()
      cloudStorage.uploadImage(image: image) { result in
        switch result {
        case .success(let url):
          imageUrls[i] = url
          dispatchGroup.leave()
        case .failure(let error):
          completion(.failure(error))
        }
      }
    }
  
    dispatchGroup.notify(queue: .main) {
      completion(.success(imageUrls))
    }
  }
  
  private func executeBackendUpload(imageUrls: [String?], completion: @escaping (Result<Void, LLError>) -> Void) {
    
    if let title = titleViewModel.text,
       let price = priceViewModel.text,
       let description = descriptionViewModel.text {
      
      itemApiClient.create(title: title, price: price, description: description, images: imageUrls) { result in
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

//
//  ItemUpdateViewModel.swift
//  luzie-locke-ios
//
//  Created by Harry on 02.12.21.
//

import UIKit

class ItemUpdateViewModel: ItemComposeViewModel {
  
  weak var delegate:          ItemComposeViewModelDelegate?
  
  private let coordinator:            ItemDisplayCoordinator
  private let openHttpClient:         OpenHTTP
  private let itemRepository:         ItemRepository
  
  var item: Item? {
    didSet {
      guard let item = item else { return }
      titleViewModel.setInitialText(item.title)
      priceViewModel.setInitialText(item.price)
      descriptionViewModel.setInitialText(item.description)
      
      if let urls = item.imageUrls {
        var images = [UIImage](repeating: UIImage(), count: urls.count)
        
        let dispatchGroup = DispatchGroup()

        for i in 0 ..< urls.count {
          guard let url = urls[i] else { continue }
          
          dispatchGroup.enter()
          
          openHttpClient.downloadImage(from: url) { result in
            switch result {
            case .success(let image):
              images[i] = image ?? UIImage()
              dispatchGroup.leave()
            case .failure:
              ()
            }
          }
        }
      
        dispatchGroup.notify(queue: .main) {
          self.imageSelectViewModel.setInitialImages(images: images)
        }
      }
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
            let images = imageSelectViewModel.bindableImages.value,
            let id = item?.id
      else {
        completion(.failure(.unableToComplete))
        return
      }

      itemRepository.update(id, title: title, price: price, description: description, images: images, oldImageUrls: item?.imageUrls) { result in
        switch result {
        case .success:
          completion(.success(()))
          self.coordinator.popToRootViewController()
          NotificationCenter.default.post(name: .didUpdateItem, object: nil)
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

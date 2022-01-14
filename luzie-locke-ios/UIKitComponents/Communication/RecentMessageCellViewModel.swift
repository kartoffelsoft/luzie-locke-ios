//
//  RecentMessageCellViewModel.swift
//  luzie-locke-ios
//
//  Created by Harry on 11.11.21.
//

import UIKit

class RecentMessageCellViewModel {

  var model: RecentMessage? {
    didSet {
      guard let model = model else { return }
      bindableNameText.value     = model.name
      bindableMessageText.value  = model.text
      bindableDateText.value     = DateUtility.string(from: model.date)
      
      downloadUserImage(from: model.userId)
      downloadItemImage(from: model.itemId)
    }
  }
  
  var bindableItemImage    = Bindable<UIImage>()
  var bindableUserImage    = Bindable<UIImage>()
  var bindableNameText     = Bindable<String>()
  var bindableMessageText  = Bindable<String>()
  var bindableDateText     = Bindable<String>()
  
  private let imageUseCase: ImageUseCaseProtocol

  init(imageUseCase: ImageUseCaseProtocol) {
    self.imageUseCase = imageUseCase
  }
  
  private func downloadUserImage(from userId: String?) {
    if let userId = userId {
      imageUseCase.getImage(userId: userId, completion: { [weak self] result in
        switch result {
        case .success(let image):
          self?.bindableUserImage.value = image
        case .failure:
          ()
        }
      })
    }
  }
  
  private func downloadItemImage(from itemId: String?) {
    if let itemId = itemId {
      imageUseCase.getImage(itemId: itemId, completion: { [weak self] result in
        switch result {
        case .success(let image):
          self?.bindableItemImage.value = image
        case .failure:
          ()
        }
      })
    }
  }
}

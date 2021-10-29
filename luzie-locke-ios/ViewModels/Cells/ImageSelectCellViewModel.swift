//
//  ImageSelectCellViewModel.swift
//  luzie-locke-ios
//
//  Created by Harry on 29.10.21.
//

import UIKit

class ImageSelectCellViewModel: NSObject {
  
  var selectedImages: [UIImage?] = [ nil, nil, nil ]
  
  var onOpenImagePicker: ((UIImagePickerController) -> Void)?
  var onCloseImagePicker: (() -> Void)?
  
  override init() {
  }
  
  func openImagePicker(button: UIButton) {
    let controller = ButtonImagePickerController()
    controller.delegate = self
    controller.button = button
    
    onOpenImagePicker?(controller)
  }
}

extension ImageSelectCellViewModel: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    let image = info[.originalImage] as? UIImage
    
    if let button = (picker as? ButtonImagePickerController)?.button {
      button.setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
      selectedImages[button.tag] = image
    }

    onCloseImagePicker?()
  }
}

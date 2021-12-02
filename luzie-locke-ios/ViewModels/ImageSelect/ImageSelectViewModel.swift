//
//  ImageSelectViewModel.swift
//  luzie-locke-ios
//
//  Created by Harry on 01.12.21.
//

import UIKit

class ImageSelectViewModel: NSObject {
  
  var selectedImages: [UIImage?] = []
  var bindableImages = Bindable<[UIImage]>()
  
  var onOpenImagePicker: ((UIImagePickerController) -> Void)?
  var onCloseImagePicker: (() -> Void)?
  
  override init() {
    bindableImages.value = [UIImage]()
  }
  
  func openImagePicker() {
    let controller = UIImagePickerController()
    controller.delegate = self
    
    onOpenImagePicker?(controller)
  }
  
  func didTapDelete(tag: Int) {
    bindableImages.value?.remove(at: tag)
  }
}

extension ImageSelectViewModel: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    let image = info[.originalImage] as? UIImage

    guard let images = bindableImages.value else { return }
    guard let image  = image                else { return }
    
    bindableImages.value = images + [image]
    onCloseImagePicker?()
  }
}

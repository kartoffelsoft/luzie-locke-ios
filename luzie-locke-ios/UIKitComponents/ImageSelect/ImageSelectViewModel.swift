//
//  ImageSelectViewModel.swift
//  luzie-locke-ios
//
//  Created by Harry on 01.12.21.
//

import UIKit

class ImageSelectViewModel: NSObject {
  
  var bindableImages = Bindable<[UIImage]>()
  
  var onOpenImagePicker: ((UIImagePickerController) -> Void)?
  
  private var processing = false
  
  override init() {
    bindableImages.value = [UIImage]()
  }
  
  func setInitialImages(images: [UIImage]) {
    bindableImages.value = images
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
    if processing == false {
      processing = true
      let image = info[.originalImage] as? UIImage
      
      guard let images = bindableImages.value else { return }
      guard let image  = image                else { return }
      
      bindableImages.value = images + [image]

      picker.dismiss(animated: true) {
        self.processing = false
      }
    }
  }
}

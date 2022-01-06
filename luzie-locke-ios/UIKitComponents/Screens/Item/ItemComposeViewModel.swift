//
//  ItemComposeViewModel.swift
//  luzie-locke-ios
//
//  Created by Harry on 03.12.21.
//

import UIKit

protocol ItemComposeViewModel {
  
  var delegate:               ItemComposeViewModelDelegate? { get set }
  
  var imageSelectViewModel:   ImageSelectViewModel { get }
  var titleViewModel:         InputViewModel { get }
  var priceViewModel:         DecimalInputViewModel  { get }
  var descriptionViewModel:   InputViewModel  { get }
  
  func upload(completion: @escaping (Result<Void, LLError>) -> Void)
}

protocol ItemComposeViewModelDelegate: AnyObject {
  
  func didOpenImagePicker(controller: UIImagePickerController)
}

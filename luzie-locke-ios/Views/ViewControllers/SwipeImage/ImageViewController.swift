//
//  ImageViewController.swift
//  luzie-locke-ios
//
//  Created by Harry on 02.11.21.
//

import UIKit

class ImageViewController: UIViewController {
  
  private let viewModel: ImageViewModel
  private let imageView = UIImageView()
  
  init(viewModel: ImageViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = .red
    configureLayout()
    configureBindables()
  }
  
  private func configureLayout() {
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.clipsToBounds                             = true
    imageView.contentMode                               = .scaleAspectFill

    view.addSubview(imageView)
    imageView.pinToEdges(of: view)
  }
  
  private func configureBindables() {
    imageView.image = viewModel.bindableImage.value
    
    viewModel.bindableImage.bind { [weak self] image in
      self?.imageView.image = image
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

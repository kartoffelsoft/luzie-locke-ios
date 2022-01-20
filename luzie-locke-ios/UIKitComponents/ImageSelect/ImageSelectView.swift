//
//  ImageSelectView.swift
//  luzie-locke-ios
//
//  Created by Harry on 01.12.21.
//

import UIKit

class ImageSelectView: UIView {
  
  var viewModel: ImageSelectViewModel?  {
    didSet {
      configureBindables()
    }
  }
  
  private let addButton = ImageSelectAddButton()
  private let imageListStackView = UIStackView()
  private let elementViews = [ImageSelectElementView]()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configureLayout()
  }
  
  private func configureLayout() {
    translatesAutoresizingMaskIntoConstraints = false
    backgroundColor = UIColor.custom.primaryColorLight2
    
    imageListStackView.translatesAutoresizingMaskIntoConstraints = false
    imageListStackView.axis             = .horizontal
    imageListStackView.spacing          = 5
    
    addSubview(addButton)
    addSubview(imageListStackView)
    
    let padding: CGFloat = 5
    
    NSLayoutConstraint.activate([
      addButton.topAnchor.constraint(equalTo: topAnchor, constant: padding),
      addButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
      addButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding),
      addButton.widthAnchor.constraint(equalTo: heightAnchor, constant: -2 * padding),
      
      imageListStackView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
      imageListStackView.leadingAnchor.constraint(equalTo: addButton.trailingAnchor, constant: 10),
      imageListStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding),
      
      addButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding),
      addButton.widthAnchor.constraint(equalTo: heightAnchor, constant: -2 * padding),
    ])
    
    addButton.addTarget(self, action: #selector(handleAddButtonTap), for: .touchUpInside)
  }
  
  private func configureBindables() {
    loadImages(viewModel?.bindableImages.value)
    viewModel?.bindableImages.bind { [weak self] images in
      self?.loadImages(images)
    }
  }

  private func loadImages(_ images: [UIImage]?) {
    guard let images = images else { return }
    
    imageListStackView.arrangedSubviews.forEach {
      $0.removeFromSuperview()
    }
    
    images.enumerated().forEach { [weak self] (index, image) in
      guard let self = self else { return }
      let view = ImageSelectElementView()
      self.imageListStackView.addArrangedSubview(view)
      
      view.delegate = self
      view.setImage(image)
      view.tag = index
      view.heightAnchor.constraint(equalTo: self.imageListStackView.heightAnchor).isActive = true
      view.widthAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    }
  }
  
  @objc private func handleAddButtonTap() {
    viewModel?.openImagePicker()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension ImageSelectView: ImageSelectElementViewDelegate {
  
  func didTapDelete(tag: Int) {
    viewModel?.didTapDelete(tag: tag)
  }
}

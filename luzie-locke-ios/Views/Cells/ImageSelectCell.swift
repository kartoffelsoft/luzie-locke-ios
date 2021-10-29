//
//  ImageSelectCell.swift
//  luzie-locke-ios
//
//  Created by Harry on 27.10.21.
//

import UIKit

class ImageSelectCell: UICollectionViewCell, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  static let reuseIdentifier = "ImageSelectCell"
  
  var viewModel: ImageSelectCellViewModel?
  
  let imageButton1 = ImageSelectButton(type: .system)
  let imageButton2 = ImageSelectButton(type: .system)
  let imageButton3 = ImageSelectButton(type: .system)
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }
  
  private func configure() {
    imageButton1.tag = 0
    imageButton2.tag = 1
    imageButton3.tag = 2
    
    let stackView = UIStackView(arrangedSubviews: [ imageButton2, imageButton3 ])
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis                                      = .vertical
    stackView.spacing                                   = 4
    stackView.distribution                              = .fillEqually
    
    addSubview(imageButton1)
    addSubview(stackView)
    
    NSLayoutConstraint.activate([
      imageButton1.topAnchor.constraint(equalTo: topAnchor),
      imageButton1.leadingAnchor.constraint(equalTo: leadingAnchor),
      imageButton1.bottomAnchor.constraint(equalTo: bottomAnchor),
      imageButton1.widthAnchor.constraint(equalToConstant: frame.size.width / 2),
      
      stackView.topAnchor.constraint(equalTo: topAnchor),
      stackView.leadingAnchor.constraint(equalTo: imageButton1.trailingAnchor, constant: 4),
      stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
      stackView.trailingAnchor.constraint(equalTo: trailingAnchor)
    ])
    
    imageButton1.addTarget(self, action: #selector(handleSelectPhoto), for: .touchUpInside)
    imageButton2.addTarget(self, action: #selector(handleSelectPhoto), for: .touchUpInside)
    imageButton3.addTarget(self, action: #selector(handleSelectPhoto), for: .touchUpInside)
  }
  
  @objc func handleSelectPhoto(button: UIButton) {
    viewModel?.openImagePicker(button: button)
  }
  
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

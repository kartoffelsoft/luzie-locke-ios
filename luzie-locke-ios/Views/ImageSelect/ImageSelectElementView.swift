//
//  ImageSelectElementView.swift
//  luzie-locke-ios
//
//  Created by Harry on 01.12.21.
//

import UIKit

protocol ImageSelectElementViewDelegate: AnyObject {
  
  func didTapDelete(tag: Int)
}

class ImageSelectElementView: UIView {
  
  weak var delegate: ImageSelectElementViewDelegate?
  
  private let imageView     = UIImageView()
  private let deleteButton  = UIButton()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }
  
  func setImage(_ image: UIImage?) {
    imageView.image = image
  }
  
  private func configure() {
    translatesAutoresizingMaskIntoConstraints               = false
    imageView.translatesAutoresizingMaskIntoConstraints     = false
    deleteButton.translatesAutoresizingMaskIntoConstraints  = false

    imageView.clipsToBounds       = true
    imageView.layer.cornerRadius  = 5
    
    deleteButton.setImage(Images.cross, for: .normal)
    
    addSubview(imageView)
    addSubview(deleteButton)
    imageView.pinToEdges(of: self)
    
    NSLayoutConstraint.activate([
      deleteButton.topAnchor.constraint(equalTo: topAnchor),
      deleteButton.trailingAnchor.constraint(equalTo: trailingAnchor),
      deleteButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1/2),
      deleteButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1/2),
    ])
    
    deleteButton.addTarget(self, action: #selector(handleDeleteButtonTap), for: .touchUpInside)
  }
  
  @objc private func handleDeleteButtonTap() {
    delegate?.didTapDelete(tag: tag)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

//
//  ChatInformationView.swift
//  luzie-locke-ios
//
//  Created by Harry on 14.12.21.
//

import UIKit

class ChatInformationView: UIView {
  
  enum Alignment {
    case left
    case right
  }
  
  private let itemImageView   = UIImageView()
  private let buyerImageView  = UIImageView()
  private let bubbleImageView = UIImageView()
  
  var itemImage: UIImage? {
    didSet {
      itemImageView.image = itemImage
    }
  }
  
  var buyerImage: UIImage? {
    didSet {
      buyerImageView.image = buyerImage
    }
  }
  
  var alignment: Alignment? {
    didSet {
      guard let alignment = alignment else { return }
      
      switch alignment {
      case .left:
        bubbleImageView.image = CustomUIImages.interestedLeft
        NSLayoutConstraint.activate([
          buyerImageView.leadingAnchor.constraint(equalTo: itemImageView.leadingAnchor),
          buyerImageView.topAnchor.constraint(equalTo: itemImageView.bottomAnchor, constant: 40),
          buyerImageView.widthAnchor.constraint(equalToConstant: 60),
          buyerImageView.heightAnchor.constraint(equalToConstant: 60),
          
          bubbleImageView.topAnchor.constraint(equalTo: buyerImageView.topAnchor, constant: -30),
          bubbleImageView.leadingAnchor.constraint(equalTo: buyerImageView.trailingAnchor, constant: -30),
          bubbleImageView.widthAnchor.constraint(equalToConstant: 120),
          bubbleImageView.heightAnchor.constraint(equalToConstant: 40),
        ])
        
      case .right:
        bubbleImageView.image = CustomUIImages.interestedRight
        NSLayoutConstraint.activate([
          buyerImageView.trailingAnchor.constraint(equalTo: itemImageView.trailingAnchor),
          buyerImageView.topAnchor.constraint(equalTo: itemImageView.bottomAnchor, constant: 40),
          buyerImageView.widthAnchor.constraint(equalToConstant: 60),
          buyerImageView.heightAnchor.constraint(equalToConstant: 60),
          
          bubbleImageView.topAnchor.constraint(equalTo: buyerImageView.topAnchor, constant: -30),
          bubbleImageView.trailingAnchor.constraint(equalTo: buyerImageView.leadingAnchor, constant: 30),
          bubbleImageView.widthAnchor.constraint(equalToConstant: 120),
          bubbleImageView.heightAnchor.constraint(equalToConstant: 40),
        ])
      }
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func configure() {
    translatesAutoresizingMaskIntoConstraints = false
   
    itemImageView.translatesAutoresizingMaskIntoConstraints = false
    itemImageView.contentMode = .scaleAspectFill
    itemImageView.clipsToBounds = true
    itemImageView.layer.cornerRadius = 10
    itemImageView.alpha = 0.2
    addSubview(itemImageView)
    
    buyerImageView.translatesAutoresizingMaskIntoConstraints = false
    buyerImageView.contentMode = .scaleAspectFill
    buyerImageView.clipsToBounds = true
    buyerImageView.layer.cornerRadius = 30
    buyerImageView.alpha = 0.2
    buyerImageView.backgroundColor = .yellow
    addSubview(buyerImageView)
    
    bubbleImageView.translatesAutoresizingMaskIntoConstraints = false
    bubbleImageView.contentMode = .scaleAspectFill
    bubbleImageView.alpha = 0.1
    addSubview(bubbleImageView)
    
    NSLayoutConstraint.activate([
      itemImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
      itemImageView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -50),
      itemImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7),
      itemImageView.heightAnchor.constraint(equalTo: itemImageView.widthAnchor),
    ])
  }
}

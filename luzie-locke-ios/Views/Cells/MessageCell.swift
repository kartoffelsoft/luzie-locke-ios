//
//  MessageCell.swift
//  luzie-locke-ios
//
//  Created by Harry on 08.11.21.
//

import UIKit

class MessageCell: UICollectionViewCell {
  
  static let reuseIdentifier = "MessageCell"

  private let textView: UITextView = {
    let view = UITextView()
    view.font             = Fonts.body//.systemFont(ofSize: 20)
    view.backgroundColor  = .clear
    view.isScrollEnabled  = false
    view.isEditable       = false
    return view
  }()
  
  private let bubbleContainer = UIView()
  
  var message: Message! {
    didSet {
      textView.text = message.text
      
      if message.isFromCurrentUser {
        NSLayoutConstraint.activate([
          bubbleContainer.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
        bubbleContainer.backgroundColor = Colors.primaryColor
        textView.textColor = Colors.primaryColorLight3
      } else {
        NSLayoutConstraint.activate([
          bubbleContainer.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20)
        ])
        bubbleContainer.backgroundColor = Colors.primaryColorLight2
        textView.textColor = Colors.tertiaryColor
      }
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }
  
  fileprivate func configure() {
    addSubview(bubbleContainer)
    bubbleContainer.layer.cornerRadius                        = 12
    bubbleContainer.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      bubbleContainer.topAnchor.constraint(equalTo: topAnchor),
      bubbleContainer.bottomAnchor.constraint(equalTo: bottomAnchor),
      bubbleContainer.widthAnchor.constraint(lessThanOrEqualToConstant: 250)
    ])
    
    bubbleContainer.addSubview(textView)
    textView.pinToEdges(of: bubbleContainer, insets: .init(top: 4, left: 12, bottom: 4, right: 12))
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

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
    view.font             = Fonts.body
    view.backgroundColor  = .clear
    view.isScrollEnabled  = false
    view.isEditable       = false
    return view
  }()
  
  private let bubbleContainer = UIView()
  var rightAlignConstraints: NSLayoutConstraint!
  var leftAlignConstraints: NSLayoutConstraint!
  
  var message: Message! {
    didSet {
      print("@@#", message.text)
      textView.text = message.text
      
      if message.isFromCurrentUser {
        rightAlignConstraints.isActive = true
        leftAlignConstraints.isActive = false
        bubbleContainer.backgroundColor = Colors.primaryColor
        textView.textColor = Colors.primaryColorLight3
      } else {
        rightAlignConstraints.isActive = false
        leftAlignConstraints.isActive = true
        bubbleContainer.backgroundColor = Colors.primaryColorLight2
        textView.textColor = Colors.tertiaryColor
      }
    }
  }
  
  override init(frame: CGRect) {
    print("init@@")
    super.init(frame: frame)
    configure()
    
    rightAlignConstraints = bubbleContainer.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15)
    leftAlignConstraints = bubbleContainer.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15)
  }
  
  fileprivate func configure() {
    addSubview(bubbleContainer)
    bubbleContainer.layer.cornerRadius                        = 12
    bubbleContainer.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      bubbleContainer.topAnchor.constraint(equalTo: topAnchor, constant: 2),
      bubbleContainer.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2),
      bubbleContainer.widthAnchor.constraint(lessThanOrEqualToConstant: 260),
    ])
    
    bubbleContainer.addSubview(textView)
    textView.pinToEdges(of: bubbleContainer, insets: .init(top: 4, left: 12, bottom: 4, right: 12))
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

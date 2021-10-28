//
//  MultiLineTextField.swift
//  luzie-locke-ios
//
//  Created by Harry on 28.10.21.
//

import UIKit

class MultiLineInputTextField: UITextView {
  
  override init(frame: CGRect, textContainer: NSTextContainer?) {
    super.init(frame: frame, textContainer: textContainer)
    
    translatesAutoresizingMaskIntoConstraints = false
    isUserInteractionEnabled                  = true
    backgroundColor                           = .systemBackground
    layer.borderWidth                         = 1
    layer.cornerRadius                        = 5
    layer.borderColor                         = UIColor(named: "PrimaryColor")?.cgColor
    textContainerInset                        = UIEdgeInsets(top: 12, left: 6, bottom: 6, right: 6)
    font                                      = .systemFont(ofSize: 16)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}


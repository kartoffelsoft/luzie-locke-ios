//
//  SingleLineTextField.swift
//  luzie-locke-ios
//
//  Created by Harry on 28.10.21.
//

import UIKit

class SingleLineInputTextField: UITextField {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    translatesAutoresizingMaskIntoConstraints = false
    isUserInteractionEnabled                  = true
    backgroundColor                           = .systemBackground
    layer.borderColor                         = UIColor(named: "PrimaryColor")?.cgColor
    layer.borderWidth                         = 1
    layer.cornerRadius                        = 5
    font                                      = .systemFont(ofSize: 16)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func textRect(forBounds bounds: CGRect) -> CGRect {
    return bounds.insetBy(dx: 12, dy: 0)
  }
  
  override func editingRect(forBounds bounds: CGRect) -> CGRect {
    return bounds.insetBy(dx: 12, dy: 0)
  }
}

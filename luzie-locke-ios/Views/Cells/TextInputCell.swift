//
//  TextInputCell.swift
//  luzie-locke-ios
//
//  Created by Harry on 27.10.21.
//

import UIKit

class TextInputCell: UICollectionViewCell {
  
  static let reuseIdentifier = "TextInputCell"
  
  class CustomTextField: UITextField {
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
      return bounds.insetBy(dx: 12, dy: 0)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
      return bounds.insetBy(dx: 12, dy: 0)
    }
  }
  
  let textField = CustomTextField()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }
  
  private func configure() {
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.isUserInteractionEnabled                  = true
    textField.backgroundColor                           = .white

    addSubview(textField)

    textField.pinToEdges(of: self)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

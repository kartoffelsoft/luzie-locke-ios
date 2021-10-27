//
//  NumberInputCell.swift
//  luzie-locke-ios
//
//  Created by Harry on 27.10.21.
//

import UIKit

class NumberInputCell: UICollectionViewCell {
  
  static let reuseIdentifier = "NumberInputCell"
  
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
    textField.delegate                                  = self
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.isUserInteractionEnabled                  = true
    textField.backgroundColor                           = .white
    textField.keyboardType                              = UIKeyboardType.decimalPad
    
    addSubview(textField)

    textField.pinToEdges(of: self)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension NumberInputCell: UITextFieldDelegate {
  
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    print(string)
    let allowedCharacters = CharacterSet.decimalDigits.union(CharacterSet (charactersIn: "."))
    let characterSet      = CharacterSet(charactersIn: string)
    return allowedCharacters.isSuperset(of: characterSet)
  }
}

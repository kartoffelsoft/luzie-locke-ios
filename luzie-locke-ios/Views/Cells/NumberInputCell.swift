//
//  NumberInputCell.swift
//  luzie-locke-ios
//
//  Created by Harry on 27.10.21.
//

import UIKit

class NumberInputCell: UICollectionViewCell {
  
  static let reuseIdentifier = "NumberInputCell"
  
  private let textField      = SingleLineInputTextField()
  
  var placeholder: String? {
    didSet {
      textField.text      = placeholder
      textField.textColor = .systemGray3
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }
  
  private func configure() {
    addSubview(textField)
    
    textField.delegate      = self
    textField.keyboardType  = UIKeyboardType.decimalPad
    textField.pinToEdges(of: self)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension NumberInputCell: UITextFieldDelegate {
  
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    let allowedCharacters = CharacterSet.decimalDigits.union(CharacterSet (charactersIn: "."))
    let characterSet      = CharacterSet(charactersIn: string)
    return allowedCharacters.isSuperset(of: characterSet)
  }
  
  func textFieldDidBeginEditing(_ textField: UITextField) {
    if textField.textColor == .systemGray3 && textField.isFirstResponder {
      textField.text = nil
      textField.textColor = .label
    }
  }
  
  func textFieldDidEndEditing(_ textField: UITextField) {
    if let text = textField.text, text.isEmpty || text == "" {
      textField.text = placeholder
      textField.textColor = .systemGray3
    }
  }
}

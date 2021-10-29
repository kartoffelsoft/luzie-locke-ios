//
//  MultiLineTextInputCell.swift
//  luzie-locke-ios
//
//  Created by Harry on 28.10.21.
//

import UIKit

class MultiLineTextInputCell: UICollectionViewCell {
  
  static let reuseIdentifier = "MultiLineTextInputCell"
  
  private let textField      = MultiLineInputTextField()
  
  var viewModel: TextInputCellViewModel?
  var placeholder: String? {
    didSet {
      textField.text = placeholder
      textField.textColor = .systemGray3
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }
  
  private func configure() {
    addSubview(textField)
    
    textField.delegate = self
    textField.pinToEdges(of: self)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension MultiLineTextInputCell: UITextViewDelegate {

  func textViewDidBeginEditing(_ textView: UITextView) {
    if textField.textColor == .systemGray3 && textField.isFirstResponder {
      textField.text      = nil
      textField.textColor = Colors.primaryColor
    }
  }
  
  func textViewDidEndEditing(_ textView: UITextView) {
    if textField.text.isEmpty || textField.text == "" {
      textField.text      = placeholder
      textField.textColor = .systemGray3
    }
  }
  
  func textViewDidChange(_ textView: UITextView) {
    viewModel?.text = textView.text
  }
}

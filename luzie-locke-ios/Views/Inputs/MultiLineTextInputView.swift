//
//  MultiLineTextInputView.swift
//  luzie-locke-ios
//
//  Created by Harry on 30.11.21.
//

import UIKit


protocol MultiLineTextInputViewDelegate: AnyObject {
  func inputDidChange(_ textView: UITextView)
}

class MultiLineTextInputView: UIView {
  weak var delegate: MultiLineTextInputViewDelegate?
  
  let textView                  = UITextView()
  private let placeholderColor  = Colors.primaryColorLight1
  
  var viewModel: MultiLineTextInputViewModel?
  var placeholder: String? {
    didSet {
      textView.text      = placeholder
      textView.textColor = placeholderColor
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }
  
  private func configure() {
    translatesAutoresizingMaskIntoConstraints           = false
    textView.translatesAutoresizingMaskIntoConstraints  = false
    
    addSubview(textView)
    textView.pinToEdges(of: self)
    
    textView.delegate                 = self
    textView.font                     = Fonts.body
    textView.isScrollEnabled          = false
    textView.isUserInteractionEnabled = true
    textView.backgroundColor          = .clear
    textView.textContainerInset       = UIEdgeInsets(top: 12, left: 6, bottom: 12, right: 6)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension MultiLineTextInputView: UITextViewDelegate {

  func textViewDidBeginEditing(_ textView: UITextView) {
    if textView.textColor == placeholderColor && textView.isFirstResponder {
      textView.text      = nil
      textView.textColor = Colors.primaryColor
    }
  }
  
  func textViewDidEndEditing(_ textView: UITextView) {
    if textView.text.isEmpty || textView.text == "" {
      textView.text      = placeholder
      textView.textColor = placeholderColor
    }
  }
  
  func textViewDidChange(_ textView: UITextView) {
    viewModel?.text = textView.text
    delegate?.inputDidChange(textView)
  }
}

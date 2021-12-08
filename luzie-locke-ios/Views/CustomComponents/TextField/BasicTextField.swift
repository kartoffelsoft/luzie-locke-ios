//
//  BasicTextField.swift
//  luzie-locke-ios
//
//  Created by Harry on 08.12.21.
//

import UIKit

class BasicTextField: UITextField {
  
  let padding: CGFloat
  let height: CGFloat
  
  init(padding: CGFloat, height: CGFloat) {
    self.padding = padding
    self.height = height
    super.init(frame: .zero)
    layer.cornerRadius = 25
    backgroundColor = .white
  }
  
  override func textRect(forBounds bounds: CGRect) -> CGRect {
    return bounds.insetBy(dx: padding, dy: 0)
  }
  
  override func editingRect(forBounds bounds: CGRect) -> CGRect {
    return bounds.insetBy(dx: padding, dy: 0)
  }
  
  override var intrinsicContentSize: CGSize {
    return .init(width: 0, height: height)
  }
  
//  override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
//    print(bounds)
//      return CGRect(x: 10, y: 10, width: 25, height: height / 2)
//  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

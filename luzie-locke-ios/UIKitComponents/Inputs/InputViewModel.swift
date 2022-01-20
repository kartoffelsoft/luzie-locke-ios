//
//  InputViewModel.swift
//  luzie-locke-ios
//
//  Created by Harry on 02.12.21.
//

import UIKit

class InputViewModel {

  enum State {
    case active
    case inactive
  }
  
  private var state: State {
    didSet {
      switch(state) {
      case .active:
        bindableText.value      = nil
        bindableTextColor.value = UIColor.custom.primaryColor
      case .inactive:
        bindableText.value      = placeholder
        bindableTextColor.value = UIColor.custom.primaryColorLight1
      }
    }
  }
  
  let placeholder: String

  var bindableText      = Bindable<String>()
  var bindableTextColor = Bindable<UIColor>()
  
  init(placeholder: String) {
    self.placeholder        = placeholder
    self.state              = .inactive
    
    bindableText.value      = placeholder
    bindableTextColor.value = UIColor.custom.primaryColorLight1
  }
  
  func setInitialText(_ initialText: String?) {
    state = .active
    bindableText.value  = initialText
  }
  
  func getText() -> String? {
    switch(state) {
    case .active:
      return bindableText.value
    case .inactive:
      return nil
    }
  }
  
  func didChangeInput(text: String?) {
    bindableText.value = text
  }
  
  func didBeginEditing() {
    if state == .inactive {
      state = .active
    }
  }
  
  func didEndEditing() {
    if let text = bindableText.value {
      if text.isEmpty {
        state = .inactive
      }
    } else {
      state = .inactive
    }
  }
}

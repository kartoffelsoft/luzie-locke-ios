//
//  SingleLineDecimalInputViewModel.swift
//  luzie-locke-ios
//
//  Created by Harry on 01.12.21.
//

import Foundation

class SingleLineDecimalInputViewModel {

  var text: String?
  
  func isNextStringOkay(_ string: String) -> Bool {
    var allowed  = CharacterSet.decimalDigits
    
    guard let text = self.text else {
      return allowed.isSuperset(of: CharacterSet(charactersIn: string))
    }

    if text.count > 0, text.components(separatedBy:".").count == 1 {
      allowed = allowed.union(CharacterSet(charactersIn: "."))
    }
    
    return allowed.isSuperset(of: CharacterSet(charactersIn: string))
  }
}

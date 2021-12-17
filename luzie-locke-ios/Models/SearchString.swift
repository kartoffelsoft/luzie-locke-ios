//
//  SearchString.swift
//  luzie-locke-ios
//
//  Created by Harry on 17.12.21.
//

import Foundation

struct SearchString: Encodable {
  
  private let value: String
  
  init(_ value: String) {
    self.value = value
  }
  
  func toString() -> String{
    let trimmed = value.trimmingCharacters(in: .whitespacesAndNewlines)
    let filtered = trimmed.filter { $0 != "\"" }
    return filtered.replacingOccurrences(of: " ", with: "+")
  }
}

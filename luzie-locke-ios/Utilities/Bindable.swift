//
//  Bindable.swift
//  luzie-locke-ios
//
//  Created by Harry on 24.10.21.
//

import Foundation

class Bindable<T> {
  
  var value: T? {
    didSet {
      observer?(value)
    }
  }
  
  var observer: ((T?) -> ())?
  
  func bind(observer: @escaping (T?) -> ()) {
    self.observer = observer
  }
}

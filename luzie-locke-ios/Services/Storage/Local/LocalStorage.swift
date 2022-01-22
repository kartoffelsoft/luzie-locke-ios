//
//  Storage.swift
//  luzie-locke-ios
//
//  Created by Harry on 20.10.21.
//

import Foundation

protocol LocalStorage {
  
  associatedtype DataType
  func get() -> DataType?
  func set(_ data: DataType)
  func clear()
}

class AnyStorage<DataType>: LocalStorage {
  
  private let getObject:      () -> DataType?
  private let setObject:      (_ data: DataType) -> Void
  private let clearObject:    () -> Void
  
  init<T: LocalStorage>(wrap: T) where T.DataType == DataType {
    self.getObject      = wrap.get
    self.setObject      = wrap.set
    self.clearObject    = wrap.clear
  }
  
  func get() -> DataType? {
    return getObject()
  }
  
  func set(_ data: DataType) {
    setObject(data)
  }
  
  func clear() {
    clearObject()
  }
}

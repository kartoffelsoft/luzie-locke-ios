//
//  Storage.swift
//  luzie-locke-ios
//
//  Created by Harry on 20.10.21.
//

import Foundation

protocol Storage {
  
  associatedtype DataType
  func get() -> DataType?
  func set(_ data: DataType)
  func clear()
  func isEmpty() -> Bool
}

class AnyStorage<DataType>: Storage {
  
  private let getObject:      () -> DataType?
  private let setObject:      (_ data: DataType) -> Void
  private let clearObject:    () -> Void
  private let isEmptyObject:  () -> Bool
  
  init<T: Storage>(wrap: T) where T.DataType == DataType {
    self.getObject      = wrap.get
    self.setObject      = wrap.set
    self.clearObject    = wrap.clear
    self.isEmptyObject  = wrap.isEmpty
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
  
  func isEmpty() -> Bool {
    isEmptyObject()
  }
}

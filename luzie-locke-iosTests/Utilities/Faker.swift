//
//  Faker.swift
//  luzie-locke-iosTests
//
//  Created by Harry on 19.12.21.
//

import Foundation

class Faker {
  
  static let name     = Name()
  static let datatype = Datatype()
  static let address  = Address()
  static let image    = Image()
  static let lorem    = Lorem()
  
  class Name {
    
    fileprivate init() {}
    
    func findName() -> String {
      return [ "John", "Jane", "Alex", "Harry", "Victoria", "Kiara", "Sue", "Robert" ].randomElement()!
    }
  }
  
  class Datatype {
    
    fileprivate init() {}
    
    func int(max: Int = 99999) -> Int {
      return Int(arc4random_uniform(UInt32(max)))
    }
    
    func double() -> Double {
      return Double(arc4random()) / 0xFFFFFFFF
    }
    
    func id(length: Int = 28) -> String {
      var s = ""
      for _ in 0 ..< length {
        s.append("abcdefghijklmnopqrstuvwxyz0123456789".randomElement()!)
      }
      return s
    }
  }
  
  class Address {
    
    fileprivate init() {}
    
    func city() -> String {
      return [ "Frankfurt", "Berlin", "Kronberg", "Dortmund", "München", "Potdam" ].randomElement()!
    }
  }
  
  class Image {
    
    fileprivate init() {}
    
    func imageUrl() -> String {
      return  [ "www" ].randomElement()! + "." +
              [ "github", "stackoverflow", "yelp", "sktelecom" ].randomElement()! + "." +
              [ "com", "net", "io", "de" ].randomElement()! + "/" +
              Faker.datatype.id()
    }
    
    func imageUrls() -> [String] {
      return  [ imageUrl(), imageUrl(), imageUrl() ]
    }
  }
  
  class Lorem {
    
    fileprivate init() {}
    
    func sentenece(wordCount: Int = 4) -> String {
      let words = [
        "Lorem", "ipsum", "dolor", "sit", "amet,", "consectetur", "adipiscing", "elit,",
        "sed", "do", "eiusmod", "tempor", "incididunt", "ut", "labore", "et", "dolore", "magna",
        "aliqua.", "Ut", "enim", "ad", "minim", "veniam,", "quis", "nostrud", "exercitation"
      ]
      
      var s = ""
      for _ in 0 ..< wordCount {
        s.append(words.randomElement()!)
      }
      return s
    }
  }
}

//
//  DateUtility.swift
//  luzie-locke-ios
//
//  Created by Harry on 11.11.21.
//

import Foundation

struct DateUtility {
  
  static func string(from date: Date?) -> String {
    if let date = date {
      let dateFormatter = DateFormatter()
      
      if Calendar.current.isDateInToday(date) {
        dateFormatter.dateFormat = "hh:mm"
      } else {
        dateFormatter.dateFormat = "y.m.d"
      }
      
      return dateFormatter.string(from: date)
    }
    
    return ""
  }
}

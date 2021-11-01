//
//  Dictionary+Ext.swift
//  luzie-locke-ios
//
//  Created by Harry on 01.11.21.
//

import Foundation

extension Dictionary {
  
  var urlQueryString: String {
    var queryString: String = "?"
    for (key,value) in self {
      queryString +=  "\(key)=\(value)&"
    }
    return String(queryString.dropLast())
  }
}

extension Formatter {
    static let iso8601: DateFormatter = {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
        return formatter
    }()
}

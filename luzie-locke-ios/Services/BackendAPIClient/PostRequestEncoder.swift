//
//  PostRequestEncoder.swift
//  luzie-locke-ios
//
//  Created by Harry on 18.10.21.
//

import Foundation

enum PostRequestEncoder {
    
    static func encode<T: Encodable>(_ encodable: T) throws -> [String: String] {
      print("1")
        let parametersData = try JSONEncoder().encode(encodable)
        print("1.1")
        print(String(data: parametersData, encoding: .utf8)!)
        let parameters = try JSONDecoder().decode([String: String].self, from: parametersData)
        print("2")
        return parameters
    }
}

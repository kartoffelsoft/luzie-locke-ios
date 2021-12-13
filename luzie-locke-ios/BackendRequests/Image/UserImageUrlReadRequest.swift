//
//  ImageReadDTO.swift
//  luzie-locke-ios
//
//  Created by Harry on 10.12.21.
//

import Foundation

struct UserImageUrlReadRequest: APIRequest {
  
  typealias Response = UserImageUrlReadResponse
  
  var resourceName: String {
    return "/api/users/" + id + "/image"
  }

  let id: String
  
  func toDictionary() -> [String: Any] {
    return [ : ]
  }
}

struct UserImageUrlReadResponse: Decodable {
  let url: String
}

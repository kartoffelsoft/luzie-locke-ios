//
//  ImageReadDTO.swift
//  luzie-locke-ios
//
//  Created by Harry on 10.12.21.
//

import Foundation

struct UserImageUrlReadRequestDTO: APIRequest {
  
  typealias Response = UserImageUrlReadResponseDTO
  
  var resourceName: String {
    return "/api/users/" + id + "/image"
  }

  let id: String
  
  func toDictionary() -> [String: Any] {
    return [ : ]
  }
}

struct UserImageUrlReadResponseDTO: Decodable {
  let url: String
}

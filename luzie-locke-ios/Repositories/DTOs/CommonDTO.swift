//
//  NoDataResponse.swift
//  luzie-locke-ios
//
//  Created by Harry on 30.10.21.
//

import Foundation

struct VoidResponseDTO: Decodable {}

struct BackendResponseDTO<Response: Decodable>: Decodable {
  let status: String
  let message: String
  let data: Response?
}

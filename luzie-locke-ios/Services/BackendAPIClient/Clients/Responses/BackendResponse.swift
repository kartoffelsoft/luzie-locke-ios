//
//  BackendResponse.swift
//  luzie-locke-ios
//
//  Created by Harry on 20.10.21.
//

import Foundation

struct BackendResponse<Response: Decodable>: Decodable {
  let status: String
  let message: String
  let data: Response?
}

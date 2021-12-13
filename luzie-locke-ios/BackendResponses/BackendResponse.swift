//
//  BackendResponse.swift
//  luzie-locke-ios
//
//  Created by Harry on 13.12.21.
//

import Foundation

struct BackendResponse<Response: Decodable>: Decodable {
  
  let success: Bool
  let message: String
  let data: Response?
}

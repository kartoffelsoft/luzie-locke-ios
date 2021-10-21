//
//  LLError.swift
//  luzie-locke-ios
//
//  Created by Harry on 11.10.21.
//

import Foundation

enum LLError: String, Error {
  case unableToComplete = "Unable to complete your request. Please check your internet connection"
  case serverErrorResponse = "The server reported an error."
  case unexpectedServerResponse = "Unexpected response received from the server."
  case invalidResponse = "Invalid response from the server. Please retry."
  case invalidData = "The data received from the server was invalid. Please try again."
}

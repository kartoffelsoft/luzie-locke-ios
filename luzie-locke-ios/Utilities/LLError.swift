//
//  LLError.swift
//  luzie-locke-ios
//
//  Created by Harry on 11.10.21.
//

import Foundation

enum LLError: String, Error {
  case unableToComplete         = "Unable to complete your request. Please check your internet connection"
  case unableToCompleteUpload   = "Unable to upload image(s). Please check your internet connection"
  case serverErrorResponse      = "The server reported an error."
  case unexpectedServerResponse = "Unexpected response received from the server."
  case invalidResponse          = "Invalid response from the server. Please retry."
  case invalidData              = "The data received from the server was invalid. Please try again."
  case photoNotSelected         = "Should upload at least one photo."
  case titleInvalid             = "The title is empty or too short. Must be at least 3 characters long."
  case descriptionInvalid       = "The description is empty or too short. Must be at least 9 characters long."
  case priceInvalid             = "The price is empty or invalid."
}

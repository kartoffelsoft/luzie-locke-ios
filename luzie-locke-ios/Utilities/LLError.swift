//
//  LLError.swift
//  luzie-locke-ios
//
//  Created by Harry on 11.10.21.
//

import Foundation

enum LLError: LocalizedError {
  
  case badServerResponse
  case unableToComplete
  case unableToCompleteUpload
  case unexpectedServerResponse
  case invalidURL
  case invalidResponse
  case invalidData
  case photoNotSelected
  case titleInvalid
  case descriptionInvalid
  case priceInvalid
  
  var errorDescription: String? {
    switch self {
      //    case .badURLResponse(url: let url): return "[🔥] Bad response from URL: \(url)"
      //    case .unknown: return "[⚠️] Unknown error occured."
    case .badServerResponse: return "The server reported an error."
    case .unableToComplete: return "Unable to complete your request. Please check your internet connection"
    case .unableToCompleteUpload: return "Unable to upload image(s). Please check your internet connection"
    case .unexpectedServerResponse: return "Unexpected response received from the server."
    case .invalidURL: return "Invalid URL."
    case .invalidResponse: return "Invalid response from the server. Please retry."
    case .invalidData: return "The data received from the server was invalid. Please try again."
    case .photoNotSelected: return "Should upload at least one photo."
    case .titleInvalid: return "The title is empty or too short. Must be at least 3 characters long."
    case .descriptionInvalid: return "The description is empty or too short. Must be at least 9 characters long."
    case .priceInvalid: return "The price is empty or invalid."
    }
  }
}

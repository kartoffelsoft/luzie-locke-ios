//
//  SettingsLocationUpdateDTO.swift
//  luzie-locke-ios
//
//  Created by Harry on 07.12.21.
//

import Foundation

struct SettingsLocationUpdateRequest: APIRequest {
  
  typealias Response = VoidResponse
  
  var resourceName: String {
    return "/api/settings/location"
  }
  
  let city: String
  let lat:  Double
  let lng:  Double
  
  init(city: String, lat: Double, lng: Double) {
    self.city = city
    self.lat  = lat
    self.lng  = lng
  }
  
  func toDictionary() -> [String: Any] {
    return [ "city": city,
             "lat":  lat,
             "lng":  lng   ]
  }
}


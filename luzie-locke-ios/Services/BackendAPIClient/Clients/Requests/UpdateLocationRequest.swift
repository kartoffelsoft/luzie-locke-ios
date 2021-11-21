//
//  LocationUpdateRequest.swift
//  luzie-locke-ios
//
//  Created by Harry on 19.10.21.
//

import Foundation

struct UpdateLocationRequest: APIRequest {
  
  typealias Response = UpdateLocationResponse
  
  var resourceName: String {
    return "/api/users/location"
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

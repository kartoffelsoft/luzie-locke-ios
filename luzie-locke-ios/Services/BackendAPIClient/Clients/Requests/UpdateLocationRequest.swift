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
  
  let name: String
  let lat:  Double
  let lng:  Double
  
  init(name: String, lat: Double, lng: Double) {
    self.name = name
    self.lat  = lat
    self.lng  = lng
  }
  
  func toDictionary() -> [String: Any] {
    return [ "name": name,
             "lat":  lat,
             "lng":  lng   ]
  }
}

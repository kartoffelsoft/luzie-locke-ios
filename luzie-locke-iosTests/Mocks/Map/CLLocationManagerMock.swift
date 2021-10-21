//
//  CLLocationManagerMock.swift
//  luzie-locke-iosTests
//
//  Created by Harry on 15.10.21.
//

import MapKit

class CLLocationManagerMock: CLLocationManager {
  
  private var mockAuthorizationStatus: CLAuthorizationStatus
  
  var numRequestWhenInUseAuthorizationCalled = 0
  var numStartUpdatingLocationCalled         = 0
  
  override var authorizationStatus: CLAuthorizationStatus {
    return mockAuthorizationStatus
  }
  
  override init() {
    mockAuthorizationStatus = .notDetermined
    super.init()
  }
  
  override func requestWhenInUseAuthorization() {
    numRequestWhenInUseAuthorizationCalled = numRequestWhenInUseAuthorizationCalled + 1
  }
  
  override func startUpdatingLocation() {
    numStartUpdatingLocationCalled = numStartUpdatingLocationCalled + 1
  }
  
  func whenAuthorizationStatusIsAuthorizedWhenInUse() {
    mockAuthorizationStatus = .authorizedWhenInUse
    delegate?.locationManagerDidChangeAuthorization?(self)
  }
  
  //    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
  //        guard let firstLocation = locations.first else { return }
  //        mapView.setRegion(.init(center: firstLocation.coordinate, span: .init(latitudeDelta: 0.1, longitudeDelta: 0.1)), animated: false)
  //        updateLocationName(location: firstLocation)
  //        locationManager.stopUpdatingLocation()
  //    }
}

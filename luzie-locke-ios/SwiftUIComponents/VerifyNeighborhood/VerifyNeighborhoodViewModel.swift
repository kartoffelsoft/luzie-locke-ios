//
//  VerifyNeighborhoodViewModel.swift
//  luzie-locke-ios
//
//  Created by Harry on 15.12.21.
//

import MapKit

class VerifyNeighborhoodViewModel: NSObject, ObservableObject {
  
  @Published var currentLocation:   String?
  @Published var currentCoordinate: CLLocationCoordinate2D?

  private let locationManager:    CLLocationManager
  private let coordinator:        PopCoordinatable
  private let settingsUseCase:    SettingsUseCaseProtocol
  
  init(locationManager:     CLLocationManager,
       coordinator:         PopCoordinatable,
       settingsUseCase:     SettingsUseCaseProtocol) {
    self.locationManager    = locationManager
    self.coordinator        = coordinator
    self.settingsUseCase    = settingsUseCase
    super.init()
    
    requestUserLocation()
  }
  
  private func requestUserLocation() {
    locationManager.delegate = self
    
    if(locationManager.authorizationStatus == .authorizedWhenInUse) {
      locationManager.startUpdatingLocation()
    } else {
      locationManager.requestWhenInUseAuthorization()
    }
  }
  
  private func updateLocation(location: CLLocation) {
    let geocoder = CLGeocoder()
    geocoder.reverseGeocodeLocation(location) { [weak self] placemarks, error in
      guard let placemarks = placemarks,
            let firstPlacemark = placemarks.first else { return }
      
      self?.currentLocation = firstPlacemark.locality
      self?.currentCoordinate = location.coordinate
    }
  }
  
  func didChangeLocationPin(location: CLLocation) {
    updateLocation(location: location)
  }

  func didTapApply() {
    guard let city = currentLocation,
          let lat = currentCoordinate?.latitude,
          let lng = currentCoordinate?.longitude else { return }

    settingsUseCase.setLocation(city: city, lat: lat, lng: lng) { result in
      switch result {
      case .success:
        NotificationCenter.default.post(name: .didUpdateLocationSettings, object: nil)
        self.coordinator.popViewController()
      case .failure(let error):
        print(error)
      }
    }
  }
}

extension VerifyNeighborhoodViewModel: CLLocationManagerDelegate {
  
  func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
    switch manager.authorizationStatus {
    case .authorizedWhenInUse:
      locationManager.startUpdatingLocation()
    default:
      print("Failed to authorize")
    }
  }
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    guard let firstLocation = locations.first else { return }
    locationManager.stopUpdatingLocation()
    currentCoordinate = firstLocation.coordinate
    updateLocation(location: firstLocation)
  }
}

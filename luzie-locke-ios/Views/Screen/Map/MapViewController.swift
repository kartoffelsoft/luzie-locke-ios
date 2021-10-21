//
//  MapViewController.swift
//  luzie-locke-ios
//
//  Created by Harry on 15.10.21.
//

import UIKit
import MapKit

typealias MapViewCallback = ((String?, CLLocationDegrees?, CLLocationDegrees?) -> Void)

class MapViewController: UIViewController {
  
  var selectAction:       MapViewCallback?
  var currentLatitude:    CLLocationDegrees?
  var currentLongitude:   CLLocationDegrees?
  var currentLocation:    String? {
    didSet {
      locationLabel.text = currentLocation
    }
  }
  
  let mapView:            MKMapView
  let locationManager:    CLLocationManager
  
  let locationLabel       = UILabel()
  let setButton           = KRoundButton(radius: 40)
  let backButton          = KRoundButton(radius: 20)
  
  init(mapView: MKMapView, locationManager: CLLocationManager) {
    self.mapView           = mapView
    self.locationManager   = locationManager
    super.init(nibName: nil, bundle: nil)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    requestUserLocation()
    configureMapView()
    configureLocationNameView()
    configureButtons()
  }
  
  private func requestUserLocation() {
    locationManager.delegate = self
    
    if(locationManager.authorizationStatus == .authorizedWhenInUse) {
      locationManager.startUpdatingLocation()
    } else {
      locationManager.requestWhenInUseAuthorization()
    }
  }
  
  private func configureMapView() {
    view.addSubview(mapView)
    
    mapView.delegate                                  = self
    mapView.showsUserLocation                         = true
    mapView.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      mapView.topAnchor.constraint(equalTo: view.topAnchor),
      mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
    ])
  }
  
  private func configureLocationNameView() {
    let container                                           = UIView()
    container.backgroundColor                               = UIColor(named: "PrimaryColor")?.withAlphaComponent(0.7)
    container.layer.cornerRadius                            = 10
    container.translatesAutoresizingMaskIntoConstraints     = false
    
    locationLabel.font                                      = .systemFont(ofSize: 25, weight: .bold)
    locationLabel.textColor                                 = .white
    locationLabel.textAlignment                             = .center
    locationLabel.backgroundColor                           = .clear
    locationLabel.translatesAutoresizingMaskIntoConstraints = false
    
    view.addSubview(container)
    container.addSubview(locationLabel)
    
    NSLayoutConstraint.activate([
      container.topAnchor.constraint(equalTo: view.topAnchor),
      container.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      container.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      container.heightAnchor.constraint(equalToConstant: 100),
      
      locationLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor),
      locationLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor),
      locationLabel.centerXAnchor.constraint(equalTo: container.centerXAnchor),
      locationLabel.centerYAnchor.constraint(equalTo: container.centerYAnchor, constant: 15)
    ])
  }
  
  private func configureButtons() {
    setButton.animatePulse()
    setButton.backgroundColor = UIColor(named: "PrimaryColor")
    setButton.setTitle("SET", for: .normal)
    
    backButton.backgroundColor = .white
    backButton.setImage(UIImage(systemName: "arrowshape.turn.up.backward.fill"), for: .normal)
    backButton.imageView?.tintColor = UIColor(named: "PrimaryColor")
    
    setButton.addTarget(self, action: #selector(handleSet), for: .touchUpInside)
    backButton.addTarget(self, action: #selector(handleBack), for: .touchUpInside)
    
    view.addSubview(setButton)
    view.addSubview(backButton)
    
    NSLayoutConstraint.activate([
      setButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
      setButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
      backButton.bottomAnchor.constraint(equalTo: setButton.topAnchor, constant: -17),
      backButton.centerXAnchor.constraint(equalTo: setButton.centerXAnchor)
    ])
  }
  
  private func updateLocation(location: CLLocation) {
    let geocoder = CLGeocoder()
    geocoder.reverseGeocodeLocation(location) { [weak self] placemarks, error in
      guard let placemarks = placemarks,
            let firstPlacemark = placemarks.first else { return }
      
      self?.currentLocation = firstPlacemark.locality
      self?.currentLatitude = location.coordinate.latitude
      self?.currentLongitude = location.coordinate.longitude
    }
  }
  
  @objc private func handleSet() {
    if let currentLocation = currentLocation,
       let currentLatitude = currentLatitude,
       let currentLongitude = currentLongitude {
      selectAction?(currentLocation, currentLatitude, currentLongitude)
    } else {
      presentAlertOnMainThread(
        title: "Missing Location",
        message: "You location is unknown. Move the mark to your location or tap Back button to set later.",
        buttonTitle: "OK")
    }
  }
  
  @objc private func handleBack() {
    selectAction?(nil, nil, nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension MapViewController: CLLocationManagerDelegate {
  
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
    mapView.setRegion(.init(center: firstLocation.coordinate, span: .init(latitudeDelta: 0.3, longitudeDelta: 0.3)), animated: false)
    updateLocation(location: firstLocation)
    locationManager.stopUpdatingLocation()
  }
}

extension MapViewController: MKMapViewDelegate {
  
  func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    if annotation is MKUserLocation {
      let pin = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "id")
      pin.isDraggable = true
      return pin
    }
    
    return nil
  }
  
  func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, didChange newState: MKAnnotationView.DragState, fromOldState oldState: MKAnnotationView.DragState) {
    
    if(oldState == .dragging && newState == .ending) {
      if let coordinate = view.annotation?.coordinate {
        updateLocation(location: CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude))
      }
    }
  }
}

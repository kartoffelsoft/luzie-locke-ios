//
//  MapViewController.swift
//  luzie-locke-ios
//
//  Created by Harry on 15.10.21.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    var selectAction:       ((String?) -> Void)?
    
    var currentLocation:    String? {
        didSet {
            locationLabel.text = currentLocation
        }
    }
    
    let locationLabel = UILabel()
        
    let mapView: MKMapView
    let locationManager: CLLocationManager
    
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
    }
    
    private func requestUserLocation() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
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
            container.heightAnchor.constraint(equalToConstant: 150),

            locationLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            locationLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            locationLabel.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            locationLabel.centerYAnchor.constraint(equalTo: container.centerYAnchor, constant: 20),
        ])
    }
    
    private func updateLocationName(location: CLLocation) {
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { [weak self] placemarks, error in
            guard let placemarks = placemarks,
                  let firstPlacemark = placemarks.first else { return }
            
            self?.currentLocation = firstPlacemark.locality
        }
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
        mapView.setRegion(.init(center: firstLocation.coordinate, span: .init(latitudeDelta: 0.1, longitudeDelta: 0.1)), animated: false)
        updateLocationName(location: firstLocation)
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
                updateLocationName(location: CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude))
            }
        }
    }
}

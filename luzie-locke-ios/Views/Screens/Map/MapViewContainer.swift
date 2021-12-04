//
//  MapViewContainer.swift
//  luzie-locke-ios
//
//  Created by Harry on 04.12.21.
//

import SwiftUI
import MapKit

struct MapViewContainer: UIViewRepresentable {
  
  let mapView = MKMapView()
  
  func makeUIView(context: Context) -> MKMapView {
    setupRegionForMap()
    return mapView
  }
  
  private func setupRegionForMap() {
    let centerCoordinate = CLLocationCoordinate2D(latitude: 37.7666, longitude: -122.427290)
    let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    let region = MKCoordinateRegion(center: centerCoordinate, span: span)
    mapView.setRegion(region, animated: true)
  }
  
  func updateUIView(_ uiView: MKMapView, context: Context) {
  }
  
  typealias UIViewType = MKMapView
}

//
//  VerifyNeighborhoodMap.swift
//  luzie-locke-ios
//
//  Created by Harry on 15.12.21.
//

import SwiftUI
import MapKit

struct VerifyNeighborhoodMap: UIViewRepresentable {

  class Coordinator: NSObject, MKMapViewDelegate {
    
    private let viewModel: VerifyNeighborhoodViewModel
    
    init(viewModel: VerifyNeighborhoodViewModel, mapView: MKMapView) {
      self.viewModel = viewModel
      super.init()
      
      mapView.delegate                  = self
      mapView.showsUserLocation         = true
    }
    
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
          viewModel.didChangeLocationPin(location: CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude))
        }
      }
    }
  }
  
  @EnvironmentObject var viewModel: VerifyNeighborhoodViewModel
  
  private let mapView = MKMapView()
  
  func makeCoordinator() -> Coordinator {
    return Coordinator(viewModel: viewModel, mapView: mapView)
  }
  
  func makeUIView(context: Context) -> MKMapView {
    return mapView
  }

  func updateUIView(_ uiView: MKMapView, context: Context) {
    uiView.removeOverlays(uiView.overlays)
    
    guard let currentCoordinate = viewModel.currentCoordinate else { return }
  
    let span = MKCoordinateSpan(latitudeDelta: 0.3, longitudeDelta: 0.3)
    let region = MKCoordinateRegion(center: currentCoordinate, span: span)
    uiView.setRegion(region, animated: true)
  }
    
  typealias UIViewType = MKMapView
}

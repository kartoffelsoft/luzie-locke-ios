//
//  NeighborhoodSettingMap.swift
//  luzie-locke-ios
//
//  Created by Harry on 04.12.21.
//

import SwiftUI
import MapKit

struct NeighborhoodSettingMap: UIViewRepresentable {

  class Coordinator: NSObject, MKMapViewDelegate {
    
    init(mapView: MKMapView) {
      super.init()
      mapView.delegate                  = self
      mapView.isZoomEnabled             = false
      mapView.isScrollEnabled           = false
      mapView.isUserInteractionEnabled  = false
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
      if let circleOverlay = overlay as? MKCircle {
        let renderer = MKCircleRenderer(overlay: circleOverlay)
        renderer.fillColor = .blue
        renderer.alpha = 0.5
        return renderer
      }

      return MKOverlayRenderer()
    }
  }
  
  @EnvironmentObject var viewModel: NeighborhoodSettingViewModel
  
  private let mapView = MKMapView()
  
  func makeCoordinator() -> Coordinator {
    return Coordinator(mapView: mapView)
  }
  
  func makeUIView(context: Context) -> MKMapView {
    return mapView
  }
  
  func updateUIView(_ uiView: MKMapView, context: Context) {
    uiView.removeOverlays(uiView.overlays)
    
    guard let currentRadius = viewModel.currentRadius,
          let currentSpanDelta = viewModel.currentSpanDelta,
          let currentCoordinate = viewModel.currentCoordinate else {
            return
          }
  
    let span = MKCoordinateSpan(latitudeDelta: currentSpanDelta, longitudeDelta: currentSpanDelta)
    let region = MKCoordinateRegion(center: currentCoordinate, span: span)
    uiView.setRegion(region, animated: true)
    
    let circle = MKCircle(center: currentCoordinate, radius: currentRadius * 1000 as CLLocationDistance)
    uiView.addOverlay(circle)
  }
  
  typealias UIViewType = MKMapView
}

//
//  MapViewController.swift
//  luzie-locke-iosTests
//
//  Created by Harry on 15.10.21.
//

import XCTest
import UIKit
import MapKit

@testable import luzie_locke_ios

class MapViewControllerTests: XCTestCase {
  
  var sut:                    MapViewController!
  var mockMKView:             MKViewMock!
  var mockCLLocationManager:  CLLocationManagerMock!
  
  override func setUpWithError() throws {
    try super.setUpWithError()
    
    mockMKView              = MKViewMock()
    mockCLLocationManager   = CLLocationManagerMock()
    sut                     = MapViewController(mapView: mockMKView, locationManager: mockCLLocationManager)
  }
  
  override func tearDownWithError() throws {
    sut = nil
    try super.tearDownWithError()
  }
  
  func givenViewIsLoaded() {
    sut?.beginAppearanceTransition(true, animated: true)
    sut?.endAppearanceTransition()
  }
  
  func whenAuthorized() {
    mockCLLocationManager.whenAuthorizationStatusIsAuthorizedWhenInUse()
  }
  
  func authorizationRequestShouldBeCalled(_ times: Int) {
    XCTAssertEqual(mockCLLocationManager.numRequestWhenInUseAuthorizationCalled, times)
  }
  
  func locationRequestShouldBeCalled(_ times: Int) {
    XCTAssertEqual(mockCLLocationManager.numStartUpdatingLocationCalled, times)
  }
  
  func testShouldRequestAuthorizationOnInit() {
    givenViewIsLoaded()
    authorizationRequestShouldBeCalled(1)
  }
  
  func testShouldRequestCurrentLocationWhenAuthorized() {
    givenViewIsLoaded()
    
    whenAuthorized()
    locationRequestShouldBeCalled(1)
  }
}

//
//  MyProfileUseCaseMock.swift
//  luzie-locke-iosTests
//
//  Created by Harry on 05.01.22.
//

import UIKit
@testable import luzie_locke_ios

class MyProfileUseCaseMock: MyProfileUseCaseProtocol {
  
  var fakeProfile: UserProfile?
  
  func setFakeProfile(_ fakeProfile: UserProfile?) {
    self.fakeProfile = fakeProfile
  }
  
  func getId() -> String? {
    guard let id = fakeProfile?.id else { return nil }
    return id
  }
  
  func getName() -> String? {
    guard let name = fakeProfile?.name else { return nil }
    return name
  }
  
  func getCity() -> String? {
    guard let city = fakeProfile?.city else { return nil }
    return city
  }
  
  func getImageUrl() -> String? {
    guard let imageUrl = fakeProfile?.imageUrl else { return nil }
    return imageUrl
  }
  
  func setLocalLevel(localLevel: Int) {
    
  }
  
  func setLocation(city: String, lat: Double, lng: Double) {

  }
  
  func isLocationSet() -> Bool {
    guard let _ = fakeProfile?.city else { return false }
    return true
  }
}

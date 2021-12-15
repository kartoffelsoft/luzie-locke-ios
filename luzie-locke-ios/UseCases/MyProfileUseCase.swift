//
//  MyProfileUseCase.swift
//  luzie-locke-ios
//
//  Created by Harry on 12.12.21.
//

import Foundation

protocol MyProfileUseCaseProtocol {
  
  func getId() -> String?
  
  func setLocalLevel(localLevel: Int)
  func setLocation(city: String, lat: Double, lng: Double)
}

class MyProfileUseCase: MyProfileUseCaseProtocol {

  private let localProfileRepository: LocalProfileRepositoryProtocol
  
  init(localProfileRepository: LocalProfileRepositoryProtocol) {
    self.localProfileRepository = localProfileRepository
  }
  
  func getId() -> String? {
    return localProfileRepository.read()?.id
  }
  
  func setLocalLevel(localLevel: Int) {
    guard let p = localProfileRepository.read() else { return }
    
    localProfileRepository.update(
      UserProfile(id: p.id, name: p.name, email: p.email, reputation: p.reputation,
                  imageUrl: p.imageUrl, localLevel: localLevel, city: p.city,
                  location: p.location))
  }
  
  func setLocation(city: String, lat: Double, lng: Double) {
    guard let p = localProfileRepository.read() else { return }
    
    localProfileRepository.update(
      UserProfile(id: p.id, name: p.name, email: p.email, reputation: p.reputation,
                  imageUrl: p.imageUrl, localLevel: p.localLevel, city: city,
                  location: UserProfile.Location(type: "Point", coordinates: [ lng, lat ])))
  }
}

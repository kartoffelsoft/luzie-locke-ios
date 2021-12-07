//
//  NeighbourhoodSettingViewModel.swift
//  luzie-locke-ios
//
//  Created by Harry on 06.12.21.
//

import MapKit

class NeighbourhoodSettingViewModel: NSObject, ObservableObject {
  
  @Published var currentCoordinate: CLLocationCoordinate2D?
  @Published var currentRadius: Double?
  @Published var currentRadiusText: String?
  @Published var currentSpanDelta: Double?
  
  private let coordinator:            SettingsCoordinator
  private let userProfileRepository:  UserProfileRepository
  
  private let levelToRadiusMap: [Int: Double] = [
    0: 3,
    1: 5,
    2: 10,
    3: 20,
    4: 30,
    5: 50,
    6: 100,
    7: 200,
    8: 300,
    9: 600
  ]
  
  private var currentLevel: Int? {
    didSet {
      guard let currentLevel = currentLevel else { return }
      currentRadius = levelToRadiusMap[currentLevel]
      if let currentRadius = currentRadius {
        currentRadiusText = "\(currentRadius) km"
        currentSpanDelta = currentRadius / 20
      }
    }
  }
  
  init(coordinator: SettingsCoordinator, userProfileRepository: UserProfileRepository) {
    self.coordinator            = coordinator
    self.userProfileRepository  = userProfileRepository
    super.init()
    
    currentLevel = 1
    currentRadius = levelToRadiusMap[1]
    currentRadiusText = "\(currentRadius!) km"
    currentSpanDelta = currentRadius! / 20
  }
  
  func didTapMinus() {
    guard let currentLevel = currentLevel else { return }
    self.currentLevel = max(currentLevel - 1, 0)
  }
  
  func didTapPlus() {
    guard let currentLevel = currentLevel else { return }
    self.currentLevel = min(currentLevel + 1, levelToRadiusMap.count - 1)
  }
}

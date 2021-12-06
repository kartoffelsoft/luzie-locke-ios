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
  
  private let coordinator:            SettingsCoordinator
  private let userProfileRepository:  UserProfileRepository
  
  private let levelToRadiusMap: [Int: Double] = [
    0: 0,
    1: 3,
    2: 5,
    3: 10,
    4: 20,
    5: 30,
    6: 50,
    7: 100,
    8: 200,
    9: 300
  ]
  
  private var currentLevel: Int? {
    didSet {
      guard let currentLevel = currentLevel else { return }
      currentRadius = levelToRadiusMap[currentLevel]
      currentRadiusText = "\(currentRadius!) km"
    }
  }
  
  init(coordinator: SettingsCoordinator, userProfileRepository: UserProfileRepository) {
    self.coordinator            = coordinator
    self.userProfileRepository  = userProfileRepository
    super.init()
    
    currentLevel = 1
    currentRadius = levelToRadiusMap[1]
    currentRadiusText = "\(currentRadius!) km"
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

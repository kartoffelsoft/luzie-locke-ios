//
//  NeighborhoodSettingViewModel.swift
//  luzie-locke-ios
//
//  Created by Harry on 06.12.21.
//

import MapKit

class NeighborhoodSettingViewModel: NSObject, ObservableObject {
  
  @Published var currentCoordinate: CLLocationCoordinate2D?
  @Published var currentRadius: Double?
  @Published var currentRadiusText: String?
  @Published var currentSpanDelta: Double?
  
  private let coordinator:        SettingsCoordinator
  private let settingsRepository: SettingsRepositoryProtocol
  
  private let localLevelToRadiusMap: [Int: Double] = [
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
  
  private var currentLocalLevel: Int? {
    didSet {
      guard let currentLocalLevel = currentLocalLevel else { return }
      currentRadius = localLevelToRadiusMap[currentLocalLevel]
      if let currentRadius = currentRadius {
        currentRadiusText = "\(currentRadius) km"
        currentSpanDelta = currentRadius / 20
      }
    }
  }
  
  init(coordinator: SettingsCoordinator, settingsRepository: SettingsRepositoryProtocol) {
    self.coordinator         = coordinator
    self.settingsRepository  = settingsRepository
    super.init()
    
    settingsRepository.readLocalLevel() { [weak self] result in
      guard let self = self else { return }
      switch(result) {
      case .success(let localLevel):
        DispatchQueue.main.async {
          self.currentLocalLevel = localLevel
        }
      case .failure(let error):
        print(error)
      }
    }
    
    settingsRepository.readLocation() { [weak self] result in
      guard let self = self else { return }
      switch(result) {
      case .success((_, let lat, let lng)):
        DispatchQueue.main.async {
          self.currentCoordinate = CLLocationCoordinate2D(latitude: lat, longitude: lng)
        }
      case .failure(let error):
        print(error)
      }
    }
  }
  
  func didTapMinus() {
    guard let currentLocalLevel = currentLocalLevel else { return }
    self.currentLocalLevel = max(currentLocalLevel - 1, 0)
  }
  
  func didTapPlus() {
    guard let currentLocalLevel = currentLocalLevel else { return }
    self.currentLocalLevel = min(currentLocalLevel + 1, localLevelToRadiusMap.count - 1)
  }
  
  func didTapApply() {
    guard let currentLocalLevel = currentLocalLevel else { return }
    settingsRepository.updateLocalLevel(localLevel: currentLocalLevel) { [weak self] result in
      guard let self = self else { return }
      switch(result) {
      case .success:
        self.coordinator.popViewController()
      case .failure(let error):
        print(error)
      }
    }
  }
}

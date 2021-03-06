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
  
  private let coordinator:     SettingsCoordinator
  private let settingsUseCase: SettingsUseCaseProtocol
  
  private var currentLocalLevel: Int? {
    didSet {
      guard let currentLocalLevel = currentLocalLevel else { return }
      currentRadius = RadiusSettingsConfig.map[currentLocalLevel]
      if let currentRadius = currentRadius {
        currentRadiusText = "\(currentRadius) km"
        currentSpanDelta = currentRadius / 20
      }
    }
  }
  
  init(coordinator: SettingsCoordinator, settingsUseCase: SettingsUseCaseProtocol) {
    self.coordinator     = coordinator
    self.settingsUseCase = settingsUseCase
    super.init()
    
    settingsUseCase.getLocalLevel() { [weak self] result in
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
    
    settingsUseCase.getLocation() { [weak self] result in
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
    self.currentLocalLevel = min(currentLocalLevel + 1, RadiusSettingsConfig.map.count - 1)
  }
  
  func didTapApply() {
    guard let currentLocalLevel = currentLocalLevel else { return }
    settingsUseCase.setLocalLevel(localLevel: currentLocalLevel) { [weak self] result in
      guard let self = self else { return }
      switch(result) {
      case .success:
        NotificationCenter.default.post(name: .didUpdateLocationSettings, object: nil)
        self.coordinator.popViewController()
      case .failure(let error):
        print(error)
      }
    }
  }
}

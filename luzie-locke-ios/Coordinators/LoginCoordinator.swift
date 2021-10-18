//
//  LoginCoordinator.swift
//  luzie-locke-ios
//
//  Created by Harry on 12.10.21.
//

import UIKit
import MapKit

class LoginCoordinator: Coordinator {
    var children = [Coordinator]()
    var navigationController: UINavigationController
    
    let userStorage: UserStorage
    let firebaseAuth: FirebaseAuthable
    let backendAuth: BackendAuthable
    
    init(navigationController: UINavigationController, userStorage: UserStorage, firebaseAuth: FirebaseAuthable, backendAuth: BackendAuthable) {
        self.navigationController = navigationController
        self.userStorage = userStorage
        self.firebaseAuth = firebaseAuth
        self.backendAuth = backendAuth
        
        self.navigationController.modalPresentationStyle = .fullScreen
    }
    
    func start() {
        let vm = LoginViewModel(coordinator: self, userStorage: userStorage, firebaseAuth: firebaseAuth, backendAuth: backendAuth)
        let vc = LoginViewController(viewModel: vm)
//        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    func navigateToMap(selectAction: @escaping MapViewCallback) {
        let vc = MapViewController(mapView: MKMapView(), locationManager: CLLocationManager())
        vc.selectAction = selectAction
        navigationController.pushViewController(vc, animated: true)
    }
    
    func popViewController() {
        navigationController.popViewController(animated: true)
    }
}

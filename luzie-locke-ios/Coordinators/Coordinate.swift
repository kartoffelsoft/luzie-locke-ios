//
//  File.swift
//  luzie-locke-ios
//
//  Created by Harry on 12.10.21.
//

import UIKit

protocol Coordinator {
    var children: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}

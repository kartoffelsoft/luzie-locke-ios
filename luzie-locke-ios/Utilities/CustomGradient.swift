//
//  CustomGradient.swift
//  luzie-locke-ios
//
//  Created by Harry on 28.10.21.
//

import UIKit

class CustomGradient {
  
  static func mainBackground(on view: UIView) -> UIImage? {
    let gradient        = CAGradientLayer()
    gradient.frame      = view.bounds
    gradient.startPoint = CGPoint(x: 0, y: 0)
    gradient.endPoint   = CGPoint(x: 0, y: 1)
    gradient.colors     = [ UIColor.custom.primaryColorLight3.cgColor,
                            UIColor.custom.primaryColorLight3.cgColor,
                            UIColor.custom.primaryColorLight2.cgColor,
                            UIColor.custom.primaryColorLight1.cgColor,
                            UIColor.custom.primaryColor.cgColor ]

    var image: UIImage?
    
    UIGraphicsBeginImageContext(view.frame.size)
    if let context = UIGraphicsGetCurrentContext() {
      gradient.render(in: context)
      image = UIGraphicsGetImageFromCurrentImageContext()?.resizableImage(withCapInsets: UIEdgeInsets.zero,
                                                                          resizingMode: .stretch)
    }
    UIGraphicsEndImageContext()
    
    return image
  }
  
  static func navBarBackground(on view: UIView) -> UIImage? {
    var bounds = view.bounds
    bounds.size.height += view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
    
    let gradient        = CAGradientLayer()
    gradient.frame      = bounds
    gradient.startPoint = CGPoint(x: 0, y: 0)
    gradient.endPoint   = CGPoint(x: 0, y: 1)
    gradient.colors     = [ UIColor.white.cgColor,
                            UIColor.white.cgColor,
                            UIColor.custom.primaryColorLight3.cgColor ]

    var image: UIImage?
    var size = view.frame.size
    size.height += view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
    
    UIGraphicsBeginImageContext(size)
    if let context = UIGraphicsGetCurrentContext() {
      gradient.render(in: context)
      image = UIGraphicsGetImageFromCurrentImageContext()?.resizableImage(withCapInsets: UIEdgeInsets.zero,
                                                                          resizingMode: .stretch)
    }
    UIGraphicsEndImageContext()
    
    return image
  }
}

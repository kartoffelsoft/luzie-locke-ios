//
//  UIViewController+Ext.swift
//  luzie-locke-ios
//
//  Created by Harry on 11.10.21.
//

import UIKit

fileprivate var containerView: UIView!

extension UIViewController {
  
  func presentAlertOnMainThread(title: String, message: String, buttonTitle: String, completion: (() -> Void)? = nil) {
    DispatchQueue.main.async {
      let alertVC = KAlertViewController(title: title, message: message, buttonTitle: buttonTitle)
      alertVC.modalPresentationStyle = .overFullScreen
      alertVC.modalTransitionStyle = .crossDissolve
      self.present(alertVC, animated: true, completion: completion)
    }
  }
  
  func showLoadingView() {
    containerView = UIView(frame: view.bounds)
    view.addSubview(containerView)
    
    containerView.backgroundColor   = .systemBackground
    containerView.alpha             = 0
    
    UIView.animate(withDuration: 0.25) { containerView.alpha = 0.3 }
    
    let activityIndicator = UIActivityIndicatorView(style: .large)
    containerView.addSubview(activityIndicator)
    
    activityIndicator.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      activityIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
      activityIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
    ])
    
    activityIndicator.startAnimating()
  }
  
  func dismissLoadingView() {
    DispatchQueue.main.async {
      containerView?.removeFromSuperview()
      containerView = nil
    }
  }
  
  func bindChildViewController(child: UIViewController, to parent: UIView) {
    addChild(child)
    parent.addSubview(child.view)
    child.view.frame = parent.bounds
    child.didMove(toParent: self)
  }
}

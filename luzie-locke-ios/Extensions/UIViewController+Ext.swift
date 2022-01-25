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
      let alertVC = AlertViewController(title: title, message: message, buttonTitle: buttonTitle)
      alertVC.modalPresentationStyle  = .overFullScreen
      alertVC.modalTransitionStyle    = .crossDissolve
      self.present(alertVC, animated: true, completion: completion)
    }
  }
  
  func presentConfirmOnMainThread(title: String, message: String, completion: (() -> Void)? = nil) {
    DispatchQueue.main.async {
      let viewController = ConfirmViewController(title: title, message: message, completion: completion)
      viewController.modalPresentationStyle  = .overFullScreen
      viewController.modalTransitionStyle    = .crossDissolve
      self.present(viewController, animated: true, completion: nil)
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
  
  func unbindChildViewController(child: UIViewController) {
    child.willMove(toParent: nil)
    child.view.removeFromSuperview()
    child.removeFromParent()
  }
  
  func showEmptyStateView(with message: String, in view: UIView) {
    let emptyStateView = EmptyStateView(message: message)
    emptyStateView.frame = view.bounds
    emptyStateView.tag   = 109
    view.addSubview(emptyStateView)
  }
  
  func removeEmptyStateView(in view: UIView) {
    if let viewWithTag = self.view.viewWithTag(109) {
      viewWithTag.removeFromSuperview()
    }
  }
}

//
//  AlertViewController.swift
//  luzie-locke-ios
//
//  Created by Harry on 23.09.21.
//

import UIKit

class AlertViewController: UIViewController {
  
  let containerView   = UIView()
  let titleLabel      = HeaderLabel(textAlignment: .center)
  let messageLabel    = BodyLabel(font: Fonts.body, textAlignment: .center)
  let actionButton    = BasicButton(backgroundColor: UIColor(named: "PrimaryColor"), title: "OK")
  
  var alertTitle:     String?
  var message:        String?
  var buttonTitle:    String?
  
  let padding:        CGFloat = 20
  
  init(title: String, message: String, buttonTitle: String) {
    super.init(nibName: nil, bundle: nil)
    self.alertTitle = title
    self.message = message
    self.buttonTitle = buttonTitle
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
    view.addSubview(containerView)
    containerView.addSubview(titleLabel)
    containerView.addSubview(actionButton)
    containerView.addSubview(messageLabel)
    configureContainerView()
    configureTitleLable()
    configureActionButton()
    configureMessageLabel()
  }
  
  func configureContainerView() {
    containerView.backgroundColor = .systemBackground
    containerView.layer.cornerRadius = 16
    containerView.layer.borderWidth = 2
    containerView.layer.borderColor = UIColor.white.cgColor
    containerView.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      containerView.widthAnchor.constraint(equalToConstant: 280),
      containerView.heightAnchor.constraint(equalToConstant: 220)
    ])
  }
  
  func configureTitleLable() {
    titleLabel.text = alertTitle ?? "Something went wrong"
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding),
      titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
      titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
      titleLabel.heightAnchor.constraint(equalToConstant: 28)
    ])
  }
  
  func configureActionButton() {
    actionButton.setTitle(buttonTitle ?? "OK", for: .normal)
    actionButton.addTarget(self, action: #selector(handleAction), for: .touchUpInside)
    
    NSLayoutConstraint.activate([
      actionButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -padding),
      actionButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
      actionButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
      actionButton.heightAnchor.constraint(equalToConstant: 44)
    ])
  }
  
  func configureMessageLabel() {
    messageLabel.text = message ?? "Unable to complete request"
    messageLabel.numberOfLines = 4
    messageLabel.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
      messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
      messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
      messageLabel.bottomAnchor.constraint(equalTo: actionButton.topAnchor, constant: -12),
    ])
  }
  
  @objc func handleAction() {
    dismiss(animated: true)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

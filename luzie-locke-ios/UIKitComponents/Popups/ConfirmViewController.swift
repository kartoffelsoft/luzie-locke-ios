//
//  ConfirmViewController.swift
//  luzie-locke-ios
//
//  Created by Harry on 28.11.21.
//

import UIKit

class ConfirmViewController: UIViewController {
  
  private let containerView   = UIView()
  private let titleLabel      = HeaderLabel(textAlignment: .center)
  private let messageLabel    = BodyLabel(font: CustomUIFonts.body, textAlignment: .center)
  
  let okayButton      = BasicButton(backgroundColor: UIColor(named: "PrimaryColor"), title: "OK")
  let cancelButton    = BasicButton(backgroundColor: UIColor(named: "TertiaryColor"), title: "Cancel")
  
  private var confirmTitle:   String?
  private var message:        String?
  private var completion:     (() -> Void)?
  
  private let padding:        CGFloat = 20
  
  init(title: String, message: String, completion: (() -> Void)? = nil) {
    super.init(nibName: nil, bundle: nil)
    self.confirmTitle = title
    self.message      = message
    self.completion   = completion
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
    view.addSubview(containerView)

    configureContainerView()
    configureTitleLabel()
    configureButtons()
    configureMessageLabel()
  }
  
  func configureContainerView() {
    containerView.backgroundColor     = CustomUIColors.primaryColorLight3
    containerView.layer.cornerRadius  = 16
    containerView.layer.borderWidth   = 2
    containerView.layer.borderColor   = UIColor.white.cgColor
    containerView.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      containerView.widthAnchor.constraint(equalToConstant: 280),
      containerView.heightAnchor.constraint(equalToConstant: 220)
    ])
  }
  
  func configureTitleLabel() {
    containerView.addSubview(titleLabel)
    
    titleLabel.text = confirmTitle ?? "Something went wrong"
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding),
      titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
      titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
      titleLabel.heightAnchor.constraint(equalToConstant: 28)
    ])
  }
  
  func configureButtons() {
    containerView.addSubview(okayButton)
    containerView.addSubview(cancelButton)
    
    okayButton.addTarget(self, action: #selector(handleOkayButtonTap), for: .touchUpInside)
    cancelButton.addTarget(self, action: #selector(handleCancelButtonTap), for: .touchUpInside)
    
    NSLayoutConstraint.activate([
      okayButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -padding),
      okayButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
      okayButton.trailingAnchor.constraint(equalTo: containerView.centerXAnchor, constant: -5),
      okayButton.heightAnchor.constraint(equalToConstant: 44),
      
      cancelButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -padding),
      cancelButton.leadingAnchor.constraint(equalTo: containerView.centerXAnchor, constant: 5),
      cancelButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
      cancelButton.heightAnchor.constraint(equalToConstant: 44)
    ])
  }
  
  func configureMessageLabel() {
    containerView.addSubview(messageLabel)
    messageLabel.text = message ?? "Unable to complete request"
    messageLabel.numberOfLines = 4
    messageLabel.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
      messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
      messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
      messageLabel.bottomAnchor.constraint(equalTo: okayButton.topAnchor, constant: -12),
    ])
  }
  
  @objc func handleOkayButtonTap() {
    dismiss(animated: true)
    completion?()
  }
  
  @objc func handleCancelButtonTap() {
    dismiss(animated: true)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

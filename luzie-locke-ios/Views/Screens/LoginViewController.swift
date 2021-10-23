//
//  LoginViewController.swift
//  luzie-locke-ios
//
//  Created by Harry on 10.10.21.
//

import UIKit

class LoginViewController: UIViewController {
  
  let viewModel       : LoginViewModel
  let googleButton    : UIButton
  
  init(viewModel: LoginViewModel) {
    self.viewModel      = viewModel
    googleButton        = UIButton(type: .system)
    super.init(nibName: nil, bundle: nil)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    viewModel.delegate                              = self
    navigationController?.navigationBar.isHidden    = true
    view.backgroundColor                            = .systemBackground
    
    configureButtons()
  }
  
  private func configureButtons() {
    googleButton.setImage(UIImage(named: "GoogleButton")?.withRenderingMode(.alwaysOriginal), for: .normal)
    googleButton.addTarget(self, action: #selector(handleGoogleButtonEvent), for: .touchUpInside)
    
    let stackView = UIStackView(arrangedSubviews: [ googleButton ])
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis                                      = .vertical
    
    view.addSubview(stackView)
    
    NSLayoutConstraint.activate([
      stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      googleButton.widthAnchor.constraint(equalToConstant: 300),
      googleButton.heightAnchor.constraint(equalToConstant: 95)
    ])
  }
  
  @objc private func handleGoogleButtonEvent() {
    viewModel.performGoogleLogin(self)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension LoginViewController: LoginViewModelDelegate {
  
  func didLogin() {
    DispatchQueue.main.async {
      self.dismiss(animated: true)
    }
  }
  
  func didReceiveError(_ error: LLError) {
    presentAlertOnMainThread(
      title: "Unable to complete",
      message: error.rawValue,
      buttonTitle: "OK")
  }
}

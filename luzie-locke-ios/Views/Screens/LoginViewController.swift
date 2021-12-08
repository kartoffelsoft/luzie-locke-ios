//
//  LoginViewController.swift
//  luzie-locke-ios
//
//  Created by Harry on 10.10.21.
//

import UIKit

class LoginViewController: UIViewController {
  
  let viewModel       : LoginViewModel
  
  private let googleButton = UIButton(type: .system)
  private let loginButton = BasicButton(backgroundColor: CustomUIColors.primaryColor, title: "LOGIN")
  private let dividerView = DividerView()
  
  private let titleLabel: CustomLabel = {
    let label = CustomLabel(font: CustomUIFonts.title, textColor: CustomUIColors.primaryColor)
    label.textAlignment = .center
    label.text = "Log in"
    return label
  }()
  
  private let subTextLabel: CustomLabel = {
    let label = CustomLabel(font: CustomUIFonts.caption, textColor: CustomUIColors.primaryColorLight1)
    label.text = "No account?"
    return label
  }()
  
  private var goToSignUpButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Sign up", for: .normal)
    button.setTitleColor(CustomUIColors.tertiaryColor, for: .normal)
    
    button.translatesAutoresizingMaskIntoConstraints = false
    button.titleLabel?.font = CustomUIFonts.caption
    //      button.addTarget(self, action: #selector(handleGoToLogin), for: .touchUpInside)
    return button
  }()
  
  let emailTextField: BasicTextField = {
    let textField = BasicTextField(padding: 32, height: 50)
    textField.placeholder = "Enter email"
    textField.keyboardType = .emailAddress

    textField.leftView = UIImageView(image: CustomUIImages.envelope.withTintColor(CustomUIColors.primaryColorLight1, renderingMode: .alwaysOriginal))
    textField.leftViewMode = .always
    textField.layer.sublayerTransform = CATransform3DMakeTranslation(12, 0, 0);
    
//    textField.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
    return textField
  }()
  
  let passwordTextField: BasicTextField = {
    let textField = BasicTextField(padding: 30, height: 50)
    textField.placeholder = "Enter password"
    textField.isSecureTextEntry = true
    
    textField.leftView = UIImageView(image: CustomUIImages.lock.withTintColor(CustomUIColors.primaryColorLight1, renderingMode: .alwaysOriginal))
    textField.leftViewMode = .always
    textField.layer.sublayerTransform = CATransform3DMakeTranslation(14, 0, 0);
    
    //    textField.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
    return textField
  }()
  
  init(viewModel: LoginViewModel) {
    self.viewModel      = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    viewModel.delegate                              = self
    navigationController?.navigationBar.isHidden    = true
    view.backgroundColor                            = .systemBackground
    
    configureBackground()
    configureLayout()
  }
  
  private func configureBackground() {
    if let image = CustomGradient.mainBackground(on: view) {
      view.backgroundColor = UIColor(patternImage: image)
    }
  }
  
  private func configureLayout() {
    googleButton.setImage(UIImage(named: "GoogleButton")?.withRenderingMode(.alwaysOriginal), for: .normal)
    googleButton.addTarget(self, action: #selector(handleGoogleButtonEvent), for: .touchUpInside)
    
    let titleContainerView = makeTitleContainerView()
    
    let inputContainerView = UIStackView(arrangedSubviews: [ emailTextField, passwordTextField, loginButton ])
    inputContainerView.translatesAutoresizingMaskIntoConstraints  = false
    inputContainerView.axis                                       = .vertical
    inputContainerView.spacing                                    = 8
    
    let containerView = UIStackView(arrangedSubviews: [ titleContainerView, inputContainerView, dividerView, googleButton ])
    containerView.translatesAutoresizingMaskIntoConstraints = false
    containerView.axis                                      = .vertical
    containerView.spacing                                   = 25
    
    view.addSubview(containerView)
    
    NSLayoutConstraint.activate([
      containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100),
      containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      
      emailTextField.widthAnchor.constraint(greaterThanOrEqualToConstant: 300),
      passwordTextField.widthAnchor.constraint(greaterThanOrEqualToConstant: 300),
      loginButton.heightAnchor.constraint(equalToConstant: 45)
    ])
  }
  
  private func makeTitleContainerView() -> UIView {
    let subTextContainerView = UIStackView(arrangedSubviews: [ subTextLabel, goToSignUpButton ])
    subTextContainerView.translatesAutoresizingMaskIntoConstraints  = false
    subTextContainerView.axis = .horizontal
    subTextContainerView.spacing = 5
    
    let titleContainerView = UIView()
    titleContainerView.translatesAutoresizingMaskIntoConstraints  = false
    titleContainerView.addSubview(titleLabel)
    titleContainerView.addSubview(subTextContainerView)
    
    NSLayoutConstraint.activate([
      titleContainerView.widthAnchor.constraint(equalToConstant: 300),
      titleContainerView.heightAnchor.constraint(equalToConstant: 50),
    
      titleLabel.centerXAnchor.constraint(equalTo: titleContainerView.centerXAnchor),
      subTextContainerView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
      subTextContainerView.centerXAnchor.constraint(equalTo: titleContainerView.centerXAnchor),
    ])
    
    return titleContainerView
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
  
  func didGetError(_ error: LLError) {
    presentAlertOnMainThread(
      title: "Unable to complete",
      message: error.rawValue,
      buttonTitle: "OK")
  }
}

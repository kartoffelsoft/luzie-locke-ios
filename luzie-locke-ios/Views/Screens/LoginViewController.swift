//
//  LoginViewController.swift
//  luzie-locke-ios
//
//  Created by Harry on 10.10.21.
//

import UIKit

class LoginViewController: UIViewController {
  
  let viewModel       : LoginViewModel
  
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
  
  private let googleButton: UIButton = {
    let button = UIButton(type: .system)
    button.setImage(UIImage(named: "GoogleButton")?.withRenderingMode(.alwaysOriginal), for: .normal)
    return button
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
    configureHandlers()
  }
  
  private func configureBackground() {
    if let image = CustomGradient.mainBackground(on: view) {
      view.backgroundColor = UIColor(patternImage: image)
    }
  }
  
  private func configureLayout() {
    let titleContainerView      = makeTitleContainerView()
    let emailLoginContainerView = makeEmailLoginContainerView()

    let containerView = UIStackView(
      arrangedSubviews: [ titleContainerView, emailLoginContainerView, dividerView, googleButton ])
    
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
    let subContainerView = UIStackView(arrangedSubviews: [ subTextLabel, goToSignUpButton ])
    subContainerView.translatesAutoresizingMaskIntoConstraints  = false
    subContainerView.axis = .horizontal
    subContainerView.spacing = 5
    
    let containerView = UIView()
    containerView.translatesAutoresizingMaskIntoConstraints  = false
    containerView.addSubview(titleLabel)
    containerView.addSubview(subContainerView)
    
    NSLayoutConstraint.activate([
      containerView.widthAnchor.constraint(equalToConstant: 300),
      containerView.heightAnchor.constraint(equalToConstant: 50),
    
      titleLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
      subContainerView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
      subContainerView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
    ])
    
    return containerView
  }
  
  private func makeEmailLoginContainerView() -> UIView {
    let view = UIStackView(arrangedSubviews: [ emailTextField, passwordTextField, loginButton ])
    view.translatesAutoresizingMaskIntoConstraints  = false
    view.axis                                       = .vertical
    view.spacing                                    = 8
    return view
  }
  
  private func configureHandlers() {
    goToSignUpButton.addTarget(self, action: #selector(handleGoToSignUpButtonTap), for: .touchUpInside)
    loginButton.addTarget(self, action: #selector(handleLoginButtonTap), for: .touchUpInside)
    googleButton.addTarget(self, action: #selector(handleGoogleButtonTap), for: .touchUpInside)
  }
  
  @objc private func handleGoToSignUpButtonTap() {
    print("handleGoToSignUpButtonTap")
  }
  
  @objc private func handleLoginButtonTap() {
    print("handleLoginButtonTap")
  }
  
  @objc private func handleGoogleButtonTap() {
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

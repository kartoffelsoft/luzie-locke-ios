//
//  LoginViewController.swift
//  luzie-locke-ios
//
//  Created by Harry on 10.10.21.
//

import UIKit

class LoginViewController: UIViewController {
  
  let viewModel: LoginViewModel
  
  private let loginButton = BasicButton(backgroundColor: UIColor.custom.primaryColor, title: "LOGIN")
  private let dividerView = DividerView()
  
  private let titleLabel: CustomLabel = {
    let label = CustomLabel(font: CustomUIFonts.title, textColor: UIColor.custom.primaryColor)
    label.textAlignment = .center
    label.text = "Log in"
    return label
  }()
  
  private let subTextLabel: CustomLabel = {
    let label = CustomLabel(font: CustomUIFonts.caption, textColor: UIColor.custom.primaryColorLight1)
    label.text = "No account?"
    return label
  }()
  
  private var goToSignUpButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Sign up", for: .normal)
    button.setTitleColor(UIColor.custom.tertiaryColor, for: .normal)
    
    button.translatesAutoresizingMaskIntoConstraints = false
    button.titleLabel?.font = CustomUIFonts.caption
    return button
  }()
  
  private let emailTextField: BasicTextField = {
    let textField = BasicTextField(padding: 32, height: 50)
    textField.placeholder = "Enter email"
    textField.keyboardType = .emailAddress

    textField.leftView = UIImageView(image: CustomUIImages.envelope.withTintColor(UIColor.custom.primaryColorLight1, renderingMode: .alwaysOriginal))
    textField.leftViewMode = .always
    textField.layer.sublayerTransform = CATransform3DMakeTranslation(12, 0, 0);
    
//    textField.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
    return textField
  }()
  
  private let passwordTextField: BasicTextField = {
    let textField = BasicTextField(padding: 30, height: 50)
    textField.placeholder = "Enter password"
    textField.isSecureTextEntry = true
    
    textField.leftView = UIImageView(image: CustomUIImages.lock.withTintColor(UIColor.custom.primaryColorLight1, renderingMode: .alwaysOriginal))
    textField.leftViewMode = .always
    textField.layer.sublayerTransform = CATransform3DMakeTranslation(14, 0, 0);
    
    //    textField.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
    return textField
  }()
  
  private let googleButton: UIButton = {
    let button = UIButton(type: .system)
    button.setBackgroundImage(UIImage(named: "GoogleButton")?.withRenderingMode(.alwaysOriginal), for: .normal)
    button.imageView?.contentMode = .scaleAspectFit
    button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
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
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    viewModel.viewDidAppear()
  }
  
  private func configureBackground() {
    if let image = CustomGradient.mainBackground(on: view) {
      view.backgroundColor = UIColor(patternImage: image)
    }
  }
  
  private func configureLayout() {
    let titleContainerView      = makeTitleContainerView()
    let emailLoginContainerView = makeEmailLoginContainerView()
    let thirdPartyContainerView = makeThirdPartyContainerView()

    let containerView = UIStackView(
      arrangedSubviews: [ titleContainerView, emailLoginContainerView, dividerView, thirdPartyContainerView ])
    
    containerView.translatesAutoresizingMaskIntoConstraints = false
    containerView.axis                                      = .vertical
    containerView.spacing                                   = 25
    
    view.addSubview(containerView)
    
    NSLayoutConstraint.activate([
      containerView.widthAnchor.constraint(equalToConstant: 300),
      containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100),
      containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
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
    
    NSLayoutConstraint.activate([
      loginButton.heightAnchor.constraint(equalToConstant: 45),
    ])
    
    return view
  }
  
  private func makeThirdPartyContainerView() -> UIView {
    let view = UIStackView(arrangedSubviews: [ googleButton ])
    view.translatesAutoresizingMaskIntoConstraints  = false
    view.axis                                       = .vertical
    view.spacing                                    = 8
    view.alignment                                  = .center
    
    NSLayoutConstraint.activate([
      googleButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6),
      googleButton.heightAnchor.constraint(equalTo: googleButton.widthAnchor, multiplier: 0.25)
    ])
    
    return view
  }
  
  private func configureHandlers() {
    goToSignUpButton.addTarget(self, action: #selector(handleGoToSignUpButtonTap), for: .touchUpInside)
    loginButton.addTarget(self, action: #selector(handleLoginButtonTap), for: .touchUpInside)
    googleButton.addTarget(self, action: #selector(handleGoogleButtonTap), for: .touchUpInside)
  }
  
  @objc private func handleGoToSignUpButtonTap() {
    viewModel.didTapGoToSignUp()
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

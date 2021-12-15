//
//  SignUpViewController.swift
//  luzie-locke-ios
//
//  Created by Harry on 15.12.21.
//

import UIKit

class SignUpViewController: UIViewController {
  
  let viewModel: SignUpViewModel
  
  private let signUpButton = BasicButton(backgroundColor: CustomUIColors.primaryColor, title: "SIGN UP")
  
  private let titleLabel: CustomLabel = {
    let label = CustomLabel(font: CustomUIFonts.title, textColor: CustomUIColors.primaryColor)
    label.textAlignment = .center
    label.text = "Sign up"
    return label
  }()
  
  private let subTextLabel: CustomLabel = {
    let label = CustomLabel(font: CustomUIFonts.caption, textColor: CustomUIColors.primaryColorLight1)
    label.text = "Already member?"
    return label
  }()
  
  private var goToLoginButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Login", for: .normal)
    button.setTitleColor(CustomUIColors.tertiaryColor, for: .normal)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.titleLabel?.font = CustomUIFonts.caption
    return button
  }()
  
  private let nameTextField: BasicTextField = {
    let textField = BasicTextField(padding: 32, height: 50)
    textField.placeholder = "Enter name"
    textField.keyboardType = .emailAddress

    textField.leftView = UIImageView(image: CustomUIImages.person.withTintColor(CustomUIColors.primaryColorLight1, renderingMode: .alwaysOriginal))
    textField.leftViewMode = .always
    textField.layer.sublayerTransform = CATransform3DMakeTranslation(12, 0, 0);
    return textField
  }()
  
  private let emailTextField: BasicTextField = {
    let textField = BasicTextField(padding: 32, height: 50)
    textField.placeholder = "Enter email"
    textField.keyboardType = .emailAddress

    textField.leftView = UIImageView(image: CustomUIImages.envelope.withTintColor(CustomUIColors.primaryColorLight1, renderingMode: .alwaysOriginal))
    textField.leftViewMode = .always
    textField.layer.sublayerTransform = CATransform3DMakeTranslation(12, 0, 0);
    return textField
  }()
  
  private let passwordTextField: BasicTextField = {
    let textField = BasicTextField(padding: 30, height: 50)
    textField.placeholder = "Enter password"
    textField.isSecureTextEntry = true
    
    textField.leftView = UIImageView(image: CustomUIImages.lock.withTintColor(CustomUIColors.primaryColorLight1, renderingMode: .alwaysOriginal))
    textField.leftViewMode = .always
    textField.layer.sublayerTransform = CATransform3DMakeTranslation(14, 0, 0)
    return textField
  }()
  
  private let verifyPasswordTextField: BasicTextField = {
    let textField = BasicTextField(padding: 32, height: 50)
    textField.placeholder = "Verify password"
    textField.isSecureTextEntry = true
    
    textField.leftView = UIImageView(image: CustomUIImages.verify.withTintColor(CustomUIColors.primaryColorLight1, renderingMode: .alwaysOriginal))
    textField.leftViewMode = .always
    textField.layer.sublayerTransform = CATransform3DMakeTranslation(12, 0, 0);
    return textField
  }()
  
  init(viewModel: SignUpViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()

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
      arrangedSubviews: [ titleContainerView, emailLoginContainerView ])
    
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
    let subContainerView = UIStackView(arrangedSubviews: [ subTextLabel, goToLoginButton ])
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
    let view = UIStackView(arrangedSubviews: [ nameTextField, emailTextField, passwordTextField, verifyPasswordTextField, signUpButton ])
    view.translatesAutoresizingMaskIntoConstraints  = false
    view.axis                                       = .vertical
    view.spacing                                    = 8
    
    NSLayoutConstraint.activate([
      signUpButton.heightAnchor.constraint(equalToConstant: 45),
    ])
    
    return view
  }
  
  private func configureHandlers() {
    goToLoginButton.addTarget(self, action: #selector(handleGoToLoginButtonTap), for: .touchUpInside)
    signUpButton.addTarget(self, action: #selector(handleSignUpButtonTap), for: .touchUpInside)
  }
  
  @objc private func handleGoToLoginButtonTap() {
    viewModel.didTapGoToLogin()
  }
  
  @objc private func handleSignUpButtonTap() {
    print("handleLoginButtonTap")
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

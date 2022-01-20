//
//  SignUpViewController.swift
//  luzie-locke-ios
//
//  Created by Harry on 15.12.21.
//

import UIKit
import Combine

class SignUpViewController: UIViewController {
  
  var viewModel: SignUpViewModel?
  
  private var signUpButtonSubscriber: AnyCancellable?
  private var formErrorTextSubscriber: AnyCancellable?
  
  private let signUpButton: BasicButton = {
    let button = BasicButton(backgroundColor: UIColor.custom.primaryColor, title: "SIGN UP")
    button.isEnabled = false
    button.addTarget(self, action: #selector(handleSignUpButtonTap), for: .touchUpInside)
    return button
  }()
  
  private let titleLabel: CustomLabel = {
    let label = CustomLabel(font: CustomUIFonts.title, textColor: UIColor.custom.primaryColor)
    label.textAlignment = .center
    label.text = "Sign up"
    return label
  }()
  
  private let subTextLabel: CustomLabel = {
    let label = CustomLabel(font: CustomUIFonts.caption, textColor: UIColor.custom.primaryColorLight1)
    label.text = "Already member?"
    return label
  }()
  
  private let formErrorTextLabel: CustomLabel = {
    let label = CustomLabel(font: CustomUIFonts.caption, textColor: .red)
    return label
  }()
  
  private var goToLoginButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Login", for: .normal)
    button.setTitleColor(UIColor.custom.tertiaryColor, for: .normal)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.titleLabel?.font = CustomUIFonts.caption
    button.addTarget(self, action: #selector(handleGoToLoginButtonTap), for: .touchUpInside)
    return button
  }()
  
  private let nameTextField: BasicTextField = {
    let textField = BasicTextField(padding: 32, height: 50)
    textField.placeholder = "Enter name"

    textField.leftView = UIImageView(image: CustomUIImages.person.withTintColor(UIColor.custom.primaryColorLight1, renderingMode: .alwaysOriginal))
    textField.leftViewMode = .always
    textField.layer.sublayerTransform = CATransform3DMakeTranslation(12, 0, 0);
    textField.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
    return textField
  }()
  
  private let emailTextField: BasicTextField = {
    let textField = BasicTextField(padding: 32, height: 50)
    textField.placeholder = "Enter email"
    textField.autocapitalizationType = .none
    
    textField.leftView = UIImageView(image: CustomUIImages.envelope.withTintColor(UIColor.custom.primaryColorLight1, renderingMode: .alwaysOriginal))
    textField.leftViewMode = .always
    textField.layer.sublayerTransform = CATransform3DMakeTranslation(12, 0, 0)
    textField.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
    return textField
  }()
  
  private let passwordTextField: BasicTextField = {
    let textField = BasicTextField(padding: 30, height: 50)
    textField.placeholder = "Enter password"
    textField.isSecureTextEntry = true
    
    textField.leftView = UIImageView(image: CustomUIImages.lock.withTintColor(UIColor.custom.primaryColorLight1, renderingMode: .alwaysOriginal))
    textField.leftViewMode = .always
    textField.layer.sublayerTransform = CATransform3DMakeTranslation(14, 0, 0)
    textField.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
    return textField
  }()
  
  private let passwordAgainTextField: BasicTextField = {
    let textField = BasicTextField(padding: 32, height: 50)
    textField.placeholder = "Verify password"
    textField.isSecureTextEntry = true
    textField.autocorrectionType = .no
    
    textField.leftView = UIImageView(image: CustomUIImages.verify.withTintColor(UIColor.custom.primaryColorLight1, renderingMode: .alwaysOriginal))
    textField.leftViewMode = .always
    textField.layer.sublayerTransform = CATransform3DMakeTranslation(12, 0, 0)
    textField.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
    return textField
  }()
  
  init() {
    super.init(nibName: nil, bundle: nil)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()

    navigationController?.navigationBar.isHidden    = true
    view.backgroundColor                            = .systemBackground
    
    configureBackground()
    configureLayout()
    configureSubscriber()
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
    view.addSubview(formErrorTextLabel)
    
    NSLayoutConstraint.activate([
      containerView.widthAnchor.constraint(equalToConstant: 300),
      containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100),
      containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      
      formErrorTextLabel.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 15),
      formErrorTextLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
    ])
  }
  
  private func configureSubscriber() {
    signUpButtonSubscriber = viewModel?.isSignUpButtonEnabled
      .receive(on: RunLoop.main)
      .assign(to: \.isEnabled, on: signUpButton)
    
    formErrorTextSubscriber = viewModel?.formErrorText
      .receive(on: RunLoop.main)
      .sink(receiveValue: { [weak self] text in
        self?.formErrorTextLabel.text = text
      })
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
    let view = UIStackView(arrangedSubviews: [ nameTextField, emailTextField, passwordTextField, passwordAgainTextField, signUpButton])
    
    view.translatesAutoresizingMaskIntoConstraints  = false
    view.axis                                       = .vertical
    view.spacing                                    = 8
    
    NSLayoutConstraint.activate([
      signUpButton.heightAnchor.constraint(equalToConstant: 45),
    ])
    
    return view
  }
  
  @objc private func handleGoToLoginButtonTap() {
    viewModel?.didTapGoToLogin()
  }
  
  @objc private func handleSignUpButtonTap() {
    print("handleLoginButtonTap")
  }
  
  @objc fileprivate func handleTextChange(textField: UITextField) {
    guard let text = textField.text else { return }
    
    switch(textField) {
    case nameTextField:
      viewModel?.name = text
    case emailTextField:
      viewModel?.email = text
    case passwordTextField:
      viewModel?.password = text
    case passwordAgainTextField:
      viewModel?.passwordAgain = text
    default: ()
    }
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

//
//  ItemUpdateViewController.swift
//  luzie-locke-ios
//
//  Created by Harry on 02.12.21.
//

import UIKit

class ItemUpdateViewController: UIViewController {
  
  private let scrollView            = UIScrollView()
  private let contentView           = UIView()
  
  private let titleInputView        = SingleLineTextInputView()
  private let priceInputView        = SingleLineDecimalInputView()
  private let descriptionInputView  = MultiLineTextInputView()
  private let imageSelectView       = ImageSelectView()
  
  private let viewModel: ItemUpdateViewModel
  
  private let imageSelectViewHeight:  CGFloat = 60
  
  init(viewModel: ItemUpdateViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
    self.viewModel.delegate = self
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    titleInputView.viewModel          = viewModel.titleViewModel
    priceInputView.viewModel          = viewModel.priceViewModel
    descriptionInputView.viewModel    = viewModel.descriptionViewModel
    imageSelectView.viewModel         = viewModel.imageSelectViewModel
    
    descriptionInputView.delegate = self
    
    configureBackground()
    configureNavigationBar()
    configureLayout()
    configureKeyboardInput()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    tabBarController?.tabBar.isHidden = true
  }

  private func configureBackground() {
    if let image = CustomGradient.mainBackground(on: view) {
      view.backgroundColor = UIColor(patternImage: image)
    }
  }
  
  private func configureNavigationBar() {
    navigationItem.rightBarButtonItem = UIBarButtonItem(image: Images.upload, style: .plain, target: self, action: #selector(handleUploadButtonTap))
  }
  
  private func configureLayout() {
    scrollView.translatesAutoresizingMaskIntoConstraints  = false

    view.addSubview(scrollView)
    view.addSubview(imageSelectView)
    
    scrollView.addSubview(titleInputView)
    scrollView.addSubview(priceInputView)
    scrollView.addSubview(descriptionInputView)

    let padding: CGFloat = 10
    
    NSLayoutConstraint.activate([
      scrollView.topAnchor.constraint(equalTo: view.topAnchor),
      scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      scrollView.bottomAnchor.constraint(equalTo: imageSelectView.topAnchor),
      
      titleInputView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
      titleInputView.topAnchor.constraint(equalTo: scrollView.topAnchor),
      titleInputView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -padding * 2),
      titleInputView.heightAnchor.constraint(equalToConstant: 40),
      
      priceInputView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
      priceInputView.topAnchor.constraint(equalTo: titleInputView.bottomAnchor),
      priceInputView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -padding * 2),
      priceInputView.heightAnchor.constraint(equalToConstant: 40),
      
      descriptionInputView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
      descriptionInputView.topAnchor.constraint(equalTo: priceInputView.bottomAnchor),
      descriptionInputView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -padding * 2),
      descriptionInputView.heightAnchor.constraint(greaterThanOrEqualToConstant: 300),
      
      imageSelectView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      imageSelectView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      imageSelectView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
      imageSelectView.heightAnchor.constraint(equalToConstant: imageSelectViewHeight)
    ])
  }
  
  private func configureKeyboardInput() {
    NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardShow), name: UIResponder.keyboardWillHideNotification, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardShow), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
  }

  @objc private func handleKeyboardShow(notification:NSNotification) {
    guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }

    let keyboardScreenEndFrame = keyboardValue.cgRectValue
    let keyboardViewEndFrame   = view.convert(keyboardScreenEndFrame, from: view.window)

    if notification.name == UIResponder.keyboardWillHideNotification {
      scrollView.contentInset = .zero
//      imageSelectView.frame.origin.y = imageSelectViewOriginY
//      UIView.animate(withDuration: 100) {
//        self.view.layoutIfNeeded()
//      }
    } else {
      scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height - view.safeAreaInsets.bottom - imageSelectViewHeight, right: 0)
      
//      imageSelectView.frame.origin.y = keyboardViewEndFrame.minY - imageSelectViewHeight
//      UIView.animate(withDuration: 100) {
//        self.view.layoutIfNeeded()
//      }
    }

    scrollView.scrollIndicatorInsets = scrollView.contentInset
  }
  
  @objc private func handleUploadButtonTap() {
    viewModel.upload { [weak self] result in
      switch result {
      case .success: ()
      case .failure(let error):
        self?.presentAlertOnMainThread(title: "Unable to proceed",
                                       message: error.rawValue,
                                       buttonTitle: "OK")
      }
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension ItemUpdateViewController: MultiLineTextInputViewDelegate {

  func didChangeInput(_ textView: UITextView) {
    scrollView.contentSize = CGSize(width: scrollView.frame.size.width, height: textView.frame.height + titleInputView.frame.height + 30);
  }
}

extension ItemUpdateViewController: ItemUpdateViewModelDelegate {

  func didOpenImagePicker(controller: UIImagePickerController) {
    present(controller, animated: true)
  }

  func didCloseImagePicker() {
    dismiss(animated: true)
  }
}

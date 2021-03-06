//
//  ChatViewController.swift
//  luzie-locke-ios
//
//  Created by Harry on 08.11.21.
//

import UIKit
import Firebase

class ChatViewController: UICollectionViewController {

  var viewModel: ChatViewModel?
  
  private var chatInputAccessoryView: ChatInputAccessoryView!

  init() {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    
    super.init(collectionViewLayout: layout)
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureCollectionView()
    configureKeyboardInput()
    configureBindables()
    
    viewModel?.didLoad()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    self.becomeFirstResponder()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    
    if isMovingFromParent {
      viewModel?.willDisappear()
    }
  }
  
  private func configureCollectionView() {
    collectionView.backgroundColor = .clear
    collectionView.alwaysBounceVertical = true
    collectionView.keyboardDismissMode  = .interactive
    collectionView.alwaysBounceVertical = true
    collectionView.register(ChatMessageCell.self, forCellWithReuseIdentifier: ChatMessageCell.reuseIdentifier)
    
    view.addSubview(collectionView)
  }

  private func configureKeyboardInput() {
    NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardShow), name: UIResponder.keyboardDidShowNotification, object: nil)

    chatInputAccessoryView = ChatInputAccessoryView(frame: .init(x: 0, y: 0, width: view.frame.width, height: 60))
    chatInputAccessoryView.sendButton.addTarget(self, action: #selector(handleSendButtonTap), for: .touchUpInside)
  }
  
  private func configureBindables() {
    viewModel?.bindableMessages.bind { [weak self] messages in
      if let messages = messages {
        self?.collectionView.reloadData()
        self?.collectionView.scrollToItem(at: [0, messages.count - 1], at: .bottom, animated: true)
      }
    }
  }
  
  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if let messages = viewModel?.bindableMessages.value {
      return messages.count
    }
    return 0
  }

  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChatMessageCell.reuseIdentifier, for: indexPath) as! ChatMessageCell
    cell.message = viewModel?.bindableMessages.value![indexPath.row]
    return cell
  }
  
  override var inputAccessoryView: UIView? {
    get {
      return chatInputAccessoryView
    }
  }

  override var canBecomeFirstResponder: Bool {
    return true
  }
  
  @objc private func handleSendButtonTap() {
    guard let text = chatInputAccessoryView.textField.text else { return }
    if text.isEmpty { return }
    
    viewModel?.didTapSend(text: text)
    chatInputAccessoryView.textField.text = ""
  }

  @objc private func handleKeyboardShow() {
    guard let count = viewModel?.bindableMessages.value?.count else { return }
    collectionView.scrollToItem(at: [0, count - 1],
                                at: .bottom,
                                animated: false)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension ChatViewController: UICollectionViewDelegateFlowLayout {

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let estimatedSizeCell = ChatMessageCell(frame: .init(x: 0, y: 0, width: view.frame.width, height: 1000))
    estimatedSizeCell.message = viewModel?.bindableMessages.value![indexPath.row]
    estimatedSizeCell.layoutIfNeeded()

    let estimatedSize = estimatedSizeCell.systemLayoutSizeFitting(.init(width: view.frame.width, height: 1000))
    return .init(width: view.frame.width, height: estimatedSize.height)
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return .init(top: 16, left: 0, bottom: 16, right: 0)
  }
}

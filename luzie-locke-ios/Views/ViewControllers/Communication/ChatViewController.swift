//
//  ChatViewController.swift
//  luzie-locke-ios
//
//  Created by Harry on 08.11.21.
//

import UIKit
import Firebase

class ChatViewController: UIViewController {
  
  private var collectionView: UICollectionView!
  private var chatInputAccessoryView: ChatInputAccessoryView!
  
  private var messages: [Message] = [
    Message(text: "Hi1", isFromCurrentUser: true, fromId: "abc", toId: "bbb", timestamp: Timestamp()),
    Message(text: "Hi2, who is this?", isFromCurrentUser: false, fromId: "abc", toId: "bbb", timestamp: Timestamp()),
    Message(text: "3I would like to know if it is available.", isFromCurrentUser: true, fromId: "abc", toId: "bbb", timestamp: Timestamp()),
    Message(text: "sorry4, it's been sold out.", isFromCurrentUser: false, fromId: "abc", toId: "bbb", timestamp: Timestamp()),
    Message(text: "Hi", isFromCurrentUser: true, fromId: "abc", toId: "bbb", timestamp: Timestamp()),
    Message(text: "Hi, who is this?", isFromCurrentUser: false, fromId: "abc", toId: "bbb", timestamp: Timestamp()),
    Message(text: "I would like to know if it is available.", isFromCurrentUser: true, fromId: "abc", toId: "bbb", timestamp: Timestamp()),
    Message(text: "sorry, it's been sold out.", isFromCurrentUser: false, fromId: "abc", toId: "bbb", timestamp: Timestamp()),
    Message(text: "sorry, it's been sold out.", isFromCurrentUser: false, fromId: "abc", toId: "bbb", timestamp: Timestamp()),
    Message(text: "Hi", isFromCurrentUser: true, fromId: "abc", toId: "bbb", timestamp: Timestamp()),
    Message(text: "Hi, who is this?", isFromCurrentUser: false, fromId: "abc", toId: "bbb", timestamp: Timestamp()),
    Message(text: "I would like to know if it is available.", isFromCurrentUser: true, fromId: "abc", toId: "bbb", timestamp: Timestamp()),
    Message(text: "sorry, it's been sold out.", isFromCurrentUser: false, fromId: "abc", toId: "bbb", timestamp: Timestamp()),
    Message(text: "Hi", isFromCurrentUser: true, fromId: "abc", toId: "bbb", timestamp: Timestamp()),
    Message(text: "Hi, who is this?", isFromCurrentUser: false, fromId: "abc", toId: "bbb", timestamp: Timestamp()),
    Message(text: "I would like to know if it is available.", isFromCurrentUser: true, fromId: "abc", toId: "bbb", timestamp: Timestamp()),
    Message(text: "sorry, its's been sold out.", isFromCurrentUser: false, fromId: "abc", toId: "bbb", timestamp: Timestamp()),
    Message(text: "sorry, it'ss bdfdeen sold out.", isFromCurrentUser: false, fromId: "abc", toId: "bbb", timestamp: Timestamp()),
    Message(text: "Hdfi", isFromCurrentUser: true, fromId: "abc", toId: "bbb", timestamp: Timestamp()),
    Message(text: "Hi, who is dfthis?", isFromCurrentUser: false, fromId: "abc", toId: "bbb", timestamp: Timestamp()),
    Message(text: "I would like to cdknow if it is available.", isFromCurrentUser: true, fromId: "abc", toId: "bbb", timestamp: Timestamp()),
  ]
  
  init() {
    super.init(nibName: nil, bundle: nil)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureCollectionView()
    configureKeyboardInput()
    
    if let image = CustomGradient.mainBackground(on: view) {
      view.backgroundColor = UIColor(patternImage: image)
    }
  }
  
  override var inputAccessoryView: UIView? {
    get {
      return chatInputAccessoryView
    }
  }
  
  override var canBecomeFirstResponder: Bool {
    return true
  }
  
  private func configureCollectionView() {
    let layout              = UICollectionViewFlowLayout()
    layout.scrollDirection  = .vertical
    collectionView          = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
    
    collectionView.delegate             = self
    collectionView.dataSource           = self
    collectionView.keyboardDismissMode  = .interactive
    collectionView.alwaysBounceVertical = true
    collectionView.backgroundColor      = .clear
    collectionView.register(MessageCell.self, forCellWithReuseIdentifier: MessageCell.reuseIdentifier)
    
    view.addSubview(collectionView)
  }
  
  private func configureKeyboardInput() {
    NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardShow), name: UIResponder.keyboardDidShowNotification, object: nil)
    
    chatInputAccessoryView = ChatInputAccessoryView(frame: .init(x: 0, y: 0, width: view.frame.width, height: 60))
  }
  
  @objc fileprivate func handleKeyboardShow() {
    self.collectionView.scrollToItem(at: [0, messages.count - 1], at: .bottom, animated: true)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension ChatViewController: UICollectionViewDataSource {

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return messages.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MessageCell.reuseIdentifier, for: indexPath) as! MessageCell
    cell.message = messages[indexPath.row]
    return cell
  }
}

extension ChatViewController: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let estimatedSizeCell = MessageCell(frame: .init(x: 0, y: 0, width: view.frame.width, height: 1000))
    estimatedSizeCell.message = self.messages[indexPath.item]
    estimatedSizeCell.layoutIfNeeded()
    
    let estimatedSize = estimatedSizeCell.systemLayoutSizeFitting(.init(width: view.frame.width, height: 1000))
    return .init(width: view.frame.width, height: estimatedSize.height)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return .init(top: 16, left: 0, bottom: 16, right: 0)
  }
}


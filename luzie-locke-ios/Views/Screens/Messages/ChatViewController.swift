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

  private var messages: [ChatMessage] = [
    ChatMessage(text: "Hello", isFromCurrentUser: true, fromId: "abc", toId: "bbb", timestamp: Timestamp()),
    ChatMessage(text: "Who is this?", isFromCurrentUser: false, fromId: "abc", toId: "bbb", timestamp: Timestamp()),
    ChatMessage(text: "3Are you availble?", isFromCurrentUser: true, fromId: "abc", toId: "bbb", timestamp: Timestamp()),
    ChatMessage(text: "4Sure, here I am. go ahead", isFromCurrentUser: false, fromId: "abc", toId: "bbb", timestamp: Timestamp()),
    ChatMessage(text: "5Hi", isFromCurrentUser: true, fromId: "abc", toId: "bbb", timestamp: Timestamp()),
    ChatMessage(text: "6Hi, who is this?", isFromCurrentUser: false, fromId: "abc", toId: "bbb", timestamp: Timestamp()),
    ChatMessage(text: "7I would like to know if any food is available.", isFromCurrentUser: true, fromId: "abc", toId: "bbb", timestamp: Timestamp()),
    ChatMessage(text: "8sorry, it's sold out.", isFromCurrentUser: false, fromId: "abc", toId: "bbb", timestamp: Timestamp()),
    ChatMessage(text: "9sorry, it's sold out.", isFromCurrentUser: false, fromId: "abc", toId: "bbb", timestamp: Timestamp()),
    ChatMessage(text: "10Hi", isFromCurrentUser: true, fromId: "abc", toId: "bbb", timestamp: Timestamp()),
    ChatMessage(text: "11Hi, who is this?", isFromCurrentUser: false, fromId: "abc", toId: "bbb", timestamp: Timestamp()),
    ChatMessage(text: "12I would like have a cup of coffee.", isFromCurrentUser: true, fromId: "abc", toId: "bbb", timestamp: Timestamp()),
    ChatMessage(text: "13sorry, it's sold out.", isFromCurrentUser: false, fromId: "abc", toId: "bbb", timestamp: Timestamp()),
    ChatMessage(text: "14Hi", isFromCurrentUser: true, fromId: "abc", toId: "bbb", timestamp: Timestamp()),
    ChatMessage(text: "15Hi, who is this?", isFromCurrentUser: false, fromId: "abc", toId: "bbb", timestamp: Timestamp()),
    ChatMessage(text: "16I am who I am.", isFromCurrentUser: true, fromId: "abc", toId: "bbb", timestamp: Timestamp()),
    ChatMessage(text: "17sorry, its's sold out.", isFromCurrentUser: false, fromId: "abc", toId: "bbb", timestamp: Timestamp()),
    ChatMessage(text: "18sorry, it's sold out.", isFromCurrentUser: false, fromId: "abc", toId: "bbb", timestamp: Timestamp()),
    ChatMessage(text: "19Hdfi", isFromCurrentUser: true, fromId: "abc", toId: "bbb", timestamp: Timestamp()),
    ChatMessage(text: "20Hi, who is dfthis?", isFromCurrentUser: false, fromId: "abc", toId: "bbb", timestamp: Timestamp()),
    ChatMessage(text: "21I would like to cdknow if it is available.", isFromCurrentUser: true, fromId: "abc", toId: "bbb", timestamp: Timestamp()),
    ChatMessage(text: "14Hi", isFromCurrentUser: true, fromId: "abc", toId: "bbb", timestamp: Timestamp()),
    ChatMessage(text: "15Hi, who is this?", isFromCurrentUser: false, fromId: "abc", toId: "bbb", timestamp: Timestamp()),
    ChatMessage(text: "16I am who I am.", isFromCurrentUser: true, fromId: "abc", toId: "bbb", timestamp: Timestamp()),
    ChatMessage(text: "17sorry, its's sold out.", isFromCurrentUser: false, fromId: "abc", toId: "bbb", timestamp: Timestamp()),
    ChatMessage(text: "18sorry, it's sold out.", isFromCurrentUser: false, fromId: "abc", toId: "bbb", timestamp: Timestamp()),
    ChatMessage(text: "19Hdfi", isFromCurrentUser: true, fromId: "abc", toId: "bbb", timestamp: Timestamp()),
    ChatMessage(text: "20Hi, who is dfthis?", isFromCurrentUser: false, fromId: "abc", toId: "bbb", timestamp: Timestamp()),
    ChatMessage(text: "21I would like to cdknow if it is available.", isFromCurrentUser: true, fromId: "abc", toId: "bbb", timestamp: Timestamp()),
  ]

  init() {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    
    super.init(collectionViewLayout: layout)
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    configureCollectionView()
    configureKeyboardInput()

    if let image = CustomGradient.mainBackground(on: view) {
      view.backgroundColor = UIColor(patternImage: image)
    }
  }
  
  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return messages.count
  }

  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChatMessageCell.reuseIdentifier, for: indexPath) as! ChatMessageCell
    cell.message = messages[indexPath.row]
//      cell.viewModel = self?.viewModel.itemCellViewModels[indexPath.row]
    return cell
  }
  
  private func configureCollectionView() {
    collectionView.backgroundColor = .clear
    collectionView.alwaysBounceVertical = true
    collectionView.keyboardDismissMode  = .interactive
    collectionView.register(ChatMessageCell.self, forCellWithReuseIdentifier: ChatMessageCell.reuseIdentifier)
    
    view.addSubview(collectionView)
  }

  private func configureKeyboardInput() {
    NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardShow), name: UIResponder.keyboardDidShowNotification, object: nil)

    chatInputAccessoryView = ChatInputAccessoryView(frame: .init(x: 0, y: 0, width: view.frame.width, height: 60))
  }

  override var inputAccessoryView: UIView? {
    get {
      return chatInputAccessoryView
    }
  }

  override var canBecomeFirstResponder: Bool {
      return true
  }

  @objc func handleKeyboardShow() {
    collectionView.scrollToItem(at: [0, messages.count - 1],
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
    estimatedSizeCell.message = self.messages[indexPath.item]
    estimatedSizeCell.layoutIfNeeded()

    let estimatedSize = estimatedSizeCell.systemLayoutSizeFitting(.init(width: view.frame.width, height: 1000))
    return .init(width: view.frame.width, height: estimatedSize.height)
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return .init(top: 16, left: 0, bottom: 16, right: 0)
  }
}

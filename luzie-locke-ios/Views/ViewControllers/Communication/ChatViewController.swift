//
//  ChatViewController.swift
//  luzie-locke-ios
//
//  Created by Harry on 08.11.21.
//

import UIKit
import Firebase

class ChatViewController: UIViewController {

  enum Section { case main }
  
  private var collectionView: UICollectionView!
  private var dataSource:     UICollectionViewDiffableDataSource<Section, Message>!
  
  private var chatInputAccessoryView: ChatInputAccessoryView!
  
  private var messages: [Message] = [
    Message(text: "Hi", isFromCurrentUser: true, fromId: "abc", toId: "bbb", timestamp: Timestamp()),
    Message(text: "Hi, who is this?", isFromCurrentUser: false, fromId: "abc", toId: "bbb", timestamp: Timestamp()),
    Message(text: "I would like to know if it is available.", isFromCurrentUser: true, fromId: "abc", toId: "bbb", timestamp: Timestamp()),
    Message(text: "sorry, it's been sold out.", isFromCurrentUser: false, fromId: "abc", toId: "bbb", timestamp: Timestamp()),
    Message(text: "Hi", isFromCurrentUser: true, fromId: "abc", toId: "bbb", timestamp: Timestamp()),
    Message(text: "Hi, who is this?", isFromCurrentUser: false, fromId: "abc", toId: "bbb", timestamp: Timestamp()),
    Message(text: "I would like to know if it is available.", isFromCurrentUser: true, fromId: "abc", toId: "bbb", timestamp: Timestamp()),
    Message(text: "sorry, it's been sold out.", isFromCurrentUser: false, fromId: "abc", toId: "bbb", timestamp: Timestamp()),
    Message(text: "sorry, it's been sold out.", isFromCurrentUser: false, fromId: "abc", toId: "bbb", timestamp: Timestamp()),
    Message(text: "Hi", isFromCurrentUser: true, fromId: "abc", toId: "bbb", timestamp: Timestamp()),
    Message(text: "Hi, who is this?", isFromCurrentUser: false, fromId: "abc", toId: "bbb", timestamp: Timestamp()),
    Message(text: "I would like to know if it is available.", isFromCurrentUser: true, fromId: "abc", toId: "bbb", timestamp: Timestamp()),
  ]
  
  init() {
    super.init(nibName: nil, bundle: nil)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemPink
    
    configureCollectionView()
    configureDataSource()
    configureKeyboardInput()
    
    updateData(on: messages)
  }
  
  private func configureCollectionView() {
    let padding: CGFloat        = 15
    let flowLayout              = UICollectionViewFlowLayout()
    flowLayout.sectionInset     = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
    flowLayout.itemSize         = CGSize(width: view.bounds.width - padding * 2, height: 100)
    flowLayout.scrollDirection  = .vertical
    
    collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: flowLayout)
    collectionView.delegate             = self
    collectionView.alwaysBounceVertical = true
    collectionView.keyboardDismissMode  = .interactive
    collectionView.register(MessageCell.self, forCellWithReuseIdentifier: MessageCell.reuseIdentifier)


    
    view.addSubview(collectionView)
    
    if let image = CustomGradient.mainBackground(on: collectionView) {
      collectionView.backgroundColor = UIColor(patternImage: image)
    }
  }
  
  func configureDataSource() {
    dataSource = UICollectionViewDiffableDataSource<Section, Message>(collectionView: collectionView, cellProvider: { [weak self] (collectionView, indexPath, follower) -> UICollectionViewCell? in
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MessageCell.reuseIdentifier, for: indexPath) as! MessageCell
      cell.message = self?.messages[indexPath.row]
      print(indexPath)
//      cell.viewModel = self?.viewModel.itemCellViewModels[indexPath.row]
      return cell
    })
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
  
  private func updateData(on messages: [Message]) {
    var snapshot = NSDiffableDataSourceSnapshot<Section, Message>()
    snapshot.appendSections([.main])
    snapshot.appendItems(messages)
    
    DispatchQueue.main.async {
      self.dataSource.apply(snapshot, animatingDifferences: true)
    }
  }

  @objc func handleKeyboardShow() {
    print("handleKeyboardShow")
//    self.collectionView.scrollToItem(at: [0, messages.count - 1], at: .bottom, animated: true)
    
////    collectionView.scrollToItem(at: [0, 3], at: .bottom, animated: true)
//    self.collectionView.isPagingEnabled = false
    print("@:", messages.count)
      collectionView.isPagingEnabled = false
      collectionView.scrollToItem(at: [0, messages.count - 1],
                                at: .bottom,
                                animated: false)
    
      collectionView.isPagingEnabled = true
//    self.collectionView.isPagingEnabled = true
//    self.collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
   
    
//    collectionView.scrollToItem(at: IndexPath(row: messages.count - 1, section: 0), at: .top, animated: false)
//    collectionView.scrollToItem(
  }
  
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension ChatViewController: UICollectionViewDelegate {
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
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

//
//  ChatViewController.swift
//  luzie-locke-ios
//
//  Created by Harry on 08.11.21.
//

import UIKit

class ChatViewController: UIViewController {

  enum Section { case main }
  
  private var collectionView: UICollectionView!
  private var dataSource:     UICollectionViewDiffableDataSource<Section, Item>!
  
  private var chatInputAccessoryView: ChatInputAccessoryView!
  
  init() {
    super.init(nibName: nil, bundle: nil)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemPink
    
    configureKeyboardInput()
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
    print("handleKeyboardShow")
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

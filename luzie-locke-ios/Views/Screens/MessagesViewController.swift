//
//  MessagesViewController.swift
//  luzie-locke-ios
//
//  Created by Harry on 09.10.21.
//

import UIKit
import Firebase



class MessagesViewController: UIViewController {
  
  enum Section { case main }
  
  var viewModel: MessagesViewModel?
  
  private let tableView = UITableView()
  private var dataSource: UITableViewDiffableDataSource<Section, RecentMessage>!
  
  init() {
    super.init(nibName: nil, bundle: nil)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: ScreenTitleLabel("Chat"))
    configureGradientBackground()
    configureTableView()
    configureDataSource()
    configureBindables()
    
    viewModel?.didLoad()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    
    if isMovingFromParent {
      viewModel?.willDisappear()
    }
  }
  
  func configureGradientBackground() {
    if let image = CustomGradient.mainBackground(on: view) {
      view.backgroundColor = UIColor(patternImage: image)
    }
  }
  
  private func configureTableView() {
    view.addSubview(tableView)
    
    tableView.frame         = view.bounds
    tableView.rowHeight     = 80
    tableView.delegate      = self
    tableView.backgroundColor = .clear
    tableView.tableFooterView = UIView(frame: .zero)
    
    tableView.register(RecentMessageCell.self, forCellReuseIdentifier: RecentMessageCell.reuseIdentifier)
  }
  
  private func configureDataSource() {
    dataSource = UITableViewDiffableDataSource<Section, RecentMessage>(tableView: tableView, cellProvider: { [weak self] tableView, indexPath, itemIdentifier in
      let cell = tableView.dequeueReusableCell(withIdentifier: RecentMessageCell.reuseIdentifier) as! RecentMessageCell
      cell.viewModel = self?.viewModel?.recentMessagesViewModels[indexPath.row]
      return cell
    })
  }
  
  func configureBindables() {
    viewModel?.bindableRecentMessages.bind { [weak self] messages in
      if let messages = messages {
        self?.updateData(on: messages)
      }
    }
  }
  
  private func updateData(on messages: [RecentMessage]) {
    var snapshot = NSDiffableDataSourceSnapshot<Section, RecentMessage>()
    snapshot.appendSections([.main])
    snapshot.appendItems(messages)
    
    DispatchQueue.main.async {
      self.dataSource.apply(snapshot, animatingDifferences: true)
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension MessagesViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    viewModel?.didTapMessageAt(indexPath: indexPath)
  }
  
  func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    
    let deleteAction = UIContextualAction(style: .normal, title: "") { [weak self] (_, _, completion) in
      self?.viewModel?.didTapDeleteMessageAt(indexPath: indexPath)
      completion(true)
    }
    
    deleteAction.image = Images.delete
    deleteAction.backgroundColor = Colors.primaryColor
    
    return UISwipeActionsConfiguration(actions: [deleteAction])
  }
}

//
//  ScreenFactory.swift
//  luzie-locke-ios
//
//  Created by Harry on 14.01.22.
//

import UIKit

protocol CommunicationViewFactory {
  
  func makeMessagesView(coordinator: MessagesCoordinator) -> MessagesViewController
  func makeMessageView(coordinator: CommunicationCoordinatorProtocol, remoteUserId: String, itemId: String) -> MessageViewController
  func makeChatView(remoteUserId: String, itemId: String) -> ChatViewController
}

extension CompositionRoot: CommunicationViewFactory {

  func makeMessagesView(coordinator: MessagesCoordinator) -> MessagesViewController {
    let vc = MessagesViewController()
    vc.tabBarItem = UITabBarItem(title: nil, image: Images.chats, selectedImage: Images.chats)
    vc.viewModel = MessagesViewModel(coordinator: coordinator,
                                     imageUseCase: imageUseCase,
                                     localProfileRepository: localProfileRepository,
                                     chatMessageRepository: ChatMessageRepository(),
                                     recentMessageRepository: RecentMessageRepository())
    return vc
  }
  
  func makeMessageView(coordinator: CommunicationCoordinatorProtocol, remoteUserId: String, itemId: String) -> MessageViewController {
    let vc = MessageViewController()
    vc.viewModel = MessageViewModel(coordinator: coordinator,
                                    itemId: itemId,
                                    imageUseCase: imageUseCase,
                                    itemControlUseCase: itemControlUseCase)
    vc.chatViewController = makeChatView(remoteUserId: remoteUserId, itemId: itemId)
    return vc
  }
  
  func makeChatView(remoteUserId: String, itemId: String) -> ChatViewController {
    let vc = ChatViewController()
    vc.viewModel = ChatViewModel(remoteUserId: remoteUserId,
                                 itemId: itemId,
                                 imageUseCase: imageUseCase,
                                 itemControlUseCase: itemControlUseCase,
                                 userProfileRepository: userProfileRepository,
                                 chatMessageRepository: ChatMessageRepository(),
                                 recentMessageRepository: RecentMessageRepository())
    return vc
  }
}

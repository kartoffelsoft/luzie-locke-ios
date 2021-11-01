//
//  SceneDelegate.swift
//  luzie-locke-ios
//
//  Created by Harry on 09.10.21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  
  var window: UIWindow?
  
  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let scene = (scene as? UIWindowScene) else { return }
    
    let httpClient            = KHTTPClient()
    let openHttpClient        = OpenHTTPClient(client: httpClient)
    
    let httpApiClient         = KHTTPAPIClient(baseEndpoint: BackendConfig.host)
    let userApiClient         = UserAPIClient(client: httpApiClient)
    let backendApiClient      = BackendAPIClient(
                                  client: httpApiClient,
                                  userApi: userApiClient)
    
    let itemRepository        = ItemRepository(backendClient: httpApiClient)
    
    let profileStorage        = AnyStorage(wrap: ProfileStorage(key: "Profile"))
    let accessTokenStorage    = AnyStorage(wrap: SimpleStringStorage(key: "AccessToken"))
    let refreshTokenStorage   = AnyStorage(wrap: SimpleStringStorage(key: "RefreshToken"))
    
    let storageService        = StorageService(
                                  profile: profileStorage,
                                  accessToken: accessTokenStorage,
                                  refreshToken: refreshTokenStorage)
    
    let cloudStorage          = FirebaseCloudStorage()
    
    let firebaseAuth          = FirebaseAuthService(google: GoogleSignInService())
    let backendAuth           = BackendAuthService(
                                  backendApiClient: backendApiClient,
                                  profileStorage: profileStorage,
                                  accessTokenStorage: accessTokenStorage,
                                  refreshTokenStorage: refreshTokenStorage)
    
    let auth = AuthService(firebaseAuth: firebaseAuth, backendAuth: backendAuth)
    
    window = UIWindow(windowScene: scene)
    window?.makeKeyAndVisible()
    
    window?.rootViewController = UINavigationController(
      rootViewController:
        MainTabBarController(
          auth: auth,
          storage: storageService,
          openHttpClient: openHttpClient,
          backendApiClient: backendApiClient,
          loginCoordinator: LoginCoordinator(navigationController: UINavigationController(),
                                             auth: auth,
                                             storage: storageService,
                                             backendApiClient: backendApiClient),
          homeCoordinator: HomeCoordinator(navigationController: UINavigationController(),
                                           profileStorage: profileStorage,
                                           cloudStorage: cloudStorage,
                                           openHttpClient: openHttpClient,
                                           itemRepository: itemRepository)
        )
    )
  }
  
  func sceneDidDisconnect(_ scene: UIScene) {
    // Called as the scene is being released by the system.
    // This occurs shortly after the scene enters the background, or when its session is discarded.
    // Release any resources associated with this scene that can be re-created the next time the scene connects.
    // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
  }
  
  func sceneDidBecomeActive(_ scene: UIScene) {
    // Called when the scene has moved from an inactive state to an active state.
    // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
  }
  
  func sceneWillResignActive(_ scene: UIScene) {
    // Called when the scene will move from an active state to an inactive state.
    // This may occur due to temporary interruptions (ex. an incoming phone call).
  }
  
  func sceneWillEnterForeground(_ scene: UIScene) {
    // Called as the scene transitions from the background to the foreground.
    // Use this method to undo the changes made on entering the background.
  }
  
  func sceneDidEnterBackground(_ scene: UIScene) {
    // Called as the scene transitions from the foreground to the background.
    // Use this method to save data, release shared resources, and store enough scene-specific state information
    // to restore the scene back to its current state.
  }
  
  
}


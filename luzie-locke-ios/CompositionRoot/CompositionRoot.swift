//
//  CompositionRoot.swift
//  luzie-locke-ios
//
//  Created by Harry on 03.11.21.
//

import Foundation

class CompositionRoot {
  
  lazy var httpClient       = HTTPClient()
  lazy var cloudStorage     = FirebaseCloudStorage()
  lazy var backendClient    = BackendClient(baseEndpoint: BackendConfig.host)
  lazy var userApiClient    = UserAPIClient(client: backendClient)
  lazy var backendApiClient = BackendAPIClient(client: backendClient,
                                               userApi: userApiClient)
  
  lazy var imageRepository          = ImageRepository(httpClient: httpClient, cloudStorage: cloudStorage)
  lazy var itemRepository           = ItemRepository(backendClient: backendClient, imageRepository: imageRepository)
  lazy var userOpenItemRepository   = UserOpenItemRepository(backendClient: backendClient)
  lazy var userSoldItemRepository   = UserSoldItemRepository(backendClient: backendClient)
  lazy var userBoughtItemRepository = UserBoughtItemRepository(backendClient: backendClient)
  lazy var favoriteItemRepository   = FavoriteItemRepository(backendClient: backendClient)
  lazy var localProfileRepository   = LocalProfileRepository(key: "Profile")
  lazy var userProfileRepository    = UserProfileRepository(backendClient: backendClient,
                                                            localProfileRepository: localProfileRepository)
  lazy var settingsRepository       = SettingsRepository(backendClient: backendClient)
  
  lazy var imageUseCase             = ImageUseCase(imageRepository: imageRepository,
                                                   backendClient: backendClient)
  lazy var itemControlUseCase       = ItemControlUseCase(itemRepository: itemRepository)
  lazy var myProfileUseCase         = MyProfileUseCase(localProfileRepository: localProfileRepository)
  lazy var userOpenItemUseCase      = UserOpenItemUseCase(localProfileRepository: localProfileRepository,
                                                          userOpenItemRepository: userOpenItemRepository)
  lazy var userSoldItemUseCase      = UserSoldItemUseCase(localProfileRepository: localProfileRepository,
                                                          userSoldItemRepository: userSoldItemRepository)
  lazy var userBoughtItemUseCase    = UserBoughtItemUseCase(localProfileRepository: localProfileRepository,
                                                            userBoughtItemRepository: userBoughtItemRepository)
  lazy var userFavoriteItemUseCase  = UserFavoriteItemUseCase(localProfileRepository: localProfileRepository,
                                                              favoriteItemRepository: favoriteItemRepository)
  lazy var settingsUseCase          = SettingsUseCase(settingsRepository: settingsRepository,
                                                      myProfileUseCase: myProfileUseCase)
  
  lazy var accessTokenStorage     = AnyStorage(wrap: SimpleStringStorage(key: "AccessToken"))
  lazy var refreshTokenStorage    = AnyStorage(wrap: SimpleStringStorage(key: "RefreshToken"))
  
  lazy var firebaseUseCase        = FirebaseAuthUseCase(google: GoogleSignInUseCase())
  lazy var backendAuthUseCase     = BackendAuthUseCase(backendApiClient: backendApiClient,
                                                       localProfileRepository: localProfileRepository,
                                                       accessTokenStorage: accessTokenStorage,
                                                       refreshTokenStorage: refreshTokenStorage)
  
  lazy var authUseCase = AuthUseCase(firebaseAuthUseCase: firebaseUseCase, backendAuthUseCase: backendAuthUseCase)
}

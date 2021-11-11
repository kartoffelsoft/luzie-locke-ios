//
//  CompositionRoot.swift
//  luzie-locke-ios
//
//  Created by Harry on 03.11.21.
//

import Foundation

class CompositionRoot {
  lazy var httpClient             = KHTTPClient()
  lazy var openHttpClient         = OpenHTTPClient(client: httpClient)
  
  lazy var backendClient          = BackendClient(baseEndpoint: BackendConfig.host)
  lazy var userApiClient          = UserAPIClient(client: backendClient)
  lazy var backendApiClient       = BackendAPIClient(client: backendClient,
                                                     userApi: userApiClient)
  
  lazy var itemRepository         = ItemRepository(backendClient: backendClient)
  lazy var userProfileRepository  = UserProfileRepository(backendClient: backendClient)
  lazy var profileRepository      = ProfileRepository(key: "Profile")

  lazy var accessTokenStorage     = AnyStorage(wrap: SimpleStringStorage(key: "AccessToken"))
  lazy var refreshTokenStorage    = AnyStorage(wrap: SimpleStringStorage(key: "RefreshToken"))
  
  lazy var cloudStorage           = FirebaseCloudStorage()

  lazy var firebaseAuth           = FirebaseAuthService(google: GoogleSignInService())
  lazy var backendAuth            = BackendAuthService(backendApiClient: backendApiClient,
                                                       profileRepository: profileRepository,
                                                       accessTokenStorage: accessTokenStorage,
                                                       refreshTokenStorage: refreshTokenStorage)
  
  lazy var auth = AuthService(firebaseAuth: firebaseAuth, backendAuth: backendAuth)
}

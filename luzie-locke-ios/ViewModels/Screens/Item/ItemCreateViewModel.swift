//
//  ItemCreateViewModel.swift
//  luzie-locke-ios
//
//  Created by Harry on 29.10.21.
//

import UIKit

class ItemCreateViewModel {
  
  let coordinator:          HomeCoordinator
  let profileStorage:       AnyStorage<User>
  let openHttpClient:       OpenHTTP
  let backendApiClient:     BackendAPIClient

  let titleViewModel:       TextInputCellViewModel
  let priceViewModel:       DecimalInputCellViewModel
  let descriptionViewModel: TextInputCellViewModel
  
  init(coordinator:       HomeCoordinator,
       profileStorage:    AnyStorage<User>,
       openHttpClient:    OpenHTTP,
       backendApiClient:  BackendAPIClient) {
    self.coordinator      = coordinator
    self.profileStorage   = profileStorage
    self.openHttpClient   = openHttpClient
    self.backendApiClient = backendApiClient
    
    titleViewModel        = TextInputCellViewModel()
    priceViewModel        = DecimalInputCellViewModel()
    descriptionViewModel  = TextInputCellViewModel()
  }
  
  private func validate() -> Result<Void, LLError> {
    guard let title = titleViewModel.text else             { return .failure(.titleInvalid) }
    if title.count < 3                                     { return .failure(.titleInvalid) }

    guard let price = priceViewModel.text else             { return .failure(.priceInvalid) }
    if price.last == "."                                   { return .failure(.priceInvalid)  }

    guard let description = descriptionViewModel.text else { return .failure(.descriptionInvalid) }
    if description.count < 3                               { return .failure(.descriptionInvalid) }
    
    return .success(())
  }
  
  func upload(completion: (Result<Void, LLError>) -> Void) {
    switch validate() {
    case .success: ()
    case .failure(let error): completion(.failure(error))
    }
  }
}

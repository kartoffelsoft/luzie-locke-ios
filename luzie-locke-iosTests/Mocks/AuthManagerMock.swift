//
//  AuthManagerMock.swift
//  luzie-locke-iosTests
//
//  Created by Harry on 10.10.21.
//

import Foundation
@testable import luzie_locke_ios

class AuthManagerMock: AuthManager {
    
    override func isLoggedIn() -> Bool {
        return false
    }
}

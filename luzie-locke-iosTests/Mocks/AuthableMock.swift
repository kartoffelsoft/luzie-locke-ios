//
//  AuthManagerMock.swift
//  luzie-locke-iosTests
//
//  Created by Harry on 10.10.21.
//

import UIKit
@testable import luzie_locke_ios

class AuthableMock: Authable {

    func authenticate(_ caller: UIViewController, with provider: SignInProvider, completion: @escaping (Result<Void, LLError>?) -> Void) {
        
    }
}

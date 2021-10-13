//
//  UserProfileStorage.swift
//  luzie-locke-ios
//
//  Created by Harry on 13.10.21.
//

import Firebase

protocol Storable {
    associatedtype T
    func get() -> T?
    func set(_ data: T)
}

class UserStorage: Storable {
    private var data: User?
    private let key: String

    init(key: String) {
        self.key = key

        if let stored = UserDefaults.standard.object(forKey: self.key) as? Data {
            let decoder = JSONDecoder()
            if let data = try? decoder.decode(User.self, from: stored) {
                self.data = data
            }
        }
    }

    func get() -> User? {
        return data
    }

    func set(_ data: User) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(data) {
            UserDefaults.standard.set(encoded, forKey: self.key)
            self.data = data
        }
    }
    
    func available() -> Bool {
        return Auth.auth().currentUser != nil && data != nil
    }
}

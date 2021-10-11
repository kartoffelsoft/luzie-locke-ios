//
//  BackendAuthService.swift
//  luzie-locke-ios
//
//  Created by Harry on 11.10.21.
//

import Foundation

class BackendAuthService {
    
    let authAPI = "http://localhost:5000/api/users/login/google/"
    
    func authenticate(uid: String, token: String, completion: @escaping (Result<User, LLError>?) -> Void) {
        guard let url = URL(string: authAPI) else { return }
        
        var urlRequest        = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        
        let params = ["token": token]
        do {
            let data = try  JSONSerialization.data(withJSONObject: params, options: .init())
            urlRequest.httpBody = data
            urlRequest.setValue("application/json", forHTTPHeaderField: "content-type")
            
            URLSession.shared.dataTask(with: urlRequest) { [weak self] (data, response, error) in
                guard let self = self else { return }
                guard let data = data else { return }
                
                if let _ = error {
                    completion(.failure(.unableToComplete))
                    return
                }
                
                if let user = self.parseJSON(authData: data) {
                    completion(.success(user))
                } else {
                    completion(.failure(.unableToComplete))
                }
            }.resume()
        } catch {
            
        }
    }
    
    func parseJSON(authData: Data) -> User? {
        let decoder = JSONDecoder()
        
        do {
            let user = try decoder.decode(User.self, from: authData)

            return user
        } catch {
            return nil
        }
    }

    
}

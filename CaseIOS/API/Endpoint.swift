//
//  Endpoint.swift
//  CaseIOS
//
//  Created by Павел Кай on 08.04.2023.
//

import Foundation

enum Endpoint {
    
    case register(user: RegisterUser)
    case login(user: RegisterUser)
    
    var url: URL? {
        switch self {
        case .register:
            return .init(string: "http://82.148.18.70:5001/auth/register")
        case .login:
            return .init(string: "http://82.148.18.70:5001/auth/login")
        }
    }
    
    var httpMethod: String {
        switch self {
        case .register, .login:
            return "POST"
        }
    }
    
    func createRequest() -> URLRequest? {
        guard let url = url else { return nil }
        var request = URLRequest(url: url)
        
        switch self {
        case .register(let user):
            print(user)
            let encodedUser = try? JSONEncoder().encode(user)
            request.httpMethod = httpMethod
            request.httpBody = encodedUser
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        case .login(let user):
            print(user)
            let encodedUser = try? JSONEncoder().encode(user)
            request.httpMethod = httpMethod
            request.httpBody = encodedUser
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        
        return request
    }
    
    
}

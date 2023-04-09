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
    case users
    
    case userGet(id: Int)
    case userDelete(id: Int)
    case userPut(user: RegisterUser)
    case userPost(user: UserPost)
    
    case products
    case categories
    
    func urlComponents(scheme: String = "http", host: String = "82.148.18.70", path: String) -> URL? {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = path
        return components.url
    }
    
    var url: URL? {
        switch self {
        case .register:
            return urlComponents(path: "/auth/register")
        case .login:
            return urlComponents(path: "/auth/login")
        case .users:
            return urlComponents(path: "/users/all")
            
        case .userGet(let id):
            return urlComponents(path: "/users/1")
        case .userDelete(let id):
            return urlComponents(path: "/users/\(id)")
        case .userPut, .userPost:
            return urlComponents(path: "/users/")
            
        case .products:
            return urlComponents(path: "/products/all")
        case .categories:
            return urlComponents(path: "/categories/all")
        }
    }
    
    var httpMethod: String {
        switch self {
        case .register, .login, .userPost, .userGet:
            return "POST"
        case .users, .products, .categories:
            return "GET"
        case .userDelete:
            return "DELETE"
        case .userPut:
            return "PUT"
        }
    }
    
    func createRequest() -> URLRequest? {
        guard let url = url else { return nil }
        guard let token = TokenData.shared.token else { return nil }
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpMethod = httpMethod
        
        switch self {
        case .register(let user), .login(let user):
            print(user)
            let encodedUser = try? JSONEncoder().encode(user)
            request.httpBody = encodedUser
            
        case .users:
            return request
            
        case .userPut(let user):
            print(user)
            let encodedUser = try? JSONEncoder().encode(user)
            request.httpBody = encodedUser
        case  .userPost(let user):
            let encodedUser = try? JSONEncoder().encode(user)
            request.httpBody = encodedUser
        case .userGet, .userDelete:
            return request
            
        case .products, .categories:
            return request
        }
        
        return request
    }
    
    
}

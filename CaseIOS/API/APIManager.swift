//
//  APIManager.swift
//  CaseIOS
//
//  Created by Павел Кай on 08.04.2023.
//

import Foundation

enum APIError: Error {
    case badURL
    case canNotGet
    case canNotDecode
    
    case userAlreadyExist
}

class APIManager {
    
    let jsonDecoder: JSONDecoder
    let urlSession: URLSession
    
    init(jsonDecoder: JSONDecoder = .init(), urlSession: URLSession = .shared) {
        self.jsonDecoder = jsonDecoder
        self.urlSession = urlSession
    }
    
    func makeAPICall<T: Codable>(type: T.Type, endpoint: Endpoint) async throws -> T {
        guard let request = endpoint.createRequest() else { throw APIError.badURL }
        
        guard let (data, resp) = try? await urlSession.data(for: request) else { throw APIError.canNotGet }
        
        if let httpResponse = resp as? HTTPURLResponse {
            print(httpResponse.statusCode)
            
            if httpResponse.statusCode == 400 {
                throw APIError.userAlreadyExist
            }
        }
        
        guard let result = try? jsonDecoder.decode(type.self, from: data) else { throw APIError.canNotDecode }
        
        return result
    }
    
}

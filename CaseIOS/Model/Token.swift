//
//  Token.swift
//  CaseIOS
//
//  Created by Павел Кай on 08.04.2023.
//

import Foundation

struct Token: Codable {
    let accessToken: String
    let refreshToken: String
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
    }
}

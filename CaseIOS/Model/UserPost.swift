//
//  UserPost.swift
//  CaseIOS
//
//  Created by Павел Кай on 08.04.2023.
//

import Foundation

struct UserPost: Codable {
    let email: String
    let password: String
    let is_admin: Int
    let role: Int
    let name: String
    let surname: String
}

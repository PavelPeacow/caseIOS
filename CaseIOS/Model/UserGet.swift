//
//  UserGet.swift
//  CaseIOS
//
//  Created by Павел Кай on 09.04.2023.
//

import Foundation

struct UserGet: Codable {
    let id: Int
    let email: String
    let name: String
    let surname: String
    let role: Int
    let is_admin: Int
}

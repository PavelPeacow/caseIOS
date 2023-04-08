//
//  User.swift
//  CaseIOS
//
//  Created by Павел Кай on 08.04.2023.
//

import Foundation

struct User: Codable {
    let id: Int
    let email: String
    let name: String?
    let surname: String?
    let role: String?
}

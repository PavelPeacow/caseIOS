//
//  TokenData.swift
//  CaseIOS
//
//  Created by Павел Кай on 08.04.2023.
//

import Foundation

class TokenData {
    
    static let shared = TokenData()
    
    private init() { }

    var token: String? {
        get {
            UserDefaults.standard.string(forKey: "Token")
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "Token")
        }
    }
    
    var tokenRefresh: String? {
        get {
            UserDefaults.standard.string(forKey: "TokenRefresh")
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "TokenRefresh")
        }
    }

}

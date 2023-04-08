//
//  LoginViewModel.swift
//  CaseIOS
//
//  Created by Павел Кай on 08.04.2023.
//

import Foundation

protocol AuthViewModelDelegate: AnyObject {
    func validateForm(_ isValid: Bool)
    func throwUserNotFind()
}

@MainActor
class LoginViewModel {
    
    var delegate: AuthViewModelDelegate?
    
    let manager = APIManager()
    
    var email = "test@gmail.com" {
        didSet {
            delegate?.validateForm(isValidForm())
        }
    }
    var password = "teesttest" {
        didSet {
            delegate?.validateForm(isValidForm())
        }
    }
    
    private func validateEmail(_ email: String) -> Bool {
        let regex = try? NSRegularExpression(pattern: "^[a-zA-Z0-9]+@[a-z0-9]+\\.[a-z]{2,}$")
        if let _ = regex?.firstMatch(in: email, range: NSRange(location: 0, length: email.count)) {
            return true
        }
        return false
    }
    
    private func validatePassword(_ password: String) -> Bool {
        return !password.trimmingCharacters(in: .whitespaces).isEmpty && !password.contains(" ")
    }
    
    private func isValidForm() -> Bool {
        return validateEmail(email) && validatePassword(password)
    }
    
    func loginUser() async {
        let user = RegisterUser(email: email, password: password)
        do {
            let result = try await manager.makeAPICall(type: Token.self, endpoint: .login(user: user))
            print(result.accessToken)
            TokenData.shared.token = result.accessToken
            TokenData.shared.tokenRefresh = result.refreshToken
        } catch {
            print(error)
            if error as! APIError == APIError.userAlreadyExist {
                delegate?.throwUserNotFind()
            }
        }
    }
    

}

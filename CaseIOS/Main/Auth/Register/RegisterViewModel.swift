//
//  RegisterViewModel.swift
//  CaseIOS
//
//  Created by Павел Кай on 08.04.2023.
//

import Foundation

protocol RegisterViewModelDelegate: AnyObject {
    func validateForm(_ isValid: Bool)
    func throwUserAlreadyExist()
}

@MainActor
class RegisterViewModel {
    
    var delegate: RegisterViewModelDelegate?

    let manager = APIManager()

    var email = "" {
        didSet {
            delegate?.validateForm(isValidForm())
        }
    }
    
    var password = "" {
        didSet {
            delegate?.validateForm(isValidForm())
        }
    }
    
    var name = "" {
        didSet {
            delegate?.validateForm(isValidForm())
        }
    }
    
    var surname = "" {
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

    private func validateTextfields() -> Bool {
        if let _ = [password, name, surname].first(where: { $0.trimmingCharacters(in: .whitespaces).isEmpty || $0.contains(" ")  }) {
            return false
        }
        return true
    }

    private func isValidForm() -> Bool {
        return validateEmail(email) && validateTextfields()
    }

    func registerUser() async {
        let user = RegisterUser(email: email, password: password)
        do {
            let result = try await manager.makeAPICall(type: Token.self, endpoint: .register(user: user))
            print(result.accessToken)
        } catch {
            print(error)
            if error as! APIError == APIError.userAlreadyExist {
                delegate?.throwUserAlreadyExist()
            }
        }
    }


}

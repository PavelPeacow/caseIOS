//
//  ListDetailViewModel.swift
//  CaseIOS
//
//  Created by Павел Кай on 08.04.2023.
//

import Foundation

protocol ListDetailViewModelDelegate: AnyObject {
    func validateForm(_ isValid: Bool)
    func throwUserAlreadyExist()
}

class ListDetailViewModel {
    
    let manager = APIManager()
    
    weak var delegate: ListDetailViewModelDelegate?
    
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
    
    var role = "" {
        didSet {
            delegate?.validateForm(isValidForm())
        }
    }
    
    var user: UserGet?
    
    private func validateEmail(_ email: String) -> Bool {
        let regex = try? NSRegularExpression(pattern: "^[a-zA-Z0-9]+@[a-z0-9]+\\.[a-z]{2,}$")
        if let _ = regex?.firstMatch(in: email, range: NSRange(location: 0, length: email.count)) {
            return true
        }
        return false
    }

    private func validateTextfields() -> Bool {
        if let _ = [email, password, name, surname, role].first(where: { $0.trimmingCharacters(in: .whitespaces).isEmpty || $0.contains(" ")  }) {
            return false
        }
        return true
    }

    private func isValidForm() -> Bool {
        return validateEmail(email) && validateTextfields()
    }
    
    func deleteUser(id: Int) async {
        do {
            try await manager.makeNoAnswerCall(endpoint: .userDelete(id: id))
            print("Ben - yes")
        } catch {
            print(error)
        }
    }
    
    func postNewUser(userPost: UserPost) async {
        do {
            try await manager.makeNoAnswerCall(endpoint: .userPost(user: userPost))
        } catch {
            print(error)
        }
    }
    
}

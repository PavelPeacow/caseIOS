//
//  LoginViewController.swift
//  CaseIOS
//
//  Created by Павел Кай on 08.04.2023.
//

import UIKit

class LoginViewController: UIViewController {
    
    let viewModel = AuthViewModel()
    
    lazy var authStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [loginTitle, emailTextfield, passwordTextfield, logInBtn])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 16
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.axis = .vertical
        return stackView
    }()
    
    lazy var loginTitle: UILabel = {
        let label = UILabel()
        label.text = "Login"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    lazy var emailTextfield: MainInputTextfield = {
        let textfield = MainInputTextfield(placeholder: "Email")
        textfield.delegate = self
        textfield.addTarget(self, action: #selector(didChangeEmailText), for: .editingChanged)
        return textfield
    }()
    
    lazy var passwordTextfield: MainInputTextfield = {
        let textfield = MainInputTextfield(placeholder: "Password")
        textfield.delegate = self
        textfield.addTarget(self, action: #selector(didChangePasswordText), for: .editingChanged)
        return textfield
    }()
    
    lazy var logInBtn: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .selectColor
        btn.setTitle("Log in", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.layer.cornerRadius = 12
        btn.addTarget(self, action: #selector(didTapLogInBtn), for: .touchUpInside)
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        
        setBtnState(isValid: false)
       
        view.addSubview(authStackView)
        
        view.backgroundColor = .mainBackgroundColor
        
        setConstraints()
    }

    func setBtnState(isValid: Bool) {
        if isValid {
            logInBtn.alpha = 1.0
            logInBtn.isUserInteractionEnabled = true
        } else {
            logInBtn.alpha = 0.5
            logInBtn.isUserInteractionEnabled = false
        }
    }

}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

extension LoginViewController: AuthViewModelDelegate {
    
    func throwUserAlreadyExist() {
        let ac = UIAlertController(title: "Error!", message: "User is already exists", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK!", style: .default))
        present(ac, animated: true)
    }
    
    func validateForm(_ isValid: Bool) {
         setBtnState(isValid: isValid)
    }
    
}

extension LoginViewController {
    
    @objc func didChangeEmailText(_ sender: UITextField) {
        viewModel.email = sender.text ?? ""
    }
    
    @objc func didChangePasswordText(_ sender: UITextField) {
        viewModel.password = sender.text ?? ""
    }
    
    @objc func didTapLogInBtn() {
        Task {
            await viewModel.registerUser()
        }
    }
    
}

extension LoginViewController {
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            authStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            authStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            authStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            emailTextfield.heightAnchor.constraint(equalToConstant: 50),
            passwordTextfield.heightAnchor.constraint(equalToConstant: 50),
            
            logInBtn.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
}

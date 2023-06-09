//
//  RegisterViewController.swift
//  CaseIOS
//
//  Created by Павел Кай on 08.04.2023.
//

import UIKit

class RegisterViewController: UIViewController {
    
    let viewModel = RegisterViewModel()
    
    lazy var authStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [logoImageView, registerTitle, emailTextfield, passwordTextfield, nameTextfield, surnameTextfield, logInBtn, alreadyHaveAccountTitle])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 16
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.axis = .vertical
        return stackView
    }()
    
    lazy var logoImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "logo")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    lazy var registerTitle: UILabel = {
        let label = UILabel()
        label.text = "Register"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        label.textColor = .black
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
    
    lazy var nameTextfield: MainInputTextfield = {
        let textfield = MainInputTextfield(placeholder: "Name")
        textfield.delegate = self
        textfield.addTarget(self, action: #selector(didChangeNameText), for: .editingChanged)
        return textfield
    }()
    
    lazy var surnameTextfield: MainInputTextfield = {
        let textfield = MainInputTextfield(placeholder: "Surname")
        textfield.delegate = self
        textfield.addTarget(self, action: #selector(didChangeSurnameText), for: .editingChanged)
        return textfield
    }()
    
    lazy var logInBtn: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .selectColor
        btn.setTitle("Register", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.layer.cornerRadius = 12
        btn.addTarget(self, action: #selector(didTapLogInBtn), for: .touchUpInside)
        return btn
    }()
    
    lazy var alreadyHaveAccountTitle: UILabel = {
        let label = UILabel()
        label.text = "Already have an account? Login."
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textAlignment = .center
        label.textColor = .black
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapTitle))
        label.addGestureRecognizer(gesture)
        label.isUserInteractionEnabled = true
        return label
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

extension RegisterViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

extension RegisterViewController: RegisterViewModelDelegate {
    
    func throwUserAlreadyExist() {
        let ac = UIAlertController(title: "Error!", message: "User is already exists!", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK!", style: .default))
        present(ac, animated: true)
    }
    
    func validateForm(_ isValid: Bool) {
         setBtnState(isValid: isValid)
    }
    
}

extension RegisterViewController {
    
    @objc func didTapTitle() {
        navigationController?.setViewControllers([LoginViewController()], animated: true)
    }
    
    @objc func didChangeEmailText(_ sender: UITextField) {
        viewModel.email = sender.text ?? ""
    }
    
    @objc func didChangePasswordText(_ sender: UITextField) {
        viewModel.password = sender.text ?? ""
    }
    
    @objc func didChangeNameText(_ sender: UITextField) {
        viewModel.name = sender.text ?? ""
    }
    
    @objc func didChangeSurnameText(_ sender: UITextField) {
        viewModel.surname = sender.text ?? ""
    }
    
    @objc func didTapLogInBtn() {
        Task {
            await viewModel.registerUser()
        }
    }
    
}

extension RegisterViewController {
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            authStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            authStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            authStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            logoImageView.heightAnchor.constraint(equalToConstant: 100),
            
            emailTextfield.heightAnchor.constraint(equalToConstant: 50),
            passwordTextfield.heightAnchor.constraint(equalToConstant: 50),
            nameTextfield.heightAnchor.constraint(equalToConstant: 50),
            surnameTextfield.heightAnchor.constraint(equalToConstant: 50),
            
            logInBtn.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
}

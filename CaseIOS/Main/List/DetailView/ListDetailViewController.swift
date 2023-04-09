//
//  ListDetailViewController.swift
//  CaseIOS
//
//  Created by Павел Кай on 08.04.2023.
//

import UIKit

enum ListDetailViewType {
    case addUser
    case changeUser
}

protocol ListDetailViewControllerDelegate: AnyObject {
    func didUpdateList()
}

class ListDetailViewController: UIViewController {
    
    lazy var roles: [UserRoles] = [.admin, .analitic, .buyer]
    
    let viewModel = ListDetailViewModel()
    
    var delegate: ListDetailViewControllerDelegate?
    
    lazy var detailStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [detailTitle, emailTextfield, passwordTextfield, nameTextfield, surnameTextfield, changeRoleTextfield, btnsStackView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 16
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.axis = .vertical
        return stackView
    }()
    
    lazy var detailTitle: UILabel = {
        let label = UILabel()
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
    
    lazy var changeRoleTextfield: MainInputTextfield = {
        let textfield = MainInputTextfield(placeholder: "Role")
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.delegate = self
        textfield.inputView = rolesPickerView
        return textfield
    }()
    
    lazy var rolesPickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        return pickerView
    }()
    
    lazy var btnsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [deletePersonBtn, addPersonBtn])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 16
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.axis = .horizontal
        return stackView
    }()
    
    lazy var addPersonBtn: MainButton = {
        let btn = MainButton(title: "Add")
        btn.addTarget(self, action: #selector(didTapAddBtn), for: .touchUpInside)
        return btn
    }()
    
    lazy var deletePersonBtn: MainButton = {
        let btn = MainButton(title: "Delete")
        btn.backgroundColor = .red
        btn.addTarget(self, action: #selector(didTapDeleteBtn), for: .touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .mainBackgroundColor
        
        viewModel.delegate = self
        
        view.addSubview(detailStackView)
        
        setConstraints()
    }
    
    func configure(user: User) {
        print(user)
        
        emailTextfield.text = user.email
        passwordTextfield.text = "password"
        nameTextfield.text = user.name
        surnameTextfield.text = user.surname
        changeRoleTextfield.text = String(user.role ?? 228)
        
        viewModel.email = user.email
        viewModel.password = "password"
        viewModel.name = user.name ?? "NO NAME"
        viewModel.surname = user.surname ?? "NO SURNAME"
        viewModel.role = String(user.role ?? 1)
        
        viewModel.user = user
    }
    
    func setType(viewType: ListDetailViewType) {
        switch viewType {
        case .addUser:
            detailTitle.text = "Add User"
            deletePersonBtn.isHidden = true
            setBtnState(isValid: false)
        case .changeUser:
            detailTitle.text = "Change User"
            addPersonBtn.setTitle("Change", for: .normal)
            setBtnState(isValid: true)
        }
    }
    
    func setBtnState(isValid: Bool) {
        if isValid {
            addPersonBtn.alpha = 1.0
            addPersonBtn.isUserInteractionEnabled = true
        } else {
            addPersonBtn.alpha = 0.5
            addPersonBtn.isUserInteractionEnabled = false
        }
    }

}

extension ListDetailViewController {
    
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
    
    @objc func didTapAddBtn() {
        print("add")
        
        Task {
            let userPost = UserPost(email: viewModel.email, password: viewModel.password,
                                    is_admin: 1, role: 1,
                                    name: viewModel.name, surname: viewModel.surname)
            
            await viewModel.postNewUser(userPost: userPost)
            delegate?.didUpdateList()
            _ = navigationController?.popViewController(animated: true)
            dismiss(animated: true)
        }
    }
    
    @objc func didTapDeleteBtn() {
        print("delete")
        
        Task {
            if let id = viewModel.user?.id {
                await viewModel.deleteUser(id: id)
                delegate?.didUpdateList()
                _ = navigationController?.popViewController(animated: true)
            }
        }
       
    }
    
}

extension ListDetailViewController: ListDetailViewModelDelegate {
    
    func validateForm(_ isValid: Bool) {
        print(isValid)
        setBtnState(isValid: isValid)
    }
    
    func throwUserAlreadyExist() {
        print("throws")
    }
    
}

extension ListDetailViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.inputView == rolesPickerView {
            return false
        }
        return true
    }
    
}

extension ListDetailViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        roles.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        roles[row].rawValue
    }
    
}

extension ListDetailViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        changeRoleTextfield.text = roles[row].rawValue
        viewModel.role = roles[row].rawValue
        resignFirstResponder()
    }
    
}

extension ListDetailViewController {
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            detailStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            detailStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            detailStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            emailTextfield.heightAnchor.constraint(equalToConstant: 50),
            passwordTextfield.heightAnchor.constraint(equalToConstant: 50),
            nameTextfield.heightAnchor.constraint(equalToConstant: 50),
            surnameTextfield.heightAnchor.constraint(equalToConstant: 50),
            changeRoleTextfield.heightAnchor.constraint(equalToConstant: 50),
            
            addPersonBtn.heightAnchor.constraint(equalToConstant: 35),
            deletePersonBtn.heightAnchor.constraint(equalToConstant: 35),
        ])
    }
    
}

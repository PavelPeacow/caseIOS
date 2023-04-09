//
//  ProductDetailViewController.swift
//  CaseIOS
//
//  Created by Павел Кай on 09.04.2023.
//

import UIKit

protocol ProductDetailViewControllerDelegate: AnyObject {
    func didUpdateList()
}


class ProductDetailViewController: UIViewController {
    
    var id: Int?
    
    weak var delegate: ProductDetailViewControllerDelegate?
    
    lazy var detailStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [productTitle, productCategory, deleteProductBtn])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 16
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.axis = .vertical
        return stackView
    }()
    
    lazy var productTitle: MainInputTextfield = {
        let textfield = MainInputTextfield(placeholder: "Product title")
        return textfield
    }()
    
    lazy var productCategory: MainInputTextfield = {
        let textfield = MainInputTextfield(placeholder: "Product category")
        return textfield
    }()
    
    lazy var deleteProductBtn: MainButton = {
        let btn = MainButton(title: "Delete")
        btn.backgroundColor = .red
        btn.addTarget(self, action: #selector(didTapDeleteBtn), for: .touchUpInside)
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .mainBackgroundColor
        view.addSubview(detailStackView)
        
        setConstraints()
    }
  
    func configure(productTitle: String, category: String, id: Int) {
        self.productTitle.text = productTitle
        productCategory.text = category
        self.id = id
    }
}

extension ProductDetailViewController {
    
    @objc func didTapDeleteBtn() {
        print("delete")
        
        Task {
            if let id = id {
                await deleteProduct(id: id)
                delegate?.didUpdateList()
                _ = navigationController?.popViewController(animated: true)
            }
        }
       
    }
    
    func deleteProduct(id: Int) async {
        do {
            try await APIManager().makeNoAnswerCall(endpoint: .productDelete(id: id))
        } catch {
            print(error)
        }
    }
    
}

extension ProductDetailViewController {
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            detailStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            detailStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            detailStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            detailStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            productTitle.heightAnchor.constraint(equalToConstant: 50),
            productCategory.heightAnchor.constraint(equalToConstant: 50),
            
            deleteProductBtn.heightAnchor.constraint(equalToConstant: 35),
        ])
    }
    
}

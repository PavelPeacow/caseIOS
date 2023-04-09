//
//  ProductDetailViewController.swift
//  CaseIOS
//
//  Created by Павел Кай on 09.04.2023.
//

import UIKit

class ProductDetailViewController: UIViewController {
    
    lazy var detailStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [productTitle, productCategory])
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

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .mainBackgroundColor
        view.addSubview(detailStackView)
        
        setConstraints()
    }
  
    func configure(productTitle: String, category: String) {
        self.productTitle.text = productTitle
        productCategory.text = category
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
        ])
    }
    
}

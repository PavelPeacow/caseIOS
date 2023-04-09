//
//  ProductTableViewCell.swift
//  CaseIOS
//
//  Created by Павел Кай on 09.04.2023.
//

import UIKit

class ProductTableViewCell: UITableViewCell {
    
    static let identifier = "ProductTableViewCell"
 
    lazy var productsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [productName, productCategory])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 5
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.axis = .vertical
        return stackView
    }()
    
    lazy var productId: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .heavy)
        return label
    }()
    
    lazy var productName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    lazy var productCategory: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(productId)
        contentView.addSubview(productsStackView)
        
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(product: Product, categoryTitle: String) {
        productId.text = String(product.id)
        productName.text = product.title
        productCategory.text = categoryTitle
    }
    
}

extension ProductTableViewCell {
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            productId.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            productId.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            productsStackView.leadingAnchor.constraint(equalTo: productId.trailingAnchor, constant: 16),
            productsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            productsStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            productsStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
        ])
    }
    
}

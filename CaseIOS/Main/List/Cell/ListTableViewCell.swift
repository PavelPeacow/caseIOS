//
//  ListTableViewCell.swift
//  CaseIOS
//
//  Created by Павел Кай on 08.04.2023.
//

import UIKit

class ListTableViewCell: UITableViewCell {

    static let identifier = "ListTableViewCell"
    
    lazy var contentStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [namesStackView, userRole])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 5
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        stackView.axis = .horizontal
        return stackView
    }()
    
    lazy var namesStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [userName, userSurname])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 5
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.axis = .vertical
        return stackView
    }()
    
    lazy var userId: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .heavy)
        return label
    }()
    
    lazy var userName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    lazy var userSurname: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    lazy var userRole: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(userId)
        contentView.addSubview(contentStackView)
        
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(user: User) {
        userId.text = String(user.id)
        userName.text = user.name ?? "NO NAME"
        userSurname.text = user.surname ?? "NO SURNAME1231312"
        userRole.text = user.role ?? "NO ROLE"
    }
    
}

extension ListTableViewCell {
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            userId.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            userId.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            contentStackView.leadingAnchor.constraint(equalTo: userId.trailingAnchor, constant: 16),
            contentStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            contentStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            contentStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
        ])
    }
    
}

//
//  MainInputTextfield.swift
//  CaseIOS
//
//  Created by Павел Кай on 08.04.2023.
//

import UIKit

class MainInputTextfield: UITextField {

    init(placeholder: String) {
        super.init(frame: .zero)
        
        self.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [.foregroundColor: UIColor.systemGray2])
        
        let leftPadding = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        leftView = leftPadding
        leftViewMode = .always
        
        autocorrectionType = .no
        autocapitalizationType = .none
        
        textColor = .black
        backgroundColor = .selectColor
        
        layer.cornerRadius = 12
        
        layer.borderColor = UIColor.gray.cgColor
        layer.borderWidth = 1
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

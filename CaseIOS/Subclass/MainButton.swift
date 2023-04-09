//
//  MainButton.swift
//  CaseIOS
//
//  Created by Павел Кай on 08.04.2023.
//

import UIKit

class MainButton: UIButton {
    
    init(title: String) {
        super.init(frame: .zero)
        
        setTitle(title, for: .normal)
        setTitleColor(.black, for: .normal)
        
        backgroundColor = .selectColor
        
        layer.cornerRadius = 12
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

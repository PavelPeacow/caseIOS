//
//  Color.swift
//  CaseIOS
//
//  Created by Павел Кай on 08.04.2023.
//

import UIKit

extension UIColor {
    
    static var selectColor: UIColor {
        .init(named: "selectColor") ?? .orange
    }
    
    static var mainBackgroundColor: UIColor {
        .init(named: "mainBackgroundColor") ?? .white
    }

    
}

//
//  TabBarViewController.swift
//  CaseIOS
//
//  Created by Павел Кай on 08.04.2023.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let list = UINavigationController(rootViewController: ListViewController())
        list.tabBarItem.title = "People"
        list.tabBarItem.image = UIImage(systemName: "person.fill")
        
        let products = UINavigationController(rootViewController: ProductsListViewController())
        products.tabBarItem.title = "Products"
        products.tabBarItem.image = UIImage(systemName: "list.bullet.clipboard")

        setViewControllers([list, products], animated: true)
    }
    

 
}

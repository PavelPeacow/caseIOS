//
//  ProductsViewModel.swift
//  CaseIOS
//
//  Created by Павел Кай on 09.04.2023.
//

import Foundation

class ProductsViewModel {
    
    var products = [Product]()
    var categories = [Category]()
    
    var manager = APIManager()
    
    
    func getProducts() async {
        do {
            let products = try await manager.makeAPICall(type: [Product].self, endpoint: .products)
            self.products = products
        } catch {
            print(error)
        }
    }
    
    func getCategories() async {
        do {
            let categories = try await manager.makeAPICall(type: [Category].self, endpoint: .categories)
            self.categories = categories
            print(self.categories)
        } catch {
            print(error)
        }
    }
    
}

//
//  ListViewModel.swift
//  CaseIOS
//
//  Created by Павел Кай on 08.04.2023.
//

import Foundation

class ListViewModel {
    
    var people = [User]()
    let manager = APIManager()
    
    func getPeopleList() async {
        do {
            let result = try await manager.makeAPICall(type: [User].self, endpoint: .users)
            people = result
        } catch {
            print(error)
        }
    }
    
}

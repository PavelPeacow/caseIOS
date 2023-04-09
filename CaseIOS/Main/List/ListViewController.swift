//
//  ListViewController.swift
//  CaseIOS
//
//  Created by Павел Кай on 08.04.2023.
//

import UIKit

class ListViewController: UIViewController {
    
    let viewModel = ListViewModel()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ListTableViewCell.self, forCellReuseIdentifier: ListTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .mainBackgroundColor
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "People"

        view.addSubview(tableView)
        
        Task {
            await viewModel.getPeopleList()
            tableView.reloadData()
        }
        
        setNavBar()
        setConstraints()
    }
    
    private func setNavBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .done, target: self, action: #selector(didTapAddPerson))
    }
    

}

extension ListViewController {
    
    @objc func didTapAddPerson() {
        print("add")
        let vc = ListDetailViewController()
        vc.setType(viewType: .addUser)
        vc.delegate = self
        present(vc, animated: true)
    }
    
}

extension ListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.people.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.identifier, for: indexPath) as! ListTableViewCell
        
        let person = viewModel.people[indexPath.row]
        
        cell.configure(user: person)
        cell.backgroundColor = .mainBackgroundColor
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
}

extension ListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let id = viewModel.people[indexPath.row].id
        
        Task {
            if let user = await viewModel.getUser(id: id) {
                let vc = ListDetailViewController()
                vc.configure(user: user)
                vc.setType(viewType: .changeUser)
                vc.delegate = self
                
                navigationController?.pushViewController(vc, animated: true)
            }
        }
        
    }
    
}

extension ListViewController: ListDetailViewControllerDelegate {
    
    func didUpdateList() {
        Task {
            await viewModel.getPeopleList()
            tableView.reloadData()
        }
    }
    
}

extension ListViewController {
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
}

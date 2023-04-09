//
//  ProductsListViewController.swift
//  CaseIOS
//
//  Created by Павел Кай on 09.04.2023.
//

import UIKit

class ProductsListViewController: UIViewController {
    
    let viewModel = ProductsViewModel()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ProductTableViewCell.self, forCellReuseIdentifier: ProductTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .mainBackgroundColor
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Products"
        
        view.addSubview(tableView)
        
        Task {
            await viewModel.getProducts()
            await viewModel.getCategories()
            tableView.reloadData()
        }
        
        setNavBar()
        setConstraints()
    }
    
    private func setNavBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .done, target: self, action: #selector(didTapAddPerson))
    }
    
    
}

extension ProductsListViewController {
    
    @objc func didTapAddPerson() {
        print("add")
        let vc = ListDetailViewController()
        vc.setType(viewType: .addUser)
        vc.delegate = self
        present(vc, animated: true)
    }
    
}

extension ProductsListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProductTableViewCell.identifier, for: indexPath) as! ProductTableViewCell
        
        let product = viewModel.products[indexPath.row]
        let category = viewModel.categories.first(where: { $0.id == product.category })
        
        cell.configure(product: product, categoryTitle: category?.title ?? "NO CATEGORY")
        
        
        cell.backgroundColor = .mainBackgroundColor
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
}

extension ProductsListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        //        let id = viewModel.people[indexPath.row].id
        //
        //        Task {
        //            if let user = await viewModel.getUser(id: id) {
        //                let vc = ListDetailViewController()
        //                vc.configure(user: user)
        //                vc.setType(viewType: .changeUser)
        //                vc.delegate = self
        //
        //                navigationController?.pushViewController(vc, animated: true)
        //            }
        //        }
        
    }
    
}

extension ProductsListViewController: ListDetailViewControllerDelegate {
    
    func didUpdateList() {
        Task {
            await viewModel.getProducts()
            tableView.reloadData()
        }
    }
    
}

extension ProductsListViewController {
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
}

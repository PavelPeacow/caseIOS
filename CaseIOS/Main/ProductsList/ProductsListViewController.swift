//
//  ProductsListViewController.swift
//  CaseIOS
//
//  Created by Павел Кай on 09.04.2023.
//

import UIKit
import SafariServices

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
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.bullet.rectangle.portrait"), style: .done, target: self, action: #selector(didTapExportBtn))
    }
    
    
}

extension ProductsListViewController {
    
    @objc func didTapExportBtn() {
        guard let url = URL(string: "http://82.148.18.70/document") else { return }
        let vc = SFSafariViewController(url: url)
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
        
        let product = viewModel.products[indexPath.row]
        let category = viewModel.categories.first(where: { $0.id == product.category })?.title ?? "NO CATEGORY"
        
        let vc = ProductDetailViewController()
        vc.configure(productTitle: product.title, category: category, id: product.id)
        vc.delegate = self
        
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
}

extension ProductsListViewController: ProductDetailViewControllerDelegate {
    
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

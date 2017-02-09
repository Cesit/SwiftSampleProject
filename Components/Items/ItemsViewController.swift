//
//  ItemsViewController.swift
//  SwiftSampleProject
//
//  Created by Christian Sjøgreen on 09/02/2017.
//  Copyright © 2017 Cesit. All rights reserved.
//

import UIKit

private let kCellIdentifier = "ItemCellIdentifier"

class ItemsViewController: UIViewController {

    let viewModel: ItemsViewModel

    // MARK: Views
    
    private(set) lazy var addItemButton: UIBarButtonItem = {
        return UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.createItemAction))
    }()

    private(set) lazy var placeholderLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 18)
        view.textColor = .gray
        view.textAlignment = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private(set) lazy var tableView: UITableView = {
        let view = UITableView()
        view.tableFooterView = UIView() // This removes empty rows.
        view.dataSource = self
        view.delegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // MARK: Initialization

    init(viewModel: ItemsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureSubviews()
        self.viewModel.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel.refresh()
    }

    // MARK: Configuration

    private func configureSubviews() {
        self.navigationItem.rightBarButtonItem = self.addItemButton
        
        self.view.backgroundColor = .white
        self.view.addSubview(self.placeholderLabel)
        self.view.addSubview(self.tableView)
        
        self.placeholderLabel.topAnchor.constraint(equalTo: self.topLayoutGuide.bottomAnchor).isActive = true
        self.placeholderLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.placeholderLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        self.placeholderLabel.bottomAnchor.constraint(equalTo: self.bottomLayoutGuide.topAnchor).isActive = true
        
        self.tableView.topAnchor.constraint(equalTo: self.topLayoutGuide.bottomAnchor).isActive = true
        self.tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: self.bottomLayoutGuide.topAnchor).isActive = true
    }
    
    // MARK: Actions
    
    @objc private func createItemAction() {
        self.viewModel.createItem()
    }
}

extension ItemsViewController: ItemsViewModelDelegate {
    
    func didSet(_ isLoading: Bool, in viewModel: ItemsViewModel) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = isLoading
        self.addItemButton.isEnabled = !isLoading
    }
    
    func didSet(_ placeholderText: String?, in viewModel: ItemsViewModel) {
        self.placeholderLabel.text = placeholderText
        self.placeholderLabel.isHidden = placeholderText == nil
        self.tableView.isHidden = placeholderText != nil
    }
    
    func didLoad(_ items: [Item], in viewModel: ItemsViewModel) {
        self.tableView.reloadData()
    }
    
    func didFailLoadingItems(with error: AlertMessage, in viewModel: ItemsViewModel) {
        self.presentAlert(with: error)
    }
    
    func didFailCreatingItem(with error: AlertMessage, in viewModel: ItemsViewModel) {
        self.presentAlert(with: error)
    }
}

extension ItemsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = {
            if let view = tableView.dequeueReusableCell(withIdentifier: kCellIdentifier) { return view }
            let view = UITableViewCell(style: .default, reuseIdentifier: kCellIdentifier)
            view.accessoryType = .disclosureIndicator
            return view
        }()
        cell.textLabel?.text = self.viewModel.items[indexPath.row].title
        return cell
    }
}

extension ItemsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let itemViewModel = ItemDetailViewModel(session: self.viewModel.session, item: self.viewModel.items[indexPath.row])
        let viewController = ItemDetailViewController(viewModel: itemViewModel)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

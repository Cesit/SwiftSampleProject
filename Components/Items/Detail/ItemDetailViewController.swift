//
//  ItemDetailViewController.swift
//  SwiftSampleProject
//
//  Created by Christian Sjøgreen on 09/02/2017.
//  Copyright © 2017 Cesit. All rights reserved.
//

import UIKit

class ItemDetailViewController: UIViewController {

    let viewModel: ItemDetailViewModel

    // MARK: Views
    
    private(set) lazy var idLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 12)
        view.textColor = .gray
        view.textAlignment = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private(set) lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 18)
        view.textColor = .gray
        view.textAlignment = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private(set) lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 16
        view.distribution = .equalSpacing
        view.alignment = .fill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // MARK: Initialization

    init(viewModel: ItemDetailViewModel) {
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
        self.idLabel.text = self.viewModel.item.id
        self.titleLabel.text = self.viewModel.item.title
    }

    // MARK: Configuration

    private func configureSubviews() {
        self.view.backgroundColor = .white
        self.view.addSubview(self.stackView)
        
        self.stackView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 8).isActive = true
        self.stackView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -8).isActive = true
        self.stackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        
        self.stackView.addArrangedSubview(self.idLabel)
        self.stackView.addArrangedSubview(self.titleLabel)
    }
}

extension ItemDetailViewController: ItemDetailViewModelDelegate {

}

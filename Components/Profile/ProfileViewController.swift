//
//  ProfileViewController.swift
//  SwiftSampleProject
//
//  Created by Christian Sjøgreen on 09/02/2017.
//  Copyright © 2017 Cesit. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    let viewModel: ProfileViewModel

    // MARK: Views

    private(set) lazy var placeholderLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 18)
        view.textColor = .gray
        view.text = "Profile"
        view.textAlignment = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // MARK: Initialization

    init(viewModel: ProfileViewModel) {
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

    // MARK: Configuration

    private func configureSubviews() {
        self.view.backgroundColor = .white
        self.view.addSubview(self.placeholderLabel)
        
        self.placeholderLabel.topAnchor.constraint(equalTo: self.topLayoutGuide.bottomAnchor).isActive = true
        self.placeholderLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.placeholderLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        self.placeholderLabel.bottomAnchor.constraint(equalTo: self.bottomLayoutGuide.topAnchor).isActive = true
    }
}

extension ProfileViewController: ProfileViewModelDelegate {

}

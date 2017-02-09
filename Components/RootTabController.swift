//
//  ViewController.swift
//  SwiftSampleProject
//
//  Created by Christian Sjøgreen on 09/02/2017.
//  Copyright © 2017 Cesit. All rights reserved.
//

import UIKit

class RootTabController: UITabBarController {
    
    let viewModel: RootTabViewModel
    
    private(set) lazy var itemsViewController: UIViewController = {
        let viewController = ItemsViewController(viewModel: ItemsViewModel(session: self.viewModel.session))
        let title = NSLocalizedString("Items", comment: "")
        viewController.title = title
        viewController.tabBarItem = UITabBarItem(title: title, image: #imageLiteral(resourceName: "icon_cupcake_30"), tag: 1)
        return viewController
    }()
    
    private(set) lazy var profileViewController: UIViewController = {
        let viewController = ProfileViewController(viewModel: ProfileViewModel(session: self.viewModel.session))
        let title = NSLocalizedString("Profile", comment: "")
        viewController.title = title
        viewController.tabBarItem = UITabBarItem(title: title, image: #imageLiteral(resourceName: "icon_profile_circle_30"), tag: 2)
        return viewController
    }()
    
    init(viewModel: RootTabViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewControllers = [
            UINavigationController(rootViewController: self.itemsViewController),
            UINavigationController(rootViewController: self.profileViewController)
        ]
    }
}

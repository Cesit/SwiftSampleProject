//
//  AppDelegate.swift
//  SwiftSampleProject
//
//  Created by Christian Sjøgreen on 09/02/2017.
//  Copyright © 2017 Cesit. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    #if DEBUG
    private let endpoints = MockEndpoints()
    #else
    private let endpoints = BackendEndpoints()
    #endif

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        self.applyAppearances()
        
        self.window = UIWindow()
        self.window?.rootViewController = {
            let session = Session(endpoints: self.endpoints)
            let viewModel = RootTabViewModel(session: session)
            return RootTabController(viewModel: viewModel)
        }()
        self.window?.makeKeyAndVisible()
        
        return true
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Let the app react when it re-appears.
        self.window?.rootViewController?.viewWillAppear(true)
    }
    
    private func applyAppearances() {
        UITabBar.appearance().tintColor = .appPurple
        UINavigationBar.appearance().tintColor = .appPurple
    }
}

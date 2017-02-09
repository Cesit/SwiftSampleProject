//
//  UIViewController+Extensions.swift
//  SwiftSampleProject
//
//  Created by Christian Sjøgreen on 09/02/2017.
//  Copyright © 2017 Cesit. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func presentAlert(with message: AlertMessage, animated: Bool = true, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: message.title, message: message.message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: "Dialog OK button"), style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: animated, completion: completion)
    }
}

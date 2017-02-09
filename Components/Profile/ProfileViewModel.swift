//
//  ProfileViewModel.swift
//  SwiftSampleProject
//
//  Created by Christian Sjøgreen on 09/02/2017.
//  Copyright © 2017 Cesit. All rights reserved.
//

import Foundation

protocol ProfileViewModelDelegate: class {

}

class ProfileViewModel {

    let session: Session
    
    weak var delegate: ProfileViewModelDelegate?

    init(session: Session) {
        self.session = session
    }
}

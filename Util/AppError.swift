//
//  TextError.swift
//  SwiftSampleProject
//
//  Created by Christian Sjøgreen on 09/02/2017.
//  Copyright © 2017 Cesit. All rights reserved.
//

import Foundation

struct TextError: Error {
    let localizedDescription: String
    
    init(_ localizedDescription: String) {
        self.localizedDescription = localizedDescription
    }
}

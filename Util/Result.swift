//
//  Result.swift
//  SwiftSampleProject
//
//  Created by Christian Sjøgreen on 09/02/2017.
//  Copyright © 2017 Cesit. All rights reserved.
//

import Foundation

enum Result<T> {
    case success(T)
    case failure(TextError)
}

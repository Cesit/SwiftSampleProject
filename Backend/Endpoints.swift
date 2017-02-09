//
//  Endpoints.swift
//  SwiftSampleProject
//
//  Created by Christian Sjøgreen on 09/02/2017.
//  Copyright © 2017 Cesit. All rights reserved.
//

import Foundation

protocol Endpoints {
    func requestItems(completion: @escaping (Result<[Item]>) -> ())
    func create(item: Item, completion: @escaping (Result<Item>) -> ())
}

//
//  BackendEndpoints.swift
//  SwiftSampleProject
//
//  Created by Christian Sjøgreen on 09/02/2017.
//  Copyright © 2017 Cesit. All rights reserved.
//

import Foundation

struct BackendEndpoints: Endpoints {
    
    let url = URL(string: "https://www.example.com")!
    
    func requestItems(completion: @escaping (Result<[Item]>) -> ()) {
        preconditionFailure("requestItems not implemented")
    }
    
    func create(item: Item, completion: @escaping (Result<Item>) -> ()) {
        preconditionFailure("create(item) not implemented")
    }
}

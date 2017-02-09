//
//  MockEndpoints.swift
//  SwiftSampleProject
//
//  Created by Christian Sjøgreen on 09/02/2017.
//  Copyright © 2017 Cesit. All rights reserved.
//

import Foundation

private let kMockDelay: Double = 2
private let kRandomError = TextError("A random error occured!")

struct MockEndpoints: Endpoints {
    
    private let mockNetworkQueue: DispatchQueue = DispatchQueue.init(label: "MockEndpoints")
    
    var randomSuccess: Bool {
        return Int(arc4random_uniform(3) + 1) > 1
    }
    
    func requestItems(completion: @escaping (Result<[Item]>) -> ()) {
        let items = [
            Item(id: UUID().uuidString, title: "Item 1"),
            Item(id: UUID().uuidString, title: "Item 2"),
            Item(id: UUID().uuidString, title: "Item 3"),
            Item(id: UUID().uuidString, title: "Item 4")
        ]
        self.mockNetworkQueue.asyncAfter(deadline: .now() + kMockDelay) {
            completion(.success(items))
        }
    }
    
    func create(item: Item, completion: @escaping (Result<Item>) -> ()) {
        self.mockNetworkQueue.asyncAfter(deadline: .now() + kMockDelay) {
            guard self.randomSuccess else { completion(.failure(kRandomError)); return }
            let createdItem = Item(id: UUID().uuidString, title: item.title)
            completion(.success(createdItem))
        }
    }
}

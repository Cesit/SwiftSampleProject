//
//  Session.swift
//  SwiftSampleProject
//
//  Created by Christian Sjøgreen on 09/02/2017.
//  Copyright © 2017 Cesit. All rights reserved.
//

import Foundation

/// Manages the local state of remote resources.
class Session {
    
    private let endpoints: Endpoints
    
    private var didLoadItems: Bool = false
    private var items: [Item] = []
    
    init(endpoints: Endpoints) {
        self.endpoints = endpoints
    }
    
    /// GET items.
    /// Can return cached result after first load.
    /// - Parameter cached: Set this to `true` to allow cached results.
    /// - Parameter completion: Called with list of items.
    func requestItems(cached: Bool, completion: @escaping (Result<[Item]>) -> ()) {
        if self.didLoadItems && cached {
            completion(Result.success(self.items));
            return
        }
        self.endpoints.requestItems() { result in
            if case .success(let items) = result {
                self.items = items
                self.didLoadItems = true
            }
            DispatchQueue.main.async { completion(result) }
        }
    }
    
    /// POST item.
    /// Will append item to cached list on success.
    /// - parameter completion: Called with updated list of items or error.
    func create(item: Item, completion: @escaping (Result<[Item]>) -> ()) {
        self.endpoints.create(item: item) {
            switch $0 {
            case .success(let item):
                self.items.append(item)
                DispatchQueue.main.async { completion(.success(self.items)) }
            case .failure(let error):
                DispatchQueue.main.async { completion(.failure(error)) }
            }
        }
    }
}

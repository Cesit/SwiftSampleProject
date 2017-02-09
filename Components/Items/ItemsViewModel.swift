//
//  ItemsViewModel.swift
//  SwiftSampleProject
//
//  Created by Christian Sjøgreen on 09/02/2017.
//  Copyright © 2017 Cesit. All rights reserved.
//

import Foundation

protocol ItemsViewModelDelegate: class {
    func didSet(_ placeholderText: String?, in viewModel: ItemsViewModel)
    func didSet(_ isLoading: Bool, in viewModel: ItemsViewModel)
    func didLoad(_ items: [Item], in viewModel: ItemsViewModel)
    func didFailLoadingItems(with error: AlertMessage, in viewModel: ItemsViewModel)
    func didFailCreatingItem(with error: AlertMessage, in viewModel: ItemsViewModel)
}

class ItemsViewModel {

    let session: Session
    
    weak var delegate: ItemsViewModelDelegate?
    
    private(set) var items: [Item] = [] {
        didSet {
            self.placeholderText = self.items.count == 0 ? NSLocalizedString("No items", comment: "") : nil
            self.delegate?.didLoad(self.items, in: self)
        }
    }
    
    private(set) var placeholderText: String? { didSet { self.delegate?.didSet(self.placeholderText, in: self) } }
    
    private(set) var isLoading: Bool = false { didSet { self.delegate?.didSet(self.isLoading, in: self) } }

    init(session: Session) {
        self.session = session
    }
    
    /// Refreshing the view model will trigger ItemsViewModelDelegate didLoad or didFailLoadingItems.
    func refresh() {
        if self.items.count == 0 {
            self.placeholderText = NSLocalizedString("Loading", comment: "")
            self.isLoading = true
        }
        self.session.requestItems(cached: true) {
            self.isLoading = false
            switch $0 {
            case .success(let items):
                self.items = items // TODO: Use Changeset pod (or similar) to determine insertions/deletions/updates.
            case .failure(let error):
                let message = AlertMessage(title: NSLocalizedString("Could not update items", comment: ""), message: error.localizedDescription)
                self.delegate?.didFailLoadingItems(with: message, in: self)
            }
        }
    }
    
    func createItem() {
        self.isLoading = true
        let dummyItem = Item(id: "new", title: NSLocalizedString("Created item", comment: ""))
        self.session.create(item: dummyItem) {
            self.isLoading = false
            switch $0 {
            case .success(let items):
                self.items = items // TODO: Use Changeset pod (or similar) to determine insertions/deletions/updates.
            case .failure(let error):
                let message = AlertMessage(title: NSLocalizedString("Could not create item", comment: ""), message: error.localizedDescription)
                self.delegate?.didFailCreatingItem(with: message, in: self)
            }
        }
    }
}

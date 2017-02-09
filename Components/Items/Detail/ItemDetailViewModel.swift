//
//  ItemDetailViewModel.swift
//  SwiftSampleProject
//
//  Created by Christian Sjøgreen on 09/02/2017.
//  Copyright © 2017 Cesit. All rights reserved.
//

import Foundation

protocol ItemDetailViewModelDelegate: class {

}

class ItemDetailViewModel {

    let session: Session
    
    weak var delegate: ItemDetailViewModelDelegate?
    
    private(set) var item: Item

    init(session: Session, item: Item) {
        self.session = session
        self.item = item
    }
}

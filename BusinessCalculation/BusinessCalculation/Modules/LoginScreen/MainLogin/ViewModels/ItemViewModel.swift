//
//  ItemViewModel.swift
//  BusinessCalculation
//
//  Created by VPDev on 10.04.2023.
//

import Foundation

class ItemViewModel {
    private var content: Content
    
    init(content: Content) {
        self.content = content
    }
}

extension ItemViewModel: ItemViewModelProtocol {
    var imageName: String {
        content.imageName
    }
    var title: String {
        content.title
    }
    var description: String {
        content.description
    }
}

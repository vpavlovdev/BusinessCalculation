//
//  Dynamic.swift
//  BusinessCalculation
//
//  Created by VPDev on 14.04.2023.
//

import Foundation

class Dynamic<T> {
    typealias Listener = (T) -> Void
    private var listener: Listener?
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    func bind(_ listener: Listener?) {
        self.listener = listener
    }
    
    init(value: T) {
        self.value = value
    }
}

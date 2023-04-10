//
//  LoginViewModelProtocol.swift
//  BusinessCalculation
//
//  Created by VPDev on 10.04.2023.
//

import Foundation

protocol LoginViewModelProtocol {
    func numberOfItemsInSEction() -> Int
    func itemViewModel(forIndexPath indexPath: IndexPath) -> ItemViewModelProtocol?
    
}

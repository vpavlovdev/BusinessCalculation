//
//  LoginViewModel.swift
//  BusinessCalculation
//
//  Created by VPDev on 10.04.2023.
//

import Foundation

class LoginViewModel {
    private let contents: [Content] = [
        .init(title: "Welcome to BusiCal",
              imageName: ImageNames.firstImage,
              description: "BusiCal - Это готовое решение для Вашего бизнеса"),
        .init(title: "Появилась идея для бизнеса?",
              imageName: ImageNames.secondImage,
              description: "Расчеты для бизнеса у Вас в кармане"),
        .init(title: "Владете бизнесом?",
              imageName: ImageNames.thirdImage,
              description: "BusiCal поможет Вам управлять им")]
    
    
}

extension LoginViewModel: LoginViewModelProtocol {
    func itemViewModel(forIndexPath indexPath: IndexPath) -> ItemViewModelProtocol? {
        let content = contents[indexPath.row]
        return ItemViewModel(content: content)
    }
    
    func numberOfItemsInSEction() -> Int {
        return contents.count
    }
    
    
    
}

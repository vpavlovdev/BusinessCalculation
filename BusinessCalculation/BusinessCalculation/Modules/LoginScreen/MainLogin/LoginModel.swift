//
//  LoginModel.swift
//  BusinessCalculation
//
//  Created by VPDev on 11.03.2023.
//

import Foundation

struct Content {
    let title: String
    let imageName: String
    let description: String
    
}

struct Source {
    static func makeContent() -> [Content] {
        return [.init(title: "Welcome to BusiCal", imageName: ImageNames.firstImage, description: "BusiCal - Это готовое решение для Вашего бизнеса"),
                .init(title: "Появилась идея для бизнеса?", imageName: ImageNames.secondImage, description: "Расчеты для бизнеса у Вас в кармане"),
                .init(title: "Владете бизнесом?", imageName: ImageNames.thirdImage, description: "BusiCal поможет Вам управлять им")]
    }
}

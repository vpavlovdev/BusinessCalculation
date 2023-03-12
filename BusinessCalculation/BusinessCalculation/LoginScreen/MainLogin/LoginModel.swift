//
//  LoginModel.swift
//  BusinessCalculation
//
//  Created by VPDev on 11.03.2023.
//

import Foundation

class Content {
    let title: String
    let imageName: String
    let position: Int
    
    init(title: String, imageName: String, position: Int) {
        self.title = title
        self.imageName = imageName
        self.position = position
    }
}

struct Source {
    static func makeContent() -> [Content] {
        return [.init(title: "Welcome to BusiCal", imageName: "1", position: 0),
                .init(title: "Готовое решение для Вашего бизнеса", imageName: "2", position: 1),
                .init(title: "Расчеты для бизнеса у Вас в кармане", imageName: "3", position: 2)]
    }
}

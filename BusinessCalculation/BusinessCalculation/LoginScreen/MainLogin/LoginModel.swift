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
    let description: String
    
    init(title: String, imageName: String, description: String) {
        self.title = title
        self.imageName = imageName
        self.description = description
    }
}

struct Source {
    static func makeContent() -> [Content] {
        return [.init(title: "Welcome to BusiCal", imageName: "1", description: "Description 1"),
                .init(title: "Готовое решение для Вашего бизнеса", imageName: "2", description: "Description 2"),
                .init(title: "Расчеты для бизнеса у Вас в кармане", imageName: "3", description: "Description 3")]
    }
}

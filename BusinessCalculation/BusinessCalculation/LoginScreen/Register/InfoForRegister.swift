//
//  InfoForRegister.swift
//  BusinessCalculation
//
//  Created by VPDev on 13.03.2023.
//

import Foundation

enum TypeCell {
    case firstName
    case lastName
    case email
    case password
    
    var placeholder: String {
        switch self {
        case .firstName: return "First name"
        case .lastName: return "Last name"
        case .email: return "Email"
        case .password: return "Password(8 or more characters)"
        }
    }
}

struct RegisterSource {
    static func textField() -> [TypeCell] {
        [TypeCell.firstName, TypeCell.lastName, TypeCell.email, TypeCell.password]
    }
}



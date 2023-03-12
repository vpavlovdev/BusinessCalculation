//
//  CustomButons.swift
//  BusinessCalculation
//
//  Created by VPDev on 11.03.2023.
//

import UIKit

enum CustomButtonType {
    case login
    case registration
    
    var title: String {
        switch self {
        case .login: return "Log In"
        case .registration: return "New to BusiCal? Sign Up"
        }
    }
    var textColor: UIColor {
        switch self {
        case .login: return .white
        case .registration: return .black
        }
    }
    var backgroundColor: UIColor {
        switch self {
        case .registration: return .clear
        default: return .green
        }
    }
    var borderColor: CGColor {
        switch self {
        case .registration: return UIColor.black.cgColor //need clear 
        default: return UIColor.black.cgColor
        }
    }
    
    var borderWidth: CGFloat {
        switch self {
        case .registration: return 1 // need 0
        default: return 1
        }
    }
    var font: UIFont {
        switch self {
        case .registration: return .italicSystemFont(ofSize: 20)
        default: return .systemFont(ofSize: 20)
        }
    }
}

final class CustomButton: UIButton {
    var type: CustomButtonType?
    var selector: Selector?
    
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    func configure(type: CustomButtonType) {
        setTitle(type.title, for: .normal)
        setTitleColor(type.textColor, for: .normal)
        backgroundColor = type.backgroundColor
        layer.cornerRadius = 15
        layer.borderWidth = type.borderWidth
        layer.borderColor = type.borderColor
        titleLabel?.font = type.font
    }
}

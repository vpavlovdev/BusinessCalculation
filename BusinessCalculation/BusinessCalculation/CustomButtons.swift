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
    case google
    case apple
    case createButton
    
    var title: String {
        switch self {
        case .login: return "Log In"
        case .registration: return "New to BusiCal? Sign Up"
        case .google: return "Continue with Google"
        case .apple: return "Continue with Apple"
        case .createButton: return "Create my account"
        }
    }
    var textColor: UIColor {
        switch self {
        case .login: return .white
        case .registration: return #colorLiteral(red: 0.1057885811, green: 0.09331270307, blue: 0.6688950658, alpha: 1)
        case .google: return .white
        case .apple: return .black
        case .createButton: return .white
        }
    }
    var backgroundColor: UIColor {
        switch self {
        case .registration: return .clear
        default: return .currentPageControl
        }
    }
    var borderColor: CGColor {
        switch self {
        case .registration: return UIColor.clear.cgColor //need clear
        default: return UIColor.black.cgColor
        }
    }
    
    var borderWidth: CGFloat {
        switch self {
        case .registration: return 0 // need 0
        case .login: return 0
        default: return 1
        }
    }
    var imageName: String {
        switch self {
        case .google: return "google"
        default: return ""
        }
    }
    var font: UIFont {
        switch self {
        case .registration: return .italicSystemFont(ofSize: 22)
        case .google: return .boldSystemFont(ofSize: 18)
        default: return .boldSystemFont(ofSize: 22)
        }
    }
}

final class CustomButton: UIButton {
    var type: CustomButtonType?
   
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
    func checkConfigure() {
        setBackgroundImage(UIImage(), for: .normal)
        layer.cornerRadius = 10
        layer.borderWidth = 2
        layer.borderColor = UIColor.gray.cgColor
    }
}

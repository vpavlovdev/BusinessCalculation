//
//  CustomTextField.swift
//  BusinessCalculation
//
//  Created by VPDev on 12.03.2023.
//

import UIKit

class CustomTextField: UITextField {
    private var secureText = true
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSettings()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    func setupSettings() {
        layer.cornerRadius = 10
        layer.borderWidth = 2
        layer.borderColor = UIColor.gray.cgColor
        clearButtonMode = .whileEditing
        textColor = .black
    }
    func setupPersonImageLeftView() {
        guard let personImage = UIImage(systemName: "person.fill") else { return }
        let view = UIView(frame: CGRect(x: 0, y: 0, width: personImage.size.width, height: personImage.size.height))
        let imageView = UIImageView(frame: CGRect(x: 7, y: 0, width: personImage.size.width, height: personImage.size.height))
        imageView.tintColor = .black
        imageView.image = personImage
        view.addSubview(imageView)
        leftView = view
        leftViewMode = .always
        addSubview(view)
    }
    func setupEyeImageLeftView() {
        guard let eyeImage = UIImage(systemName: "eye"),
              let eyeSlash = UIImage(systemName: "eye.slash") else { return }
        let view = UIView(frame: CGRect(x: 0, y: 0, width: eyeImage.size.width, height: eyeImage.size.height))
        let imageView = UIImageView(frame: CGRect(x: -7, y: 0, width: eyeImage.size.width, height: eyeImage.size.height))
        imageView.tintColor = .black
        isSecureTextEntry = secureText
        imageView.image = isSecureTextEntry ? eyeImage : eyeSlash
        view.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(actionImage))
        view.addGestureRecognizer(tapGesture)
        view.addSubview(imageView)
        rightView = view
        rightViewMode = .always
        addSubview(view)
    }
    
    @objc private func actionImage(sender: UITapGestureRecognizer) {
        let tappedImage = sender.view as? UIImageView
        print(secureText)
        if secureText {
            isSecureTextEntry = false
            secureText = false
            tappedImage?.image = UIImage(systemName: "eye")
        } else {
            tappedImage?.image = UIImage(systemName: "eye.slash")
            isSecureTextEntry = true
            secureText = true
        }
    }
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        .init(x: 35, y: 0, width: bounds.width, height: bounds.height)
    }
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        .init(x: 35, y: 0, width: bounds.width, height: bounds.height)
    }
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        .init(x: 35, y: 0, width: bounds.width, height: bounds.height)
    }
    

}

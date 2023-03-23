//
//  CustomTextField.swift
//  BusinessCalculation
//
//  Created by VPDev on 12.03.2023.
//

import UIKit

final class CustomTextField: UITextField {
    private var secureText = true
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSettings()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    //MARK: Settings
    func setupSettings() {
        layer.cornerRadius = 10
        layer.borderWidth = 2
        layer.borderColor = UIColor.gray.cgColor
        clearButtonMode = .whileEditing
        textColor = .black
    }
    //MARK: PersonLeftImage
    func setupPersonImageLeftView() {
        guard let personImage = UIImage(systemName: "person.fill") else { return }
        let view = UIView(frame: CGRect(x: 0, y: 0, width: personImage.size.width, height: personImage.size.height))
        let imageView = UIImageView(frame: CGRect(x: 7, y: 0, width: personImage.size.width, height: personImage.size.height))
        keyboardType = .URL
        imageView.tintColor = .black
        imageView.image = personImage
        view.addSubview(imageView)
        leftView = view
        leftViewMode = .always
        addSubview(view)
    }
    //MARK: EyeRightImage
    func setupEyeImageLeftView() {
        guard let eyeImage = UIImage(systemName: "eye") else { return }
        let view = UIView(frame: CGRect(x: 0, y: 0, width: eyeImage.size.width, height: eyeImage.size.height))
        let imageView = UIImageView(frame: CGRect(x: -7, y: 0, width: eyeImage.size.width, height: eyeImage.size.height))
        imageView.tintColor = .black
        imageView.image = eyeImage
        textContentType = .password
        isSecureTextEntry = secureText
        
        //MARK: TapGesture for secure
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(actionImage))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGesture)
        
        view.addSubview(imageView)
        rightView = view
        rightViewMode = .always
        addSubview(view)
    }
    //MARK: Action for tapGesture
    @objc private func actionImage(sender: UITapGestureRecognizer) {
        let tappedImage = sender.view as? UIImageView
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
        .init(x: 30, y: 0, width: bounds.width, height: bounds.height)
    }
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        .init(x: 30, y: 0, width: bounds.width, height: bounds.height)
    }
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        .init(x: 30, y: 0, width: bounds.width, height: bounds.height)
    }
  
    

}

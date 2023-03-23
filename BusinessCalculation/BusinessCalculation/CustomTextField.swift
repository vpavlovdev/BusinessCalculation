//
//  CustomTextField.swift
//  BusinessCalculation
//
//  Created by VPDev on 12.03.2023.
//

import UIKit

final class CustomTextField: UITextField {
    private var secureText = true
    private var secureButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        button.tintColor = .black
        button.setImage(UIImage(systemName: "eye"), for: .normal)
        return button
    }()
    
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
    //MARK: SecureButton
    func setupSecureButton() {
        textContentType = .password
        isSecureTextEntry = secureText
        rightView = secureButton
        rightViewMode = .always
        secureButton.addTarget(self, action: #selector(tappedButton), for: .touchUpInside)
    }
    //MARK: Method for secure
    @objc func tappedButton() {
        self.resignFirstResponder()
        if secureText == true {
            isSecureTextEntry = false
            secureText = false
            secureButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        } else if secureText == false {
            secureButton.setImage(UIImage(systemName: "eye"), for: .normal)
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
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        .init(x: bounds.width - 40, y: 0, width: 40, height: bounds.height)
    }
  
    

}

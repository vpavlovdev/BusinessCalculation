//
//  CustomTextField.swift
//  BusinessCalculation
//
//  Created by VPDev on 12.03.2023.
//

import UIKit

class CustomTextField: UITextField {

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
        guard let personImage = UIImage(systemName: "person.circle") else { return }
        let view = UIView(frame: CGRect(x: 0, y: 0, width: personImage.size.width, height: personImage.size.height))
        let imageView = UIImageView(frame: CGRect(x: 7, y: 0, width: personImage.size.width, height: personImage.size.height))
        imageView.tintColor = .black
        imageView.image = personImage
        view.addSubview(imageView)
        leftView = view
        leftViewMode = .always
        addSubview(view)
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

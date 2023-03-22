//
//  GoogleButton.swift
//  BusinessCalculation
//
//  Created by VPDev on 22.03.2023.
//

import UIKit

final class GoogleButton: UIButton {
    private var label: UILabel = {
        let label = UILabel()
        label.text = CustomButtonType.google.title
        label.textColor = CustomButtonType.google.textColor
        label.font = CustomButtonType.google.font
        return label
    }()
    
    private let googleImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: CustomButtonType.google.imageName)
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented")  }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    private func setupButton() {
        backgroundColor = CustomButtonType.google.backgroundColor
        layer.borderWidth = CustomButtonType.google.borderWidth
        layer.borderColor = CustomButtonType.google.borderColor
        layer.cornerRadius = 15
        self.addTarget(self, action: #selector(tapped), for: .touchUpInside)
        [googleImage, label].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        NSLayoutConstraint.activate([
            googleImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            googleImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            googleImage.widthAnchor.constraint(equalToConstant: 45),
            googleImage.heightAnchor.constraint(equalToConstant: 45),
            
            label.widthAnchor.constraint(equalToConstant: 180),
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            label.heightAnchor.constraint(equalToConstant: 25),
        ])
    }
    @objc private func tapped() {
        UIView.animate(withDuration: 0.1, delay: 0.1, options: .curveEaseIn) {
            self.alpha = 0.7
        } completion: { _ in
            self.alpha = 1
        }

    }
    
    
}

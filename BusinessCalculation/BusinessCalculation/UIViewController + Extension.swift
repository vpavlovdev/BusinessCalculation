//
//  UIViewController + Extension.swift
//  BusinessCalculation
//
//  Created by VPDev on 19.04.2023.
//

import Foundation
import UIKit

extension UIViewController {
    //MARK: Create SeparatorView
    func createSeparator() -> UIView {
        let separatorView = UIView()
        let viewOne = UIView()
        viewOne.backgroundColor = .gray
        let viewTwo = UIView()
        viewTwo.backgroundColor = .gray
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.text = "or"
        
        [viewOne, viewTwo, label].forEach {
            separatorView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: separatorView.centerXAnchor),
            label.widthAnchor.constraint(equalToConstant: 20),
            label.heightAnchor.constraint(equalToConstant: 20),
            
            viewOne.centerYAnchor.constraint(equalTo: label.centerYAnchor),
            viewOne.leadingAnchor.constraint(equalTo: separatorView.leadingAnchor, constant: 30),
            viewOne.trailingAnchor.constraint(equalTo: label.leadingAnchor, constant: -10),
            viewOne.heightAnchor.constraint(equalToConstant: 1),
            
            viewTwo.centerYAnchor.constraint(equalTo: label.centerYAnchor),
            viewTwo.leadingAnchor.constraint(equalTo: label.trailingAnchor, constant: 10),
            viewTwo.trailingAnchor.constraint(equalTo: separatorView.trailingAnchor, constant: -30),
            viewTwo.heightAnchor.constraint(equalToConstant: 1),
        ])
        return separatorView
    }
}

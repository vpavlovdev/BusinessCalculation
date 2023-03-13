//
//  LoginCollectionViewCell.swift
//  BusinessCalculation
//
//  Created by VPDev on 13.03.2023.
//

import UIKit

class LoginCollectionViewCell: UICollectionViewCell {
    private let mainImageView = UIImageView()
    private let mainLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .blue
        label.font = .boldSystemFont(ofSize: 22)
        return label
    }()
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: 20)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func setupCell() {
        [mainImageView, mainLabel, descriptionLabel].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        NSLayoutConstraint.activate([
        
        
        ])
    }
}

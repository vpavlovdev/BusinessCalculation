//
//  LoginCollectionViewCell.swift
//  BusinessCalculation
//
//  Created by VPDev on 13.03.2023.
//

import UIKit
//MARK: LocalConstants
fileprivate enum LocalConstants {
    static let mainLabelFont: CGFloat = 23
    static let descriptionLabelFont: CGFloat = 20
}
class LoginCollectionViewCell: UICollectionViewCell {
    private let mainImageView = UIImageView()
    private let mainLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .onboardingTextColor
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: LocalConstants.mainLabelFont)
        return label
    }()
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .onboardingDescriptionColor
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: LocalConstants.descriptionLabelFont)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    @available (*, unavailable)
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    //MARK: Setup Cell
    private func setupCell() {
        [mainImageView, mainLabel, descriptionLabel].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        NSLayoutConstraint.activate([
            mainImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mainImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            mainImageView.heightAnchor.constraint(equalToConstant: 320),
            
            mainLabel.topAnchor.constraint(equalTo: mainImageView.bottomAnchor, constant: 6),
            mainLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            mainLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            mainLabel.heightAnchor.constraint(equalToConstant: 30),
            
            descriptionLabel.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 3),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    //MARK: Configure UICollectionViewCell(public)
    func configureCell(content: ItemViewModelProtocol) {
        mainImageView.image = UIImage(named: content.imageName)
        mainLabel.text = content.title
        descriptionLabel.text = content.description
    }
}

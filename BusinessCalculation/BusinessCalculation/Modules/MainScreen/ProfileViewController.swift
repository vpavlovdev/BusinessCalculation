//
//  ProfileViewController.swift
//  BusinessCalculation
//
//  Created by VPDev on 24.03.2023.
//

import UIKit
fileprivate enum LocalConstants {
    static let widthProfileImage: CGFloat = 150
    static let heightProfileImage: CGFloat = 150
}
final class ProfileViewController: UIViewController {
    private lazy var editButton = createBarButtonItem(
        imageName: ImageNames.editButton,
        action:#selector(editButtonTapped))
    private var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "1")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = LocalConstants.heightProfileImage / 2
        imageView.layer.zPosition = 1
        imageView.layer.shadowOffset = .init(width: 1, height: 4)
        imageView.layer.shadowColor = UIColor.red.cgColor
        imageView.layer.shadowOpacity = 15.0
        imageView.layer.shadowRadius = 20.0
        imageView.layer.shouldRasterize = true
        imageView.layer.rasterizationScale = UIScreen.main.scale
        return imageView
    }()
    
    
    //MARK: Lifecicle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUserInterface()
        setupNavigationBar()
       
    }
    //MARK: Setup NavBar
    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = editButton
        navigationItem.backButtonTitle = ""
    }
    //MARK: Setup UserInterface
    private func setupUserInterface() {
        view.backgroundColor = .mainWhite
        
        [profileImageView].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: LocalConstants.widthProfileImage),
            profileImageView.heightAnchor.constraint(equalToConstant: LocalConstants.heightProfileImage),
        
          
        ])
        
    }
    //MARK: Private methods
    @objc private func editButtonTapped() {
        let vc = EditProfileViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

//MARK: Extention ProfileViewController
extension ProfileViewController {
    //Create custom button for NavBar
    private func createBarButtonItem(imageName: String, action: Selector) -> UIBarButtonItem {
        let button = UIButton(type: .system)
        button.setImage(
            UIImage(systemName: imageName)?.withRenderingMode(.alwaysTemplate),
            for: .normal)
        button.tintColor = navigationController?.navigationBar.tintColor
        button.imageView?.contentMode = .scaleAspectFit
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.addTarget(self, action: action, for: .touchUpInside)
        let barButtonItem = UIBarButtonItem(customView: button)
        return barButtonItem
    }
}

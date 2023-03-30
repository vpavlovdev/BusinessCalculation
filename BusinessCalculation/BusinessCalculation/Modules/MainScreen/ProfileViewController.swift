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
    static let cornerRadius: CGFloat = heightProfileImage / 2
    static let userName: String = "Unknown user"
    static let fontUserName: CGFloat = 22
}

final class ProfileViewController: UIViewController {
    private lazy var editButton = createBarButtonItem(
        imageName: ImageNames.editButton,
        action:#selector(editButtonTapped))
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: ImageNames.userImage)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = LocalConstants.cornerRadius
        imageView.layer.zPosition = 1
        return imageView
    }()
    private let shadowView: UIView = {
        let view = UIView()
        view.clipsToBounds = false
        view.backgroundColor = .mainScreen
        view.layer.cornerRadius = LocalConstants.cornerRadius
        view.layer.shadowColor = UIColor.selectedTabBarItem.cgColor
        view.layer.shadowOffset = CGSize(width: 2.0, height: 8.0)
        view.layer.shadowRadius = 15.0
        view.layer.shadowOpacity = 0.75
        view.layer.shouldRasterize = true
        view.layer.rasterizationScale = UIScreen.main.scale
        view.layer.zPosition = 0.1
        return view
    }()
    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: LocalConstants.fontUserName)
        label.text = LocalConstants.userName
        return label
    }()
    private let logoutButton: CustomButton = {
        let button = CustomButton()
        button.configure(type: .logoutButton)
        return button
    }()
    
    
    //MARK: Lifecicle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUserInterface()
        setupNavigationBar()
        addMethods()
       
    }
    //MARK: Setup NavBar
    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = editButton
        navigationItem.backButtonTitle = ""
    }
    //MARK: Setup UserInterface
    private func setupUserInterface() {
        view.backgroundColor = .mainScreen
        [shadowView, profileImageView, userNameLabel, logoutButton].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: LocalConstants.widthProfileImage),
            profileImageView.heightAnchor.constraint(equalToConstant: LocalConstants.heightProfileImage),
            
            shadowView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            shadowView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            shadowView.widthAnchor.constraint(equalToConstant: LocalConstants.widthProfileImage),
            shadowView.heightAnchor.constraint(equalToConstant: LocalConstants.heightProfileImage),
            
            userNameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 30),
            userNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            userNameLabel.heightAnchor.constraint(equalToConstant: 30),
            userNameLabel.widthAnchor.constraint(equalToConstant: 150),
            
            logoutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            logoutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            logoutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            logoutButton.heightAnchor.constraint(equalToConstant: 50)
          
        ])
        
    }
    //MARK: Add method
    private func addMethods() {
        logoutButton.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
    }
    //MARK: Private methods
    @objc private func editButtonTapped() {
        let vc = EditProfileViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc private func logoutButtonTapped() {
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(vc: LoginViewController())
        UserDefaults.standard.set(false, forKey: "Loged")
    }
    
}

//MARK: Extention ProfileViewController
extension ProfileViewController: CreateNavBarItemProtocol {
    //Create custom button for NavBar
}

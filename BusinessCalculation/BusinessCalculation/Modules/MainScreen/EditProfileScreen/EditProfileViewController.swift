//
//  EditProfileViewController.swift
//  BusinessCalculation
//
//  Created by VPDev on 28.03.2023.
//

import UIKit
fileprivate enum LocalConstants {
    static let widthProfileImage: CGFloat = 150
    static let heightProfileImage: CGFloat = 150
    static let cornerRadius: CGFloat = heightProfileImage / 2
    static let profileInfoFont: CGFloat = 20
}

final class EditProfileViewController: UIViewController {
    private lazy var deleteProfileButton = createBarButtonItem(imageName: ImageNames.deleteButton, action: #selector(deleteButtonTapped))
    
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
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .boldSystemFont(ofSize: LocalConstants.profileInfoFont)
        label.text = "Имя"
        return label
    }()
    private let nameTextField: CustomTextField = {
        let textField = CustomTextField()
        textField.font = .boldSystemFont(ofSize: LocalConstants.profileInfoFont)
        return textField
    }()
    private let lastNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .boldSystemFont(ofSize: LocalConstants.profileInfoFont)
        label.text = "Фамилия"
        return label
    }()
    private let lastNameTextField: CustomTextField = {
        let textField = CustomTextField()
        textField.font = .boldSystemFont(ofSize: LocalConstants.profileInfoFont)
        return textField
    }()
    
    
    
    //MARK: Life cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUserInterface()
        setupNavigationBar()
        
    }
    //MARK: Setup NavBar
    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = deleteProfileButton
        navigationItem.backButtonTitle = ""
    }
    //MARK: Setup UserInterface
    private func setupUserInterface() {
        view.backgroundColor = .mainScreen
        [profileImageView, shadowView, nameLabel, nameTextField, lastNameLabel, lastNameTextField].forEach {
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
            
            nameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 80),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            nameLabel.heightAnchor.constraint(equalToConstant: 30),
            nameLabel.widthAnchor.constraint(equalToConstant: 90),
            
            nameTextField.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor),
            nameTextField.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 10),
            nameTextField.heightAnchor.constraint(equalToConstant: 50),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            lastNameLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 25),
            lastNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            lastNameLabel.heightAnchor.constraint(equalToConstant: 30),
            lastNameLabel.widthAnchor.constraint(equalToConstant: 90),
            
            lastNameTextField.centerYAnchor.constraint(equalTo: lastNameLabel.centerYAnchor),
            lastNameTextField.leadingAnchor.constraint(equalTo: lastNameLabel.trailingAnchor, constant: 10),
            lastNameTextField.heightAnchor.constraint(equalToConstant: 50),
            lastNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            
    ])
    }
    //MARK: Private methods
    @objc private func deleteButtonTapped() {
        createAlert()
    }
    
    //MARK: Create Alerts
    private func createAlert() {
        let alert = UIAlertController(title: "Dear user",
                                      message: "Are you sure that to want delete your profile?",
                                      preferredStyle: .actionSheet)
        let actionOK = UIAlertAction(title: "Yes",
                                     style: .default) { (action) in
            FirebaseAPIManager.shared.deleteUser { error in
                DispatchQueue.main.async {
                    guard error == nil else { self.createInfoOfDeleteAlert(error: true); return }
                    self.createInfoOfDeleteAlert(error: false)
                }
            }
        }
        let actionCansel = UIAlertAction(title: "Cansel",
                                         style: .cancel) { (action) in
            
        }
        alert.addAction(actionOK)
        alert.addAction(actionCansel)
        self.present(alert, animated: true) {
            
        }
    }
    private func createInfoOfDeleteAlert(error: Bool) {
        if error {
            let alert = UIAlertController(title: "Внимание",
                                          message: "Произошла ошибка, повторите попытку позже",
                                          preferredStyle: .alert)
            let action = UIAlertAction(title: "Спасибо", style: .cancel) { action in
                
            }
            alert.addAction(action)
            self.present(alert, animated: true) {
                
            }
        } else {
            let alert = UIAlertController(title: "Внимание",
                                          message: "Ваш профиль успешно удален",
                                          preferredStyle: .alert)
            let action = UIAlertAction(title: "Спасибо", style: .default) { (action) in
                (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(vc: LoginViewController())
                UserDefaults.standard.set(false, forKey: "Loged")
            }
            alert.addAction(action)
            self.present(alert, animated: true) {
                
            }
        }
    }
    
}
//MARK: Extentions
extension EditProfileViewController: CreateNavBarItemProtocol {
    //Create custom button for NavBar
}

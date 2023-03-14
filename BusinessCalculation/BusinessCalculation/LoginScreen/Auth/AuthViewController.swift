//
//  AuthViewController.swift
//  BusinessCalculation
//
//  Created by VPDev on 11.03.2023.
//

import UIKit

final class AuthViewController: UIViewController {
    //MARK: UIElements
    private let mainLabel: UILabel = {
        let label = UILabel()
        label.text = "Log in to BusiCal"
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 24)
        return label
    }()
    private let loginNameTextField: CustomTextField = {
        let textField = CustomTextField()
        textField.setupPersonImageLeftView()
        textField.placeholder = "Username or Email"
        return textField
    }()
    private let passworTextField: CustomTextField = {
        let textField = CustomTextField()
        textField.setupEyeImageLeftView()
        textField.placeholder = "Entry your password"
        return textField
    }()
    private let loginButton: CustomButton = {
        let button = CustomButton()
        button.configure(type: .login)
        return button
    }()
    private let googleButton: CustomButton = {
        let button = CustomButton()
        button.configure(type: .google)
        return button
    }()
    private let appleButton: CustomButton = {
        let button = CustomButton()
        button.configure(type: .apple)
        return button
    }()
    //MARK: Life cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupUserInterface()
    }
    
    //MARK: Create SeparatorView
    private func createSeparator() -> UIStackView {
        
        return UIStackView()
    }
    //MARK: Setup UI
    private func setupNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        navigationController?.navigationBar.standardAppearance = appearance
        navigationItem.title = "Business calculation"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    private func setupUserInterface() {
        view.backgroundColor = .mainWhite
        [mainLabel, loginNameTextField, passworTextField, loginButton, googleButton, appleButton].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        NSLayoutConstraint.activate([
            mainLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            mainLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            mainLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            mainLabel.heightAnchor.constraint(equalToConstant: 30),
            
            loginNameTextField.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 20),
            loginNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            loginNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            loginNameTextField.heightAnchor.constraint(equalToConstant: 50),
            
            passworTextField.topAnchor.constraint(equalTo: loginNameTextField.bottomAnchor, constant: 6),
            passworTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            passworTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            passworTextField.heightAnchor.constraint(equalToConstant: 50),
            
            loginButton.topAnchor.constraint(equalTo: passworTextField.bottomAnchor, constant: 10),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            
            googleButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 30),
            googleButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            googleButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            googleButton.heightAnchor.constraint(equalToConstant: 50),
            
            appleButton.topAnchor.constraint(equalTo: googleButton.bottomAnchor, constant: 10),
            appleButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            appleButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            appleButton.heightAnchor.constraint(equalToConstant: 50),
            
        ])
    }
    
}

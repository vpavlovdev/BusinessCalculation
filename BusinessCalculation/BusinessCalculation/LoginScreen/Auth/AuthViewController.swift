//
//  AuthViewController.swift
//  BusinessCalculation
//
//  Created by VPDev on 11.03.2023.
//

import UIKit
import AuthenticationServices
import FirebaseAuth
import FirebaseFirestore
import Firebase
import GoogleSignIn
import GoogleSignInSwift

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
        textField.tag = 0
        textField.placeholder = "Username or Email"
        return textField
    }()
    private let passworTextField: CustomTextField = {
        let textField = CustomTextField()
        textField.setupEyeImageLeftView()
        textField.tag = 1
        textField.placeholder = "Entry your password"
        return textField
    }()
    private let loginButton: CustomButton = {
        let button = CustomButton()
        button.configure(type: .login)
        return button
    }()
    private let googleButton: GoogleButton = {
        let button = GoogleButton()
        return button
    }()
    private let appleButton: ASAuthorizationAppleIDButton = {
        let button = ASAuthorizationAppleIDButton(authorizationButtonType: .continue, authorizationButtonStyle: .black)
        button.cornerRadius = 15
        return button
    }()
    
    //MARK: Life cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupUserInterface()
        addMethods()
    }
    
    //MARK: Create SeparatorView
    private func createSeparator() -> UIView {
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
        let separator = createSeparator()
        
        [mainLabel, loginNameTextField, passworTextField, loginButton, googleButton, appleButton, separator].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        loginNameTextField.delegate = self
        passworTextField.delegate = self
        NSLayoutConstraint.activate([
            mainLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            mainLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            mainLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            mainLabel.heightAnchor.constraint(equalToConstant: 30),
            
            loginNameTextField.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 30),
            loginNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            loginNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            loginNameTextField.heightAnchor.constraint(equalToConstant: 50),
            
            passworTextField.topAnchor.constraint(equalTo: loginNameTextField.bottomAnchor, constant: 10),
            passworTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            passworTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            passworTextField.heightAnchor.constraint(equalToConstant: 50),
            
            loginButton.topAnchor.constraint(equalTo: passworTextField.bottomAnchor, constant: 15),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            
            googleButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 60),
            googleButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            googleButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            googleButton.heightAnchor.constraint(equalToConstant: 50),
            
            appleButton.topAnchor.constraint(equalTo: googleButton.bottomAnchor, constant: 10),
            appleButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            appleButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            appleButton.heightAnchor.constraint(equalToConstant: 50),
            
            separator.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            separator.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            separator.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20),
        ])
    }
    //MARK: Add methods
    private func addMethods() {
        loginButton.addTarget(self, action: #selector(loginTapped(sender:)), for: .touchUpInside)
        googleButton.addTarget(self, action: #selector(googleTapped), for: .touchUpInside)
    }
    @objc private func loginTapped(sender: CustomButton) {
        print(#function)
        FirebaseAPIManager.shared.signInUser(email: loginNameTextField.text!, password: passworTextField.text!)
    }
    @objc private func googleTapped() {
        print(#function)
        FirebaseAPIManager.shared.signInGoogle()
    }
}

//MARK: Extention AuthViewContoller
extension AuthViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.tag == 0 {
            passworTextField.becomeFirstResponder()
        } else if textField.tag == 1 {
            textField.resignFirstResponder()
        }
        return true
    }
}

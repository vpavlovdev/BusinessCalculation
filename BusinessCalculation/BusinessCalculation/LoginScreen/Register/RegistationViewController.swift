//
//  RegistationViewController.swift
//  BusinessCalculation
//
//  Created by VPDev on 16.03.2023.
//

import UIKit
import AuthenticationServices
import FirebaseAuth
import FirebaseFirestore
import Firebase

class RegistationViewController: UIViewController {
    //User
    private var newUser: User?
    //MARK: UIElements
    private let mainLabel: UILabel = {
        let label = UILabel()
        label.text = "Sign up to BusiCal"
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 22)
        return label
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
    private let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.showsHorizontalScrollIndicator = false
        scroll.contentSize = .init(width: 450, height: 500)
        return scroll
    }()
    private let createButton: CustomButton = {
        let button = CustomButton()
        button.configure(type: .createButton)
        return button
    }()
    
    //MARK: TextFields
    private let firstNameTextField: CustomTextField = {
        let textField = CustomTextField()
        textField.placeholder = "First name"
        textField.tag = 0
        return textField
    }()
    private let lastNameTextField: CustomTextField = {
        let textField = CustomTextField()
        textField.placeholder = "Last name"
        textField.tag = 1
        return textField
    }()
    private let emailTextField: CustomTextField = {
        let textField = CustomTextField()
        textField.placeholder = "Email"
        textField.tag = 2
        return textField
    }()
    private let passwordTextField: CustomTextField = {
        let textField = CustomTextField()
        textField.placeholder = "Password(8 or more characters)"
        textField.tag = 3
        return textField
    }()
    //MARK: Checkbox
    private var checkboxEmailCheck = false
    private var checkboxTearmsCheck = false
    private let checkBoxEmailButton: CustomButton = {
        let button = CustomButton()
        button.checkConfigure()
        button.tag = 0
        return button
    }()
    private let checkBoxTearmButton: CustomButton = {
        let button = CustomButton()
        button.checkConfigure()
        button.tag = 1
        return button
    }()
    //MARK: TearmAndPolicyText
    private let emailText: UITextView = {
        let label = UITextView()
        label.text = "I agree to send emails."
        label.textAlignment = .justified
        label.isScrollEnabled = false
        label.isEditable = false
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    private let tearmsText: UITextView = {
        let textView = UITextView()
        textView.text = "I understand and agree to the Tearms of Service, including the Privacy Policy."
        textView.textAlignment = .justified
        textView.font = .systemFont(ofSize: 16)
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
    }()
    //MARK: LifeCicle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupUserInterface()
        setupScrollView()
        addMethods()
    }
    
    private func setupNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        navigationController?.navigationBar.standardAppearance = appearance
        navigationItem.title = "Business calculation"
        navigationController?.navigationBar.prefersLargeTitles = true
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
    //MARK: Setup UIScrollView
    private func setupScrollView() {
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        [firstNameTextField, lastNameTextField, emailTextField, passwordTextField, checkBoxEmailButton, emailText, checkBoxTearmButton, tearmsText, createButton].forEach {
            scrollView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        NSLayoutConstraint.activate([
            firstNameTextField.topAnchor.constraint(equalTo: scrollView.topAnchor),
            firstNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            firstNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            firstNameTextField.heightAnchor.constraint(equalToConstant: 50),
            
            lastNameTextField.topAnchor.constraint(equalTo: firstNameTextField.bottomAnchor, constant: 10),
            lastNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            lastNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            lastNameTextField.heightAnchor.constraint(equalToConstant: 50),
            
            emailTextField.topAnchor.constraint(equalTo: lastNameTextField.bottomAnchor, constant: 10),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            emailTextField.heightAnchor.constraint(equalToConstant: 50),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 10),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            
            checkBoxEmailButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            checkBoxEmailButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            checkBoxEmailButton.widthAnchor.constraint(equalToConstant: 30),
            checkBoxEmailButton.heightAnchor.constraint(equalToConstant: 30),
            
            emailText.topAnchor.constraint(equalTo: checkBoxEmailButton.topAnchor),
            emailText.leadingAnchor.constraint(equalTo: checkBoxEmailButton.trailingAnchor, constant: 10),
            emailText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            emailText.heightAnchor.constraint(equalToConstant: 30),
            
            checkBoxTearmButton.topAnchor.constraint(equalTo: checkBoxEmailButton.bottomAnchor, constant: 10),
            checkBoxTearmButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            checkBoxTearmButton.widthAnchor.constraint(equalToConstant: 30),
            checkBoxTearmButton.heightAnchor.constraint(equalToConstant: 30),
            
            tearmsText.topAnchor.constraint(equalTo: checkBoxTearmButton.topAnchor),
            tearmsText.leadingAnchor.constraint(equalTo: emailText.leadingAnchor),
            tearmsText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            tearmsText.heightAnchor.constraint(equalToConstant: 60),
            
            createButton.topAnchor.constraint(equalTo: tearmsText.bottomAnchor, constant: 40),
            createButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            createButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            createButton.heightAnchor.constraint(equalToConstant: 60),
        ])
    }
    //MARK: Setup UI
    private func setupUserInterface() {
        view.backgroundColor = .mainWhite
        let separator = createSeparator()
        
        [mainLabel, googleButton, appleButton, separator, scrollView].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        NSLayoutConstraint.activate([
            mainLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            mainLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            mainLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            mainLabel.heightAnchor.constraint(equalToConstant: 30),
            
            googleButton.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 50),
            googleButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            googleButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            googleButton.heightAnchor.constraint(equalToConstant: 50),
            
            appleButton.topAnchor.constraint(equalTo: googleButton.bottomAnchor, constant: 10),
            appleButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            appleButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            appleButton.heightAnchor.constraint(equalToConstant: 50),
            
            separator.topAnchor.constraint(equalTo: appleButton.bottomAnchor, constant: 20),
            separator.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            separator.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            scrollView.topAnchor.constraint(equalTo: appleButton.bottomAnchor, constant: 60),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    //MARK: Add Methods
    private func addMethods() {
        checkBoxEmailButton.addTarget(self, action: #selector(checkButtonTapped(sender:)), for: .touchUpInside)
        checkBoxTearmButton.addTarget(self, action: #selector(checkButtonTapped(sender:)), for: .touchUpInside)
        createButton.addTarget(self, action: #selector(registration(sender:)), for: .touchUpInside)
        googleButton.addTarget(self, action: #selector(signInWithGoogle), for: .touchUpInside)
    }
    @objc private func checkButtonTapped(sender: UIButton) {
        guard let image = UIImage(named: "check") else { return }
        if sender.tag == 0 {
        if checkboxEmailCheck == false {
            checkBoxEmailButton.setImage(image, for: .normal)
            checkboxEmailCheck = true
        } else {
            checkBoxEmailButton.setImage(UIImage(), for: .normal)
            checkboxEmailCheck = false
        }
        } else if sender.tag == 1 {
            if checkboxTearmsCheck == false {
                checkBoxTearmButton.setImage(image, for: .normal)
                checkboxTearmsCheck = true
            } else {
                checkBoxTearmButton.setImage(UIImage(), for: .normal)
                checkboxTearmsCheck = false
            }
        }
}
    @objc private func registration(sender: CustomButton) {
        print(#function)
        let user = User(firstName: firstNameTextField.text!, lastName: lastNameTextField.text!, email: emailTextField.text!, password: passwordTextField.text!)
        print(user)
        FirebaseAPIManager.shared.registrationNewUser(newUser: user)
    }
    @objc private func signInWithGoogle() {
        FirebaseAPIManager.shared.signInGoogle()
    }
}

extension RegistationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField.tag {
        case 0: lastNameTextField.becomeFirstResponder()
        case 1: emailTextField.becomeFirstResponder()
        case 2: passwordTextField.becomeFirstResponder()
        case 3: textField.resignFirstResponder()
        default: break
            
        }
        return true
    }
}

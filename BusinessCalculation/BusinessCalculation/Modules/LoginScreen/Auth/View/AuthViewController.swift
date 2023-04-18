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
import Lottie

fileprivate enum LocalConstants {
    static let lotieAnimation = "Loading"
    static let navigationItemTitle = "Business calculation"
    static let mainLabelText = "Log in to BusiCal"
    static let mainLabelFont: CGFloat = 24
    static let statusLabelFont: CGFloat = 16
    static let loginTextFieldPlacaholder = "Username or Email"
    static let passwordTextFieldPlaceholder = "Entry your password"
    static let appleButtonCornerRadius: CGFloat = 15
    static let separatorText = "or"
    static let separatotTextFont: CGFloat = 15
    static let buttonHeight: CGFloat = 50
    static let buttonLeadingAnchor: CGFloat = 30
    static let buttonTrailingAnchor: CGFloat = -30
    static let textFieldHeight: CGFloat = 50
    static let textFieldLeadingAnchor: CGFloat = 30
    static let textFieldTrailingAnchor: CGFloat = -30
}
final class AuthViewController: UIViewController {
    private var authViewModel: AuthViewModelProtocol = AuthViewModel()
    
    //MARK: UIElements
    private var animationLoading: LottieAnimationView = {
        let lotie = LottieAnimationView(name: LocalConstants.lotieAnimation)
        lotie.loopMode = .loop
        lotie.contentMode = .scaleAspectFit
        lotie.isHidden = true
        lotie.animationSpeed = 2
        return lotie
    }()
    private let mainLabel: UILabel = {
        let label = UILabel()
        label.text = LocalConstants.mainLabelText
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: LocalConstants.mainLabelFont)
        return label
    }()
    private lazy var loginNameTextField: CustomTextField = {
        let textField = CustomTextField()
        textField.setupPersonImageLeftView()
        textField.tag = 0
        textField.placeholder = LocalConstants.loginTextFieldPlacaholder
        textField.delegate = self
        return textField
    }()
    private lazy var passworTextField: CustomTextField = {
        let textField = CustomTextField()
        textField.setupSecureButton()
        textField.tag = 1
        textField.placeholder = LocalConstants.passwordTextFieldPlaceholder
        textField.delegate = self
        return textField
    }()
    private var statusTextLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: LocalConstants.statusLabelFont)
        label.textColor = .statusLabelColor
        return label
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
        button.cornerRadius = LocalConstants.appleButtonCornerRadius
        return button
    }()
    
    //MARK: Life cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupUserInterface()
        addMethods()
        bindAuthViewModel()
    }
    
    //MARK: Create SeparatorView
    private func createSeparator() -> UIView {
        let separatorView = UIView()
        let viewOne = UIView()
        viewOne.backgroundColor = .separatorColor
        let viewTwo = UIView()
        viewTwo.backgroundColor = .separatorColor
        let label = UILabel()
        label.font = .systemFont(ofSize: LocalConstants.separatotTextFont)
        label.text = LocalConstants.separatorText
        
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
        navigationItem.title = LocalConstants.navigationItemTitle
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    private func setupUserInterface() {
        view.backgroundColor = .mainWhite
        let separator = createSeparator()
        
        [mainLabel, loginNameTextField, passworTextField, statusTextLabel, loginButton, googleButton, appleButton, separator, animationLoading].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        NSLayoutConstraint.activate([
            mainLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            mainLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            mainLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            mainLabel.heightAnchor.constraint(equalToConstant: 30),
            
            loginNameTextField.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 30),
            loginNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LocalConstants.textFieldLeadingAnchor),
            loginNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: LocalConstants.textFieldTrailingAnchor),
            loginNameTextField.heightAnchor.constraint(equalToConstant: LocalConstants.textFieldHeight),
            
            passworTextField.topAnchor.constraint(equalTo: loginNameTextField.bottomAnchor, constant: 10),
            passworTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LocalConstants.textFieldLeadingAnchor),
            passworTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: LocalConstants.textFieldTrailingAnchor),
            passworTextField.heightAnchor.constraint(equalToConstant: LocalConstants.textFieldHeight),
            
            statusTextLabel.topAnchor.constraint(equalTo: passworTextField.bottomAnchor, constant: 7),
            statusTextLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            statusTextLabel.heightAnchor.constraint(equalToConstant: 20),
            statusTextLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LocalConstants.textFieldLeadingAnchor),
            statusTextLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: LocalConstants.textFieldTrailingAnchor),
            
            loginButton.topAnchor.constraint(equalTo: statusTextLabel.bottomAnchor, constant: 7),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LocalConstants.buttonLeadingAnchor),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: LocalConstants.buttonTrailingAnchor),
            loginButton.heightAnchor.constraint(equalToConstant: LocalConstants.buttonHeight),
            
            googleButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 60),
            googleButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LocalConstants.buttonLeadingAnchor),
            googleButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: LocalConstants.buttonTrailingAnchor),
            googleButton.heightAnchor.constraint(equalToConstant: LocalConstants.buttonHeight),
            
            appleButton.topAnchor.constraint(equalTo: googleButton.bottomAnchor, constant: 10),
            appleButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LocalConstants.buttonLeadingAnchor),
            appleButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: LocalConstants.buttonTrailingAnchor),
            appleButton.heightAnchor.constraint(equalToConstant: LocalConstants.buttonHeight),
            
            separator.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            separator.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            separator.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20),
            
            animationLoading.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            animationLoading.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            animationLoading.heightAnchor.constraint(equalToConstant: 150),
            animationLoading.widthAnchor.constraint(equalToConstant: 150),
        ])
    }
    //MARK: Add methods
    private func addMethods() {
        loginButton.addTarget(self, action: #selector(loginTapped(sender:)), for: .touchUpInside)
        googleButton.addTarget(self, action: #selector(googleTapped), for: .touchUpInside)
    }
    @objc private func loginTapped(sender: CustomButton) {
        guard let email = loginNameTextField.text,
              let password = passworTextField.text else { return }
        startAnimation()
        
        authViewModel.signIn(email: email, password: password) {
            DispatchQueue.main.async {
                self.stopAnimation()
            }
        }
    }
    private func startAnimation() {
        animationLoading.isHidden = false
        animationLoading.play()
    }
    private func stopAnimation() {
        animationLoading.stop()
        animationLoading.isHidden = true
    }
    @objc private func googleTapped() {
        authViewModel.signInWithGoogle()
    }
    //MARK: Bind ViewModel
    private func bindAuthViewModel() {
         authViewModel.statusText.bind { statusText in
            DispatchQueue.main.async {
                self.statusTextLabel.text = statusText
            }
        }
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

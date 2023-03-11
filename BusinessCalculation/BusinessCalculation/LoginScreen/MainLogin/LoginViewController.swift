//
//  ViewController.swift
//  BusinessCalculation
//
//  Created by VPDev on 10.03.2023.
//

import UIKit

final class LoginViewController: UIViewController {
    private let content: [Content] = Source.makeContent()
    private let scrollView : UIScrollView = {
        let scroll = UIScrollView()
        scroll.contentSize = .init(width: Int(UIScreen.main.bounds.width), height: 400)
        scroll.backgroundColor = .gray
        scroll.isPagingEnabled = true
        return scroll
    }()
    
    private let pageControl: UIPageControl = {
        let page = UIPageControl()
        page.preferredIndicatorImage = UIImage(systemName: "banknote")
        page.pageIndicatorTintColor = .blue
        page.currentPageIndicatorTintColor = .red
        page.backgroundStyle = .prominent
        return page
    }()
    private let loginButton: CustomButton = {
        let button = CustomButton()
        button.configure(type: .login)
        return button
    }()
    private let signupButton: CustomButton = {
        let button = CustomButton()
        button.configure(type: .registration)
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUserInterface()
        setupNavigationBar()
        addMethods()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    private func setupNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        navigationController?.navigationBar.standardAppearance = appearance
        navigationItem.title = "Business calculation"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupUserInterface() {
        view.backgroundColor = .mainWhite
        [scrollView, pageControl, loginButton, signupButton].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        pageControl.numberOfPages = content.count
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.heightAnchor.constraint(equalToConstant: 400),
            
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageControl.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 10),
            
            loginButton.topAnchor.constraint(equalTo: pageControl.bottomAnchor, constant: 40),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            
            signupButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20),
            signupButton.leadingAnchor.constraint(equalTo: loginButton.leadingAnchor),
            signupButton.trailingAnchor.constraint(equalTo: loginButton.trailingAnchor),
            signupButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    //MARK: Methods
    private func addMethods() {
        loginButton.addTarget(self, action: #selector(loginButtonTapped(sender:)), for: .touchUpInside)
        signupButton.addTarget(self, action: #selector(signUpButtonTapped(sender:)), for: .touchUpInside)
    }
    @objc private func loginButtonTapped(sender: CustomButton) {
        let vc = AuthViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc private func signUpButtonTapped(sender: CustomButton) {
        let vc = RegisterViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension LoginViewController {
    private func addContent(_ content: Content) {
        let imageView = UIImageView()
        imageView.image = UIImage()
        
        let label = UILabel()
        label.text = "Welcome to BusiCal \n(Business calculation)"
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 20)
        label.textAlignment = .center
    }
}


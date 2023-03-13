//
//  ViewController.swift
//  BusinessCalculation
//
//  Created by VPDev on 10.03.2023.
//

import UIKit

final class LoginViewController: UIViewController {
    private let content: [Content] = Source.makeContent()
    private var onboardCollectionView: UICollectionView!
    
    private let pageControl: UIPageControl = {
        let page = UIPageControl()
        page.pageIndicatorTintColor = .tintPageControl
        page.currentPageIndicatorTintColor = .currentPageControl
        page.backgroundStyle = .automatic
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
        setupCollectionView()
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
    private func setupCollectionView() {
        onboardCollectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout())
        view.addSubview(onboardCollectionView)
        onboardCollectionView.translatesAutoresizingMaskIntoConstraints = false
        //MARK: UICollectionView Constraint
        NSLayoutConstraint.activate([
            onboardCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            onboardCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            onboardCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            onboardCollectionView.heightAnchor.constraint(equalToConstant: 420),
        ])
        onboardCollectionView.register(LoginCollectionViewCell.self, forCellWithReuseIdentifier: "LoginCell")
        onboardCollectionView.dataSource = self
        onboardCollectionView.delegate = self
        onboardCollectionView.backgroundColor = .clear
        onboardCollectionView.showsHorizontalScrollIndicator = false
    }
    private func flowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = .init(width: view.bounds.width, height: 420)
        layout.scrollDirection = .horizontal
        return layout
    }
    private func setupUserInterface() {
        view.backgroundColor = .mainWhite
        [pageControl, loginButton, signupButton].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        pageControl.numberOfPages = content.count
        //MARK: UIconstraint
        NSLayoutConstraint.activate([
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 480),
            
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

extension LoginViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        content.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LoginCell", for: indexPath) as? LoginCollectionViewCell else { fatalError("Cell error") }
        cell.configureCell(content: content[indexPath.item])
        return cell
    }
   
}


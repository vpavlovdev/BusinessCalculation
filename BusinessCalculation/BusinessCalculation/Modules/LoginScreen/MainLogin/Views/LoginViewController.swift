//
//  ViewController.swift
//  BusinessCalculation
//
//  Created by VPDev on 10.03.2023.
//

import UIKit

fileprivate enum LocalConstant {
    static let navigationTitle = "Business calculation"
    static let backButtonTittle = ""
    static let identifierCell = "LoginCell"
    static let heightCollection: CGFloat = 420
    static let minimumLineSpacing: CGFloat = 0
    static let heightButtons: CGFloat = 50
    static let buttonsLeadingAnchor: CGFloat = 30
    static let buttonsTrailingAnchor: CGFloat = -30
}

final class LoginViewController: UIViewController {
    private var loginViewModel: LoginViewModelProtocol = LoginViewModel()
    
    //MARK: UIElements
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
    
    //MARK: Lifecicle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUserInterface()
        setupNavigationBar()
        setupCollectionView()
        addMethods()
    }
    
    //MARK: Setup UI
    private func setupNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        navigationController?.navigationBar.standardAppearance = appearance
        navigationItem.backButtonTitle = LocalConstant.backButtonTittle
        navigationController?.navigationBar.tintColor = .tintColorNavContoller
        
        navigationItem.title = LocalConstant.navigationTitle
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
            onboardCollectionView.heightAnchor.constraint(equalToConstant: LocalConstant.heightCollection),
        ])
        onboardCollectionView.register(LoginCollectionViewCell.self, forCellWithReuseIdentifier: LocalConstant.identifierCell)
        onboardCollectionView.dataSource = self
        onboardCollectionView.delegate = self
        onboardCollectionView.backgroundColor = .clear
        onboardCollectionView.showsHorizontalScrollIndicator = false
        onboardCollectionView.isPagingEnabled = true
    }
    private func flowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = .init(width: view.frame.width, height: LocalConstant.heightCollection)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = LocalConstant.minimumLineSpacing
        return layout
    }
    private func setupUserInterface() {
        view.backgroundColor = .mainWhite
        [pageControl, loginButton, signupButton].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        pageControl.numberOfPages = loginViewModel.numberOfItemsInSEction()
        //MARK: UIconstraint
        NSLayoutConstraint.activate([
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 480),
            
            loginButton.topAnchor.constraint(equalTo: pageControl.bottomAnchor, constant: 40),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LocalConstant.buttonsLeadingAnchor),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: LocalConstant.buttonsTrailingAnchor),
            loginButton.heightAnchor.constraint(equalToConstant: LocalConstant.heightButtons),
            
            signupButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20),
            signupButton.leadingAnchor.constraint(equalTo:view.leadingAnchor, constant: LocalConstant.buttonsLeadingAnchor),
            signupButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: LocalConstant.buttonsTrailingAnchor),
            signupButton.heightAnchor.constraint(equalToConstant: LocalConstant.heightButtons),
        ])
    }
    //MARK: Methods
    private func addMethods() {
        loginButton.addTarget(self, action: #selector(loginButtonTapped(sender:)), for: .touchUpInside)
        signupButton.addTarget(self, action: #selector(signUpButtonTapped(sender:)), for: .touchUpInside)
        pageControl.addTarget(self, action: #selector(pageDidChange(sender:)), for: .valueChanged)
    }
    @objc private func loginButtonTapped(sender: CustomButton) {
        let vc = AuthViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc private func signUpButtonTapped(sender: CustomButton) {
        let vc = RegistationViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc private func pageDidChange(sender: UIPageControl) {
        let indexPath = IndexPath(item: pageControl.currentPage, section: 0)
        onboardCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
}

extension LoginViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        loginViewModel.numberOfItemsInSEction()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LocalConstant.identifierCell, for: indexPath) as? LoginCollectionViewCell,
              let itemViewModel = loginViewModel.itemViewModel(forIndexPath: indexPath)
        else { fatalError("Cell error") }
        cell.configureCell(content: itemViewModel)
        return cell
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        pageControl.currentPage = Int(scrollView.contentOffset.x / width)
    }
}


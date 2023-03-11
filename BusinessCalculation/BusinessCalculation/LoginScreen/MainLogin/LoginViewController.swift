//
//  ViewController.swift
//  BusinessCalculation
//
//  Created by VPDev on 10.03.2023.
//

import UIKit

final class LoginViewController: UIViewController {
    private let content: [Content] = []
    private let scrollView : UIScrollView = {
        let scroll = UIScrollView()
        scroll.contentSize = .init(width: Int(UIScreen.main.bounds.width), height: 400)
        scroll.backgroundColor = .gray
        scroll.isPagingEnabled = true
        return scroll
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUserInterface()
        setupNavigationBar()
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
        [scrollView].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.heightAnchor.constraint(equalToConstant: 400),
            
            
            
            
        ])
        
        
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


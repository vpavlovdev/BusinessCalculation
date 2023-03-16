//
//  RegisterViewController.swift
//  BusinessCalculation
//
//  Created by VPDev on 11.03.2023.
//

import UIKit
import AuthenticationServices

class RegisterViewController: UIViewController {
    private let info: [TypeCell] = RegisterSource.textField()
    private let registerTableView = UITableView(frame: .zero, style: .plain)
    private let mainLabel: UILabel = {
        let label = UILabel()
        label.text = "Sign up to BusiCal"
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 22)
        return label
    }()
    private let googleButton: CustomButton = {
        let button = CustomButton()
        button.configure(type: .google)
        return button
    }()
    private let appleButton: ASAuthorizationAppleIDButton = {
        let button = ASAuthorizationAppleIDButton(authorizationButtonType: .continue, authorizationButtonStyle: .black)
        button.cornerRadius = 15
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupUserInterface()
        setupTableView()
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
    //MARK: Setup UI
    private func setupUserInterface() {
        view.backgroundColor = .mainWhite
        let separator = createSeparator()
        
        [mainLabel, googleButton, appleButton, separator].forEach {
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
            
            separator.topAnchor.constraint(equalTo: appleButton.bottomAnchor, constant: 15),
            separator.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            separator.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    //MARK: Setup UITable View
    private func setupTableView() {
        view.addSubview(registerTableView)
        registerTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            registerTableView.topAnchor.constraint(equalTo: appleButton.bottomAnchor, constant: 50),
            registerTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            registerTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            registerTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        registerTableView.register(RegisterTableViewCell.self, forCellReuseIdentifier: "register Cell")
        registerTableView.separatorStyle = .none
        registerTableView.dataSource = self
        registerTableView.delegate = self
        registerTableView.bounces = false

    }
}

    //MARK: Extention UITableView
extension RegisterViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        info.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "register Cell", for: indexPath) as? RegisterTableViewCell else { fatalError() }
        cell.config(parametrs: info[indexPath.row])
        return cell
    }


}

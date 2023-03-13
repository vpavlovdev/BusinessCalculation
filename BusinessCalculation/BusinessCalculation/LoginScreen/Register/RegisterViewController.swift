//
//  RegisterViewController.swift
//  BusinessCalculation
//
//  Created by VPDev on 11.03.2023.
//

import UIKit

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
    private let appleButton: CustomButton = {
        let button = CustomButton()
        button.configure(type: .apple)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupUserInterface()
        setupTabbleView()
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
        [mainLabel, googleButton, appleButton].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        NSLayoutConstraint.activate([
            mainLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            mainLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            mainLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            mainLabel.heightAnchor.constraint(equalToConstant: 30),
            
            googleButton.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 50),
            googleButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            googleButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            googleButton.heightAnchor.constraint(equalToConstant: 50),
            
            appleButton.topAnchor.constraint(equalTo: googleButton.bottomAnchor, constant: 10),
            appleButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            appleButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            appleButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    private func setupTabbleView() {
        view.addSubview(registerTableView)
        registerTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            registerTableView.topAnchor.constraint(equalTo: appleButton.bottomAnchor, constant: 30),
            registerTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            registerTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            registerTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        registerTableView.register(RegisterTableViewCell.self, forCellReuseIdentifier: "register Cell")
        registerTableView.separatorStyle = .none
        registerTableView.dataSource = self
        registerTableView.delegate = self
    }
}

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

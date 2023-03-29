//
//  EditProfileViewController.swift
//  BusinessCalculation
//
//  Created by VPDev on 28.03.2023.
//

import UIKit

final class EditProfileViewController: UIViewController {
    private lazy var deleteProfileButton = createBarButtonItem(imageName: ImageNames.deleteButton, action: #selector(deleteButtonTapped))
    //MARK: Life cicle
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUserInterface()
        setupNavigationBar()
        
    }
    //MARK: Setup NavBar
    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = deleteProfileButton
        navigationItem.backButtonTitle = ""
    }
    //MARK: Setup UserInterface
    private func setupUserInterface() {
        view.backgroundColor = .mainScreen
    }
    //MARK: Private methods
    @objc private func deleteButtonTapped() {
        print(#function)
    }
}
extension EditProfileViewController: CreateNavBarItemProtocol {
    //Create custom button for NavBar
}

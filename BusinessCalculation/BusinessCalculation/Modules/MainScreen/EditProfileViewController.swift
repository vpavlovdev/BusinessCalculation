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
        createAlert()
    }
    
    //MARK: Create Alerts
    private func createAlert() {
        let alert = UIAlertController(title: "Dear user",
                                      message: "Are you sure that to want delete your profile?",
                                      preferredStyle: .actionSheet)
        let actionOK = UIAlertAction(title: "Yes",
                                     style: .default) { (action) in
            FirebaseAPIManager.shared.deleteUser { error in
                DispatchQueue.main.async {
                    guard error == nil else { self.createInfoOfDeleteAlert(error: true); return }
                    self.createInfoOfDeleteAlert(error: false)
                }
            }
        }
        let actionCansel = UIAlertAction(title: "Cansel",
                                         style: .cancel) { (action) in
            
        }
        alert.addAction(actionOK)
        alert.addAction(actionCansel)
        self.present(alert, animated: true) {
            
        }
    }
    private func createInfoOfDeleteAlert(error: Bool) {
        if error {
            let alert = UIAlertController(title: "Внимание",
                                           message: "Произошла ошибка, повторите попытку позже",
                                           preferredStyle: .alert)
            let action = UIAlertAction(title: "Спасибо", style: .cancel) { action in
                
            }
            alert.addAction(action)
            self.present(alert, animated: true) {
                
            }
        } else {
            let alert = UIAlertController(title: "Внимание",
                                          message: "Ваш профиль успешно удален",
                                          preferredStyle: .alert)
            let action = UIAlertAction(title: "Спасибо", style: .default) { (action) in
                (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(vc: LoginViewController())
                UserDefaults.standard.set(false, forKey: "Loged")
            }
            alert.addAction(action)
            self.present(alert, animated: true) {
                
            }
        }
    }
    
}
//MARK: Extentions
extension EditProfileViewController: CreateNavBarItemProtocol {
    //Create custom button for NavBar
}

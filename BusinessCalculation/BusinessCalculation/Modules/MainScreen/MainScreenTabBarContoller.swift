//
//  MainScreenTabBarContoller.swift
//  BusinessCalculation
//
//  Created by VPDev on 24.03.2023.
//

import UIKit

class MainScreenTabBarContoller: UITabBarController {
  
    //MARK: LifeCicle
    override func viewDidLoad() {
        super.viewDidLoad()
        generateTabBarController()
        setupTabBarAppearance()
        setupNavBarAppearance()
    }
    //MARK: Create NavController
    private let profileNavController = UINavigationController(rootViewController: ProfileViewController())
    //MARK: Generate TabBar
    private func generateTabBarController() {
        viewControllers = [
            generateViewControllers(viewController: HomeViewController(),
                                    title: "Главная",
                                    image: UIImage(systemName: "house.fill")),
        generateViewControllers(viewController: BusinessPlansViewController(),
                                title: "Бизнес планы",
                                image: UIImage(systemName: "folder.fill")),
        generateViewControllers(viewController: profileNavController,
                                title: "Профиль",
                                image: UIImage(systemName: "person.fill"))
        ]
    }
    private func generateViewControllers(viewController: UIViewController, title: String, image: UIImage?) -> UIViewController {
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = image
        return viewController
    }
    //MARK: Setup NavBar
    private func setupNavBarAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        profileNavController.navigationBar.standardAppearance = appearance
        profileNavController.navigationItem.backButtonTitle = ""
        profileNavController.navigationBar.tintColor = .tintColorNavContoller
    }
    //MARK: Setup TabBar
    private func setupTabBarAppearance() {
        let positionOnX: CGFloat = 10
        let positionOnY: CGFloat = 14
        let width = tabBar.bounds.width - positionOnX * 2
        let height = tabBar.bounds.height + positionOnY * 2
        let roundLayer = CAShapeLayer()
        let bezierPath = UIBezierPath(
            roundedRect: CGRect(x: positionOnX, y: tabBar.bounds.minY - positionOnY, width: width, height: height),
            cornerRadius: height / 2)
        roundLayer.path = bezierPath.cgPath
        tabBar.layer.insertSublayer(roundLayer, at: 0)
        tabBar.itemPositioning = .centered
        tabBar.itemWidth = width / 3
        
        //MARK: TabBar Colors
        roundLayer.fillColor = UIColor.tabBarColor.cgColor
        tabBar.unselectedItemTintColor = .unselectedTabBarItem
        tabBar.tintColor = .selectedTabBarItem
        
        
        //MARK: Clear background
        tabBar.backgroundColor = .clear
        tabBar.backgroundImage = UIImage()
        tabBar.shadowImage = UIImage()
        
    }

}

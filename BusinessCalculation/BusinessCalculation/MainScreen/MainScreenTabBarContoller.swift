//
//  MainScreenTabBarContoller.swift
//  BusinessCalculation
//
//  Created by VPDev on 24.03.2023.
//

import UIKit

class MainScreenTabBarContoller: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    private func generateTabBarController() {
        viewControllers = [
        
        
        ]
    }
    private func generateViewControllers(viewContoller: UIViewController, title: String, image: UIImage?) -> UIViewController {
        viewContoller.tabBarItem.title = title
        viewContoller.tabBarItem.image = image
        return viewContoller
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
        
        //MARK: TabBar Colors
        roundLayer.fillColor = UIColor.tabBarColor.cgColor
        tabBar.tintColor = .selectedTabBarItem
        tabBar.unselectedItemTintColor = .unselectedTabBarItem
        
        //MARK: Clear background
        let appearance = UITabBarAppearance()
        appearance.configureWithTransparentBackground()
        tabBar.standardAppearance = appearance
    }

}

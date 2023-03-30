//
//  CreateNavBarItemProtocol.swift
//  BusinessCalculation
//
//  Created by VPDev on 29.03.2023.
//

import Foundation
import UIKit

protocol CreateNavBarItemProtocol {
    func createBarButtonItem(imageName: String, action: Selector) -> UIBarButtonItem
}
extension CreateNavBarItemProtocol {
    func createBarButtonItem(imageName: String, action: Selector) -> UIBarButtonItem {
        let button = UIButton(type: .system)
        button.setImage(
            UIImage(systemName: imageName)?.withRenderingMode(.alwaysTemplate),
            for: .normal)
        button.tintColor = .tintColorNavContoller
        button.imageView?.contentMode = .scaleAspectFit
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.addTarget(self, action: action, for: .touchUpInside)
        let barButtonItem = UIBarButtonItem(customView: button)
        return barButtonItem
    }
}

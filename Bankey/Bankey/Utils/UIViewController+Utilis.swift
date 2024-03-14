//
//  UIViewController+Ext.swift
//  Bankey
//
//  Created by Baran Baran on 10.03.2024.
//


import UIKit

extension UIViewController {
    
    func setStatusBar() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithTransparentBackground()
        
        navBarAppearance.backgroundColor = appColor
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
    }
    
    
    
    
    func setTabBarImage(imageName: String, title: String) {
        let configuration = UIImage.SymbolConfiguration(scale: .large)
        let image = UIImage(systemName: imageName, withConfiguration: configuration)
        tabBarItem = UITabBarItem(title: title, image: image, tag: 0)
    }
}



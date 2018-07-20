//
//  YHTabBarController.swift
//  Yahoo Fantasy Sports
//
//  Created by Justin Wells on 7/17/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

class YHTabBarController: UITabBarController, UITabBarControllerDelegate{
    
    override func viewDidLoad() {
        self.delegate = self
        self.tabBar.tintColor = YHColor.orange
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController == tabBarController.viewControllers?[0]{
            let menuVC = LeagueMenuController()
            menuVC.modalPresentationStyle = .overFullScreen
            self.present(menuVC, animated: false, completion: nil)
            return false
        }
        else{
           return true
        }
    }
}

//
//  HomeNavigationController.swift
//  Yahoo Fantasy Sports
//
//  Created by Justin Wells on 7/16/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

class HomeNavigationController: UINavigationController{
    
    override func viewDidLoad() {
        self.navigationBar.isTranslucent = false
        self.navigationBar.barTintColor = .black
        self.navigationBar.tintColor = .white
        self.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 20), NSForegroundColorAttributeName: UIColor.white]
        self.navigationBar.backgroundColor = .black
    }
}

//
//  MessagingNavigationController.swift
//  Yahoo Fantasy Sports
//
//  Created by Justin Wells on 7/16/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

class MessagingNavigationController: UINavigationController{
    
    override func viewDidLoad() {
        self.navigationBar.isTranslucent = false
        self.navigationBar.barTintColor = YHColor.darkPurple
        self.navigationBar.tintColor = .white
        self.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 18), NSForegroundColorAttributeName: UIColor.white]
        self.navigationBar.backgroundColor = YHColor.darkPurple
    }
}

//
//  YHGradientNavigationController.swift
//  Yahoo Fantasy Sports
//
//  Created by Justin Wells on 7/17/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

class YHGradientNavigationController: UINavigationController{
    
    private var colors = [CGColor]()
    
    convenience init(rootViewController: UIViewController, colors: [CGColor]) {
        self.init(rootViewController: rootViewController)
        self.colors = colors
        
        //Set Gradient Background
        self.setupGradientBackground()
    }
    
    override func viewDidLoad() {
        self.navigationBar.isTranslucent = false
        self.navigationBar.barTintColor = .clear
        self.navigationBar.tintColor = .white
        self.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 18), NSForegroundColorAttributeName: UIColor.white]
    }
    
    func setupGradientBackground(){
        let gradient = CAGradientLayer()
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradient.colors = self.colors
        gradient.frame = CGRect(x: 0, y: 0, width: self.navigationBar.frame.width, height: 64)
        self.navigationBar.setBackgroundImage(self.backgroundImage(layer: gradient), for: .default)
    }
    
    func backgroundImage(layer: CALayer) -> UIImage{
        UIGraphicsBeginImageContext(layer.frame.size)
        layer.render(in: UIGraphicsGetCurrentContext()!)
        let outputImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return outputImage!
    }
}


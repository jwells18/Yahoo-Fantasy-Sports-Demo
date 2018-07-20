//
//  YHSettingsItem.swift
//  Yahoo Fantasy Sports
//
//  Created by Justin Wells on 7/19/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

class YHSettingsItem: NSObject{
    
    var image: UIImage!
    var title: String!
    
    init(image: UIImage, title: String){
        self.image = image
        self.title = title
    }
}

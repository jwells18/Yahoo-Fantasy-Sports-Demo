//
//  HomeNavigationButton.swift
//  Yahoo Fantasy Sports
//
//  Created by Justin Wells on 7/16/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

class HomeNavigationButton: UIButton{
    /*
    var image: UIImage?
    var title: String?
    var image
    
    convenience init(image: UIImage?, title: String?) {
        self.init()
        self.setupView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: 0, width: 100, height: 70))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
        self.view
    }*/
    
    public override init(frame: CGRect){
        super.init(frame: frame)
        //Setup View
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
        //Setup Button
        self.backgroundColor = .white
        self.clipsToBounds = true
        self.contentEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5)
        self.contentHorizontalAlignment = .center
        self.contentVerticalAlignment = .top
        
        //Set ImageView
        self.imageEdgeInsets = UIEdgeInsetsMake(0, 7, 14, 7)
        
        //Setup Title Label
        self.setTitleColor(UIColor.darkGray, for: .normal)
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        self.titleEdgeInsets = UIEdgeInsetsMake(26, -26, 0, 0)
    }
}

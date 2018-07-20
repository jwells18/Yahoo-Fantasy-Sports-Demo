//
//  DailyLobbyFantasyContestTableFooter.swift
//  Yahoo Fantasy Sports
//
//  Created by Justin Wells on 7/18/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

class DailyLobbyFantasyContestTableFooter: UIButton{
    
    var textLabel = UILabel()
    var accessoryImageView = UIImageView()
    var separatorView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //Setup View
        self.setupView()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    func setupView(){
        self.backgroundColor = .white
        self.clipsToBounds = false
        
        //Setup Text Label
        self.setupTextLabel()
        
        //Setup Accessory ImageView
        self.setupAccessoryImageView()
        
        //Setup Separator View
        self.setupSeparatorView()
        
        //Setup Constraints
        self.setupConstraints()
    }
    
    func setupTextLabel(){
        self.textLabel.text = "viewAll".localized()
        self.textLabel.textColor = YHColor.blue
        self.textLabel.font = UIFont.boldSystemFont(ofSize: 16)
        self.textLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.textLabel)
    }
    
    func setupAccessoryImageView(){
        self.accessoryImageView.image = UIImage(named: "forward")?.withRenderingMode(.alwaysTemplate)
        self.accessoryImageView.tintColor = YHColor.blue
        self.accessoryImageView.clipsToBounds = true
        self.accessoryImageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.accessoryImageView)
    }
    
    func setupSeparatorView(){
        self.separatorView.backgroundColor = .lightGray
        self.separatorView.isUserInteractionEnabled = false
        self.separatorView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.separatorView)
    }
    
    func setupConstraints(){
        let spacerView = UIView()
        spacerView.isUserInteractionEnabled = false
        spacerView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(spacerView)
        
        let viewDict = ["textLabel": textLabel, "accessoryImageView": accessoryImageView, "separatorView": separatorView, "spacerView": spacerView] as [String : Any]
        //Width & Horizontal Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[textLabel][spacerView(>=8)][accessoryImageView(20)]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[separatorView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        //Height & Vertical Alignment
        self.addConstraints([NSLayoutConstraint.init(item: self.textLabel, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)])
        self.addConstraints([NSLayoutConstraint.init(item: self.accessoryImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)])
        self.addConstraints([NSLayoutConstraint.init(item: self.accessoryImageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 20)])
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[separatorView(0.5)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
    }
}

//
//  DailyFantastyLobbyCreateContestCell.swift
//  Yahoo Fantasy Sports
//
//  Created by Justin Wells on 7/17/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

class DailyFantasyLobbyCreateContestCell: UICollectionViewCell{
    
    var titleLabel = UILabel()
    var accessoryImageView = UIImageView()
    
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
        
        //Setup Title Label
        self.setupTitleLabel()
        
        //Setup Accessory ImageView
        self.setupAccessoryImageView()
        
        //Setup Constraints
        self.setupConstraints()
    }
    
    func setupTitleLabel(){
        self.titleLabel.text = "createContests".localized()
        self.titleLabel.textColor = YHColor.blue
        self.titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.titleLabel)
    }
    
    func setupAccessoryImageView(){
        self.accessoryImageView.image = UIImage(named: "forward")?.withRenderingMode(.alwaysTemplate)
        self.accessoryImageView.tintColor = YHColor.blue
        self.accessoryImageView.clipsToBounds = true
        self.accessoryImageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.accessoryImageView)
    }
    
    func setupConstraints(){
        let viewDict = ["titleLabel": titleLabel, "accessoryImageView": accessoryImageView] as [String : Any]
        //Width & Horizontal Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[titleLabel]-[accessoryImageView(20)]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        //Height & Vertical Alignment
        self.addConstraints([NSLayoutConstraint.init(item: titleLabel, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)])
        self.addConstraints([NSLayoutConstraint.init(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 20)])
        self.addConstraints([NSLayoutConstraint.init(item: accessoryImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)])
        self.addConstraints([NSLayoutConstraint.init(item: accessoryImageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 20)])
    }
}

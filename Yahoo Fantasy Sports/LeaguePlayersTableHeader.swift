//
//  LeaguePlayersTableHeader.swift
//  Yahoo Fantasy Sports
//
//  Created by Justin Wells on 7/19/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

class LeaguePlayersTableHeader: UIView{
    
    var titleLabel = UILabel()
    var subTitleLabel = UILabel()
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
        
        //Setup Title Label
        self.setupTitleLabel()
        
        //Setup SubTitleLabel
        self.setupSubTitleLabel()
        
        //Setup Accessory ImageView
        self.setupAccessoryImageView()
        
        //Setup Separator View
        self.setupSeparatorView()
        
        //Setup Constraints
        self.setupConstraints()
    }
    
    func setupTitleLabel(){
        self.titleLabel.textColor = .darkGray
        self.titleLabel.font = UIFont.boldSystemFont(ofSize: 14)
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.titleLabel)
    }
    
    func setupSubTitleLabel(){
        self.subTitleLabel.text = "viewAll".localized()
        self.subTitleLabel.textColor = YHColor.blue
        self.subTitleLabel.font = UIFont.systemFont(ofSize: 12)
        self.subTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.subTitleLabel)
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
        
        let viewDict = ["titleLabel": titleLabel, "subTitleLabel": subTitleLabel, "accessoryImageView": accessoryImageView, "separatorView": separatorView, "spacerView": spacerView] as [String : Any]
        //Width & Horizontal Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[titleLabel][spacerView(>=8)][subTitleLabel][accessoryImageView(20)]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[separatorView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        //Height & Vertical Alignment
        self.addConstraints([NSLayoutConstraint.init(item: self.titleLabel, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)])
        self.addConstraints([NSLayoutConstraint.init(item: self.subTitleLabel, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)])
        self.addConstraints([NSLayoutConstraint.init(item: self.accessoryImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)])
        self.addConstraints([NSLayoutConstraint.init(item: self.accessoryImageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 20)])
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[separatorView(0.5)]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
    }
    
    func configure(title: String?){
        self.titleLabel.text = title
    }
}

//
//  DailyFantasyContestTableHeader.swift
//  Yahoo Fantasy Sports
//
//  Created by Justin Wells on 7/18/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

class DailyLobbyFantasyContestTableHeader: UIView{
    
    var imageView = UIImageView()
    var titleLabel = UILabel()
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
        
        //Setup ImageView
        self.setupImageView()
        
        //Setup Title Label
        self.setupTitleLabel()
        
        //Setup Separator View
        self.setupSeparatorView()
        
        //Setup Constraints
        self.setupConstraints()
    }
    
    func setupImageView(){
        self.imageView.tintColor = YHColor.green
        self.imageView.clipsToBounds = true
        self.imageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.imageView)
    }
    
    func setupTitleLabel(){
        self.titleLabel.textColor = .darkGray
        self.titleLabel.font = UIFont.boldSystemFont(ofSize: 14)
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.titleLabel)
    }
    
    func setupSeparatorView(){
        self.separatorView.backgroundColor = .lightGray
        self.separatorView.isUserInteractionEnabled = false
        self.separatorView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.separatorView)
    }
    
    func setupConstraints(){
        let viewDict = ["imageView": imageView, "titleLabel": titleLabel, "separatorView": separatorView] as [String : Any]
        //Width & Horizontal Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[imageView(25)]-[titleLabel]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[separatorView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
                //Height & Vertical Alignment
        self.addConstraints([NSLayoutConstraint.init(item: imageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)])
        self.addConstraints([NSLayoutConstraint.init(item: imageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 25)])
        self.addConstraints([NSLayoutConstraint.init(item: titleLabel, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)])
        self.addConstraints([NSLayoutConstraint.init(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 25)])
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[separatorView(0.5)]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
    }
    
    func configure(image: UIImage?, title: String?){
        imageView.image = image?.withRenderingMode(.alwaysTemplate)
        titleLabel.text = title
    }
}

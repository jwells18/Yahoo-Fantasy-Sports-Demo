//
//  LeagueMyTeamPlayerSectionView.swift
//  Yahoo Fantasy Sports
//
//  Created by Justin Wells on 7/19/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

class LeagueMyTeamPlayerSectionView: UIView{
    
    var titleLabel = UILabel()
    var separatorViewTop = UIView()
    var separatorViewBottom = UIView()
    
    public override init(frame: CGRect){
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
        
        //Setup Separator Views
        self.setupSeparatorViews()
        
        //Setup Constraints
        self.setupConstraints()
    }
    
    func setupTitleLabel(){
        self.titleLabel.textColor = .darkGray
        self.titleLabel.font = UIFont.boldSystemFont(ofSize: 14)
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.titleLabel)
    }
    
    func setupSeparatorViews(){
        let separators = [self.separatorViewTop, self.separatorViewBottom]
        for separator in separators{
            separator.backgroundColor = .lightGray
            separator.isUserInteractionEnabled = false
            separator.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(separator)
        }
    }
    
    func setupConstraints(){
        let viewDict = ["titleLabel": titleLabel, "separatorViewTop": separatorViewTop, "separatorViewBottom": separatorViewBottom] as [String : Any]
        //Width & Horizontal Alignment
        self.addConstraints([NSLayoutConstraint.init(item: titleLabel, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)])
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[separatorViewTop]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[separatorViewBottom]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        //Height & Vertical Alignment
        self.addConstraints([NSLayoutConstraint.init(item: titleLabel, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)])
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[separatorViewTop(0.5)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[separatorViewBottom(0.5)]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
    }
    
    func configure(title: String?){
        self.titleLabel.text = title
    }
}

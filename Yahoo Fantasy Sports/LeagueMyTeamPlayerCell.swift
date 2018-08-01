//
//  LeagueMyTeamPlayerCell.swift
//  Yahoo Fantasy Sports
//
//  Created by Justin Wells on 7/19/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

class LeagueMyTeamPlayerCell: UITableViewCell{
    
    var leftTitleLabel = UILabel()
    var mainImageView = UIImageView()
    var titleLabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        //Setup View
        self.setupView()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    func setupView(){
        self.backgroundColor = .white
        self.clipsToBounds = false
        self.selectionStyle = .none
        
        //Setup Left Title Label
        self.setupLeftTitleLabel()
        
        //Setup Main ImageView
        self.setupMainImageView()
        
        //Setup Title Label
        self.setupTitleLabel()
        
        //Setup Constraints
        self.setupConstraints()
    }
    
    func setupLeftTitleLabel(){
        self.leftTitleLabel.textColor = .gray
        self.leftTitleLabel.font = UIFont.boldSystemFont(ofSize: 12)
        self.leftTitleLabel.adjustsFontSizeToFitWidth = true
        self.leftTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.leftTitleLabel)
    }
    
    func setupMainImageView(){
        self.mainImageView.clipsToBounds = true
        self.mainImageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.mainImageView)
    }
    
    func setupTitleLabel(){
        self.titleLabel.textColor = .darkGray
        self.titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.titleLabel)
    }
    
    func setupConstraints(){
        let spacerViewTop = UIView()
        spacerViewTop.isUserInteractionEnabled = false
        spacerViewTop.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(spacerViewTop)
        let spacerViewBottom = UIView()
        spacerViewBottom.isUserInteractionEnabled = false
        spacerViewBottom.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(spacerViewBottom)
        
        let viewDict = ["leftTitleLabel": leftTitleLabel, "mainImageView": mainImageView, "titleLabel": titleLabel, "spacerViewTop": spacerViewTop, "spacerViewBottom": spacerViewBottom] as [String : Any]
        //Width & Horizontal Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[leftTitleLabel(25)]-[mainImageView(50)]-[titleLabel]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        //Height & Vertical Alignment
        self.addConstraints([NSLayoutConstraint.init(item: leftTitleLabel, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)])
        self.addConstraints([NSLayoutConstraint.init(item: mainImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)])
        self.addConstraints([NSLayoutConstraint.init(item: mainImageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 50)])
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[spacerViewTop(==spacerViewBottom)][titleLabel][spacerViewBottom(==spacerViewTop)]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraints([NSLayoutConstraint.init(item: spacerViewTop, attribute: .height, relatedBy: .greaterThanOrEqual, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 20)])
        self.addConstraints([NSLayoutConstraint.init(item: spacerViewBottom, attribute: .height, relatedBy: .greaterThanOrEqual, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 20)])
    }
    
    func configure(image: UIImage?, title: String?, leftTitle: String?){
        self.leftTitleLabel.text = leftTitle
        self.mainImageView.image = image
        self.titleLabel.text = title
    }
}

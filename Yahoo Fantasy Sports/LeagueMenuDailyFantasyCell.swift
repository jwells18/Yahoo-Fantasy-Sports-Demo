//
//  LeagueMenuDailyFantasyCell.swift
//  Yahoo Fantasy Sports
//
//  Created by Justin Wells on 7/18/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

class LeagueMenuDailyFantasyCell: UICollectionViewCell{
    
    var mainImageView = UIImageView()
    var titleLabel = UILabel()
    var subTitleLabel = UILabel()
    var mainButton = UIButton()
    
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
        self.layer.cornerRadius = 5
        
        //Setup Main ImageView
        self.setupMainImageView()
        
        //Setup Title Label
        self.setupTitleLabel()
        
        //Setup SubTitle Label
        self.setupSubTitleLabel()
        
        //Setup Main Button
        self.setupMainButton()
        
        //Setup Constraints
        self.setupConstraints()
    }
    
    func setupMainImageView(){
        self.mainImageView.image = UIImage(named: "footballLeaguePlaceholder")
        self.mainImageView.backgroundColor = YHColor.faintGray
        self.mainImageView.contentMode = .scaleAspectFit
        self.mainImageView.clipsToBounds = true
        self.mainImageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.mainImageView)
    }
    
    func setupTitleLabel(){
        self.titleLabel.text = "dailyFantasy".localized()
        self.titleLabel.textColor = .darkGray
        self.titleLabel.font = UIFont.boldSystemFont(ofSize: 14)
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.titleLabel)
    }
    
    func setupSubTitleLabel(){
        self.subTitleLabel.text = "dailyFantasyLeagueMenuSubTitle".localized()
        self.subTitleLabel.textColor = .gray
        self.subTitleLabel.numberOfLines = 0
        self.subTitleLabel.font = UIFont.systemFont(ofSize: 12)
        self.subTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(subTitleLabel)
    }
    
    func setupMainButton(){
        self.mainButton.setTitle("playNow".localized(), for: .normal)
        self.mainButton.setTitleColor(YHColor.blue, for: .normal)
        self.mainButton.layer.borderColor = YHColor.blue.cgColor
        self.mainButton.layer.borderWidth = 2
        self.mainButton.layer.cornerRadius = 5
        self.mainButton.clipsToBounds = true
        self.mainButton.contentEdgeInsets = UIEdgeInsetsMake(4, 8, 4, 8)
        self.mainButton.isUserInteractionEnabled = false
        self.mainButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.mainButton)
    }
    
    func setupConstraints(){
        let spacerView = UIView()
        spacerView.isUserInteractionEnabled = false
        spacerView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(spacerView)
        let spacerViewTop = UIView()
        spacerViewTop.isUserInteractionEnabled = false
        spacerViewTop.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(spacerViewTop)
        let spacerViewBottom = UIView()
        spacerViewBottom.isUserInteractionEnabled = false
        spacerViewBottom.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(spacerViewBottom)
        
        let viewDict = ["mainImageView": mainImageView, "titleLabel": titleLabel, "subTitleLabel": subTitleLabel, "mainButton": mainButton, "spacerView": spacerView, "spacerViewTop": spacerViewTop, "spacerViewBottom": spacerViewBottom] as [String : Any]
        //Width & Horizontal Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[mainImageView(40)]-[titleLabel][spacerView][mainButton]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraints([NSLayoutConstraint.init(item: subTitleLabel, attribute: .left, relatedBy: .equal, toItem: titleLabel, attribute: .left, multiplier: 1, constant: 0)])
        self.addConstraints([NSLayoutConstraint.init(item: subTitleLabel, attribute: .width, relatedBy: .equal, toItem: titleLabel, attribute: .width, multiplier: 1, constant: 0)])
        //Height & Vertical Alignment
        self.addConstraints([NSLayoutConstraint.init(item: mainImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)])
        self.addConstraints([NSLayoutConstraint.init(item: mainImageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 40)])
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[spacerViewTop(==spacerViewBottom)][titleLabel][subTitleLabel][spacerViewBottom(==spacerViewTop)]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraints([NSLayoutConstraint.init(item: mainButton, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)])
        self.addConstraints([NSLayoutConstraint.init(item: mainButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 40)])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.mainImageView.layer.cornerRadius = self.mainImageView.frame.width/cornerRadiusDivisor
    }
}

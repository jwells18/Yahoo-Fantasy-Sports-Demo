//
//  DailyFantasyLobbyLeaguesCell.swift
//  Yahoo Fantasy Sports
//
//  Created by Justin Wells on 7/20/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

class DailyFantasyLobbyLeaguesCell: UICollectionViewCell{
    
    var headerContainerView = UIView()
    var headerImageView = UIImageView()
    var headerTitleLabel = UILabel()
    var headerSubTitleLabel = UILabel()
    var titleLabel = UILabel()
    var subTitleLabel = UILabel()
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
        
        //Setup Header ContainerView
        self.setupHeaderContainerView()
        
        //Setup Header ImageView
        self.setupHeaderImageView()
        
        //Setup Header Title Label
        self.setupHeaderTitleLabel()
        
        //Setup Header SubTitle Label
        self.setupHeaderSubTitleLabel()
        
        //Setup Title Label
        self.setupTitleLabel()
        
        //Setup SubtTitle Label
        self.setupSubTitleLabel()
        
        //Setup Accessory ImageView
        self.setupAccessoryImageView()
        
        //Setup Constraints
        self.setupConstraints()
    }
    
    func setupHeaderContainerView(){
        self.headerContainerView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.headerContainerView)
    }
    
    func setupHeaderImageView(){
        self.headerImageView.tintColor = YHColor.green
        self.headerImageView.clipsToBounds = true
        self.headerImageView.translatesAutoresizingMaskIntoConstraints = false
        self.headerContainerView.addSubview(self.headerImageView)
    }
    
    func setupHeaderTitleLabel(){
        self.headerTitleLabel.textColor = .darkGray
        self.headerTitleLabel.font = UIFont.boldSystemFont(ofSize: 14)
        self.headerTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.headerContainerView.addSubview(self.headerTitleLabel)
    }
    
    func setupHeaderSubTitleLabel(){
        self.headerSubTitleLabel.textColor = .gray
        self.headerSubTitleLabel.textAlignment = .right
        self.headerSubTitleLabel.font = UIFont.systemFont(ofSize: 12)
        self.headerSubTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.headerContainerView.addSubview(self.headerSubTitleLabel)
    }
    
    func setupTitleLabel(){
        self.titleLabel.textColor = .darkGray
        self.titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.titleLabel)
    }
    
    func setupSubTitleLabel(){
        self.subTitleLabel.textColor = .gray
        self.subTitleLabel.font = UIFont.systemFont(ofSize: 14)
        self.subTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.subTitleLabel)
    }
    
    func setupAccessoryImageView(){
        self.accessoryImageView.image = UIImage(named: "forward")?.withRenderingMode(.alwaysTemplate)
        self.accessoryImageView.tintColor = YHColor.blue
        self.accessoryImageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.accessoryImageView)
    }
    
    func setupConstraints(){
        let viewDict = ["headerContainerView": headerContainerView, "headerImageView": headerImageView, "headerTitleLabel": headerTitleLabel, "headerSubTitleLabel": headerSubTitleLabel, "titleLabel": titleLabel, "subTitleLabel": subTitleLabel, "accessoryImageView": accessoryImageView] as [String : Any]
        //Width & Horizontal Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[headerContainerView]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.headerContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[headerImageView(25)]-[headerTitleLabel(>=100)][headerSubTitleLabel]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[titleLabel]-[accessoryImageView(20)]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraints([NSLayoutConstraint.init(item: subTitleLabel, attribute: .left, relatedBy: .equal, toItem: self.titleLabel, attribute: .left, multiplier: 1, constant: 0)])
        self.addConstraints([NSLayoutConstraint.init(item: subTitleLabel, attribute: .width, relatedBy: .equal, toItem: self.titleLabel, attribute: .width, multiplier: 1, constant: 0)])
        //Height & Vertical Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[headerContainerView(40)]-[titleLabel(20)][subTitleLabel(18)]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.headerContainerView.addConstraints([NSLayoutConstraint.init(item: headerImageView, attribute: .centerY, relatedBy: .equal, toItem: self.headerContainerView, attribute: .centerY, multiplier: 1, constant: 0)])
        self.headerContainerView.addConstraints([NSLayoutConstraint.init(item: headerImageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 25)])
        self.headerContainerView.addConstraints([NSLayoutConstraint.init(item: headerTitleLabel, attribute: .centerY, relatedBy: .equal, toItem: self.headerContainerView, attribute: .centerY, multiplier: 1, constant: 0)])
        self.headerContainerView.addConstraints([NSLayoutConstraint.init(item: headerSubTitleLabel, attribute: .centerY, relatedBy: .equal, toItem: self.headerContainerView, attribute: .centerY, multiplier: 1, constant: 0)])
        self.addConstraints([NSLayoutConstraint.init(item: accessoryImageView, attribute: .top, relatedBy: .equal, toItem: self.titleLabel, attribute: .top, multiplier: 1, constant: 9)])
        self.addConstraints([NSLayoutConstraint.init(item: accessoryImageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 20)])
    }
    
    func configure(league: DailyFantasyLeague?){
        if(league != nil){
            headerImageView.image = UIImage(named: league?.sport.rawValue ?? "")?.withRenderingMode(.alwaysTemplate)
            headerTitleLabel.text = league?.name
            headerSubTitleLabel.text = String(format: "%@ %@", league?.totalRounds.stringValue ?? "0", "rounds".localized())
            titleLabel.text = "enterLeagueForFree".localized()
            var entryFee = "--"
            if league?.entryFee == 0{
                entryFee = "free".localized()
            }
            else if league?.entryFee.intValue ?? 0 > 0{
                entryFee = league?.entryFee.shortNumberString(style: .currency) ?? ""
            }
            let totalPrize = league?.totalPrize ?? 0
            let entryCount = league?.entryCount ?? 0
            let entryLimit = league?.entryLimit ?? 0
            subTitleLabel.text = String(format: "%@ %@ | %@ %@ | %@/%@ %@", entryFee, "entry".localized(), totalPrize.shortNumberString(style: .currency), "prizes".localized(), entryCount.shortNumberString(style: .none), entryLimit.shortNumberString(style: .none), "entries".localized())
        }
    }
}

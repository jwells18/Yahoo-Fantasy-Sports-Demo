//
//  HomeFantasyLeagueCell.swift
//  Yahoo Fantasy Sports
//
//  Created by Justin Wells on 7/15/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit
import SDWebImage

class HomeFantasyLeagueCell: UICollectionViewCell{
    
    private var gradient = CAGradientLayer()
    var headerContainerView = UIView()
    var headerImageView = UIImageView()
    var headerTitleLabel = UILabel()
    var mainContainerView = UIView()
    var mainImageView = UIImageView()
    var mainTitleLabel = UILabel()
    var mainSubTitleLabel = UILabel()
    
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
        /*
        //TODO: Add Shadow
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOpacity = 0.8
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowRadius = (self.frame.width+4)/2*/
        
        //Setup Header ContainerView
        self.setupHeaderContainerView()
        
        //Setup Header ImageView
        self.setupHeaderImageView()
        
        //setup Header Title Label
        self.setupHeaderTitleLabel()
        
        //Setup Main ContainerView
        self.setupMainContainerView()
        
        //Setup Main ImageView
        self.setupMainImageView()
        
        //Setup Main Title Label
        self.setupMainTitleLabel()
        
        //Setup Main SubTitle Label
        self.setupMainSubTitleLabel();
        
        //Setup Constraints
        self.setupConstraints()
    }
    
    func setupHeaderContainerView(){
        self.headerContainerView.clipsToBounds = true
        self.headerContainerView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.headerContainerView)
        
        //Set Gradient Background
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        self.headerContainerView.layer.insertSublayer(gradient, at: 0)
    }
    
    func setupHeaderImageView(){
        self.headerImageView.clipsToBounds = true
        self.headerImageView.translatesAutoresizingMaskIntoConstraints = false
        self.headerContainerView.addSubview(self.headerImageView)
    }
    
    func setupHeaderTitleLabel(){
        self.headerTitleLabel.textColor = .white
        self.headerTitleLabel.font = UIFont.boldSystemFont(ofSize: 14)
        self.headerTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.headerContainerView.addSubview(self.headerTitleLabel)
    }
    
    func setupMainContainerView(){
        self.mainContainerView.backgroundColor = .white
        self.mainContainerView.clipsToBounds = true
        self.mainContainerView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.mainContainerView)
    }
    
    func setupMainImageView(){
        self.mainImageView.backgroundColor = YHColor.faintGray
        self.mainImageView.clipsToBounds = true
        self.mainImageView.layer.cornerRadius = 50/cornerRadiusDivisor
        self.mainImageView.translatesAutoresizingMaskIntoConstraints = false
        self.mainContainerView.addSubview(self.mainImageView)
    }
    
    func setupMainTitleLabel(){
        self.mainTitleLabel.textColor = .orange
        self.mainTitleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        self.mainTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.mainContainerView.addSubview(self.mainTitleLabel)
    }
    
    func setupMainSubTitleLabel(){
        self.mainSubTitleLabel.textColor = .gray
        self.mainSubTitleLabel.numberOfLines = 1
        self.mainSubTitleLabel.font = UIFont.systemFont(ofSize: 14)
        self.mainSubTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.mainContainerView.addSubview(mainSubTitleLabel)
    }
    
    func setupConstraints(){
        let spacerViewTop = UIView()
        spacerViewTop.isUserInteractionEnabled = false
        spacerViewTop.translatesAutoresizingMaskIntoConstraints = false
        self.mainContainerView.addSubview(spacerViewTop)
        let spacerViewBottom = UIView()
        spacerViewBottom.isUserInteractionEnabled = false
        spacerViewBottom.translatesAutoresizingMaskIntoConstraints = false
        self.mainContainerView.addSubview(spacerViewBottom)
        
        let viewDict = ["headerContainerView": headerContainerView, "headerImageView": headerImageView, "headerTitleLabel": headerTitleLabel, "mainContainerView": mainContainerView, "mainImageView": mainImageView, "mainTitleLabel": mainTitleLabel, "mainSubTitleLabel": mainSubTitleLabel,"spacerViewTop": spacerViewTop, "spacerViewBottom": spacerViewBottom] as [String : Any]
        //Width & Horizontal Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[headerContainerView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[mainContainerView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.headerContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[headerImageView(25)]-[headerTitleLabel]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.mainContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[mainImageView(50)]-[mainTitleLabel]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.mainContainerView.addConstraints([NSLayoutConstraint.init(item: mainSubTitleLabel, attribute: .left, relatedBy: .equal, toItem: mainTitleLabel, attribute: .left, multiplier: 1, constant: 0)])
        self.mainContainerView.addConstraints([NSLayoutConstraint.init(item: mainSubTitleLabel, attribute: .width, relatedBy: .equal, toItem: mainTitleLabel, attribute: .width, multiplier: 1, constant: 0)])
        //Height & Vertical Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[headerContainerView(40)][mainContainerView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.headerContainerView.addConstraints([NSLayoutConstraint.init(item: headerImageView, attribute: .centerY, relatedBy: .equal, toItem: self.headerContainerView, attribute: .centerY, multiplier: 1, constant: 0)])
        self.headerContainerView.addConstraints([NSLayoutConstraint.init(item: headerImageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 25)])
        self.headerContainerView.addConstraints([NSLayoutConstraint.init(item: headerTitleLabel, attribute: .centerY, relatedBy: .equal, toItem: self.headerContainerView, attribute: .centerY, multiplier: 1, constant: 0)])
        self.headerContainerView.addConstraints([NSLayoutConstraint.init(item: headerTitleLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 25)])
        self.mainContainerView.addConstraints([NSLayoutConstraint.init(item: mainImageView, attribute: .centerY, relatedBy: .equal, toItem: self.mainContainerView, attribute: .centerY, multiplier: 1, constant: 0)])
        self.mainContainerView.addConstraints([NSLayoutConstraint.init(item: mainImageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 50)])
        self.mainContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[spacerViewTop(==spacerViewBottom)][mainTitleLabel][mainSubTitleLabel][spacerViewBottom(==spacerViewTop)]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //Set Frames
        gradient.frame = self.headerContainerView.bounds
    }
    
    func configure(team: DBTeam){
        //Setup Header ContainerView
        gradient.colors = [YHColor.red.cgColor, YHColor.darkRed.cgColor]
        headerImageView.image = UIImage(named: team.sport)
        headerTitleLabel.text = String(format: "%@ %@", team.leagueName, "league".localized())
        //Set MainContainerView
        if team.image != nil{
            mainImageView.sd_setImage(with: URL(string: (team.image)!), placeholderImage: UIImage(named: "footballLeaguePlaceholder"))
        }
        else{
            mainImageView.image = UIImage(named: "footballLeaguePlaceholder")
        }
        mainTitleLabel.text = String(format: "%@ %@", team.name, "team".localized())
        mainSubTitleLabel.text = String(format: "%@ %@", String(Int(team.points)), "pts".localized())
    }
}

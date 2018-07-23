//
//  HomeDailyFantasyCell.swift
//  Yahoo Fantasy Sports
//
//  Created by Justin Wells on 7/15/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import Foundation
import SDWebImage

protocol HomeDailyFantasyCellDelegate {
    func didPressSettingsButton()
}

class HomeDailyFantasyCell: UICollectionViewCell{
    
    var homeDailyFantasyCellDelegate: HomeDailyFantasyCellDelegate!
    private var gradient = CAGradientLayer()
    var headerContainerView = UIView()
    var headerImageView = UIImageView()
    var headerTitleLabel = UILabel()
    var headerSubTitleLabel = UILabel()
    var headerSettingsButton = UIButton()
    var mainContainerView = UIView()
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
        
        //Setup Header ContainerView
        self.setupHeaderContainerView()
        
        //Setup Header ImageView
        self.setupHeaderImageView()
        
        //Setup Header Title Label
        self.setupHeaderTitleLabel()
        
        //Setup Header SubTitle Label
        self.setupHeaderSubTitleLabel()
        
        //Setup Header Settings Button
        self.setupHeaderSettingsButton()
        
        //Setup Main ContainerView
        self.setupMainContainerView()
        
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
        gradient.colors = [YHColor.mint.cgColor, YHColor.darkMint.cgColor]
        self.headerContainerView.layer.insertSublayer(gradient, at: 0)
    }
    
    func setupHeaderImageView(){
        self.headerImageView.image = UIImage(named: "yahooDailyFantasyLogo")
        self.headerImageView.clipsToBounds = true
        self.headerImageView.translatesAutoresizingMaskIntoConstraints = false
        self.headerContainerView.addSubview(self.headerImageView)
    }
    
    func setupHeaderTitleLabel(){
        self.headerTitleLabel.text = "dailyFantasy".localized()
        self.headerTitleLabel.textColor = .white
        self.headerTitleLabel.font = UIFont.systemFont(ofSize: 16)
        self.headerTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.headerContainerView.addSubview(self.headerTitleLabel)
    }
    
    func setupHeaderSubTitleLabel(){
        self.headerSubTitleLabel.text = "dailyFantasySubTitle".localized()
        self.headerSubTitleLabel.textColor = .white
        self.headerSubTitleLabel.font = UIFont.systemFont(ofSize: 12)
        self.headerSubTitleLabel.numberOfLines = 2;
        self.headerSubTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.headerContainerView.addSubview(self.headerSubTitleLabel)
    }
    
    func setupHeaderSettingsButton(){
        self.headerSettingsButton.setImage(UIImage(named: "settings"), for: .normal)
        self.headerSettingsButton.addTarget(self, action: #selector(didPressSettingsButton(sender:)), for: .touchUpInside)
        self.headerSettingsButton.translatesAutoresizingMaskIntoConstraints = false
        self.headerContainerView.addSubview(self.headerSettingsButton);
    }
    
    func setupMainContainerView(){
        self.mainContainerView.backgroundColor = .white
        self.mainContainerView.clipsToBounds = true
        self.mainContainerView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.mainContainerView)
    }
    
    func setupMainTitleLabel(){
        self.mainTitleLabel.textColor = .darkGray
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
        let headerSpacerViewTop = UIView()
        headerSpacerViewTop.isUserInteractionEnabled = false
        headerSpacerViewTop.translatesAutoresizingMaskIntoConstraints = false
        self.headerContainerView.addSubview(headerSpacerViewTop)
        let headerSpacerViewBottom = UIView()
        headerSpacerViewBottom.isUserInteractionEnabled = false
        headerSpacerViewBottom.translatesAutoresizingMaskIntoConstraints = false
        self.headerContainerView.addSubview(headerSpacerViewBottom)
        let mainSpacerViewTop = UIView()
        mainSpacerViewTop.isUserInteractionEnabled = false
        mainSpacerViewTop.translatesAutoresizingMaskIntoConstraints = false
        self.mainContainerView.addSubview(mainSpacerViewTop)
        let mainSpacerViewBottom = UIView()
        mainSpacerViewBottom.isUserInteractionEnabled = false
        mainSpacerViewBottom.translatesAutoresizingMaskIntoConstraints = false
        self.mainContainerView.addSubview(mainSpacerViewBottom)
        
        let viewDict = ["headerContainerView": headerContainerView, "headerImageView": headerImageView, "headerTitleLabel": headerTitleLabel, "headerSubTitleLabel": headerSubTitleLabel, "headerSettingsButton": headerSettingsButton, "mainContainerView": mainContainerView, "mainTitleLabel": mainTitleLabel, "mainSubTitleLabel": mainSubTitleLabel,"headerSpacerViewTop": headerSpacerViewTop, "headerSpacerViewBottom": headerSpacerViewBottom, "mainSpacerViewTop": mainSpacerViewTop, "mainSpacerViewBottom": mainSpacerViewBottom] as [String : Any]
        //Width & Horizontal Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[headerContainerView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[mainContainerView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.headerContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[headerImageView(50)]-16-[headerTitleLabel]-[headerSettingsButton(25)]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.headerContainerView.addConstraints([NSLayoutConstraint.init(item: headerSubTitleLabel, attribute: .left, relatedBy: .equal, toItem: headerTitleLabel, attribute: .left, multiplier: 1, constant: 0)])
        self.headerContainerView.addConstraints([NSLayoutConstraint.init(item: headerSubTitleLabel, attribute: .width, relatedBy: .equal, toItem: headerTitleLabel, attribute: .width, multiplier: 1, constant: 0)])
        self.mainContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[mainTitleLabel]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.mainContainerView.addConstraints([NSLayoutConstraint.init(item: mainSubTitleLabel, attribute: .left, relatedBy: .equal, toItem: mainTitleLabel, attribute: .left, multiplier: 1, constant: 0)])
        self.mainContainerView.addConstraints([NSLayoutConstraint.init(item: mainSubTitleLabel, attribute: .width, relatedBy: .equal, toItem: mainTitleLabel, attribute: .width, multiplier: 1, constant: 0)])
        //Height & Vertical Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[headerContainerView(75)][mainContainerView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.headerContainerView.addConstraints([NSLayoutConstraint.init(item: headerImageView, attribute: .centerY, relatedBy: .equal, toItem: self.headerContainerView, attribute: .centerY, multiplier: 1, constant: 0)])
        self.headerContainerView.addConstraints([NSLayoutConstraint.init(item: headerImageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 50)])
        self.headerContainerView.addConstraints([NSLayoutConstraint.init(item: headerSettingsButton, attribute: .centerY, relatedBy: .equal, toItem: self.headerContainerView, attribute: .centerY, multiplier: 1, constant: 0)])
        self.headerContainerView.addConstraints([NSLayoutConstraint.init(item: headerSettingsButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 25)])
        self.headerContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[headerSpacerViewTop(==headerSpacerViewBottom)][headerTitleLabel][headerSubTitleLabel][headerSpacerViewBottom(==headerSpacerViewTop)]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.mainContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[mainSpacerViewTop(==mainSpacerViewBottom)][mainTitleLabel][mainSubTitleLabel][mainSpacerViewBottom(==mainSpacerViewTop)]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //Set Frames
        gradient.frame = self.headerContainerView.bounds
    }
    
    func configure(contest: DailyFantasyContest?){
        if(contest != nil){
            mainTitleLabel.text = contest?.name ?? ""
            mainSubTitleLabel.text = String(format: "%@/%@ %@ | %@ | %@ %@ | %@", contest?.entryCount.stringValue ?? "--", contest?.entryLimit.stringValue ?? "--", "entries".localized(),contest?.entryFee.shortNumberString(style: .currency) ?? "--", contest?.totalPrize.shortNumberString(style: .currency) ?? "--", "prizes".localized(), contest?.startDate.dayAndTime() ?? "--")
        }
    }
    
    //Button Delegates
    func didPressSettingsButton(sender: UIButton){
        self.homeDailyFantasyCellDelegate.didPressSettingsButton();
    }
}

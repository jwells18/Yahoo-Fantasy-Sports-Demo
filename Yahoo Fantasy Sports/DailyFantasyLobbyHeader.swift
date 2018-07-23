//
//  DailyFantasyLobbyHeader.swift
//  Yahoo Fantasy Sports
//
//  Created by Justin Wells on 7/17/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit
import HMSegmentedControl

class DailyFantasyLobbyHeader: UIView{
    
    var topContainerView = UIView()
    var userButton = UIButton()
    var winningCountLabel = UILabel()
    var winningLabel = UILabel()
    var liveCountLabel = UILabel()
    var liveLabel = UILabel()
    var upcomingCountLabel = UILabel()
    var upcomingLabel = UILabel()
    var verticalSeparator1 = UIView()
    var verticalSeparator2 = UIView()
    var horizontalSeparator1 = UIView()
    var horizontalSeparator2 = UIView()
    var segmentedControl = HMSegmentedControl()
    
    public override init(frame: CGRect){
        super.init(frame: frame)
        //Setup View
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
        self.backgroundColor = .white
        
        //Setup Top ContainerView
        self.setupTopContainerView()
        
        //Setup User Button
        self.setupUserButton()
        
        //Setup Winning Count Label
        self.setupWinningCountLabel()
        
        //Setup Winning Label
        self.setupWinningLabel()
        
        //Setup Live CountLabel
        self.setupLiveCountLabel()
        
        //Setup Live Label
        self.setupLiveLabel()
        
        //Setup Upcoming Count Label
        self.setupUpcomingCountLabel()
        
        //Setup Upcoming Label
        self.setupUpcomingLabel()
        
        //Setup SegmentedControl
        self.setupSegmentedControl()
        
        //Setup Separators
        self.setupSeparators()
        
        //Setup Constraints
        self.setupConstraints()
    }
    
    func setupTopContainerView(){
        self.topContainerView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.topContainerView)
    }
    
    func setupUserButton(){
        self.userButton.backgroundColor = YHColor.faintGray
        self.userButton.clipsToBounds = true
        self.userButton.translatesAutoresizingMaskIntoConstraints = false
        self.topContainerView.addSubview(self.userButton)
    }
    
    func setupWinningCountLabel(){
        self.winningCountLabel.textColor = YHColor.green
        self.winningCountLabel.textAlignment = .center
        self.winningCountLabel.font = UIFont.boldSystemFont(ofSize: 20)
        self.winningCountLabel.translatesAutoresizingMaskIntoConstraints = false
        self.topContainerView.addSubview(self.winningCountLabel)
    }
    
    func setupWinningLabel(){
        self.winningLabel.text = "winning".localized()
        self.winningLabel.textColor = .gray
        self.winningLabel.textAlignment = .center
        self.winningLabel.font = UIFont.systemFont(ofSize: 14)
        self.winningLabel.translatesAutoresizingMaskIntoConstraints = false
        self.topContainerView.addSubview(self.winningLabel)
    }
    
    func setupLiveCountLabel(){
        self.liveCountLabel.textColor = .darkGray
        self.liveCountLabel.textAlignment = .center
        self.liveCountLabel.font = UIFont.boldSystemFont(ofSize: 20)
        self.liveCountLabel.translatesAutoresizingMaskIntoConstraints = false
        self.topContainerView.addSubview(self.liveCountLabel)
    }
    
    func setupLiveLabel(){
        self.liveLabel.text = "live".localized()
        self.liveLabel.textColor = .gray
        self.liveLabel.textAlignment = .center
        self.liveLabel.font = UIFont.systemFont(ofSize: 14)
        self.liveLabel.translatesAutoresizingMaskIntoConstraints = false
        self.topContainerView.addSubview(self.liveLabel)
    }
    
    func setupUpcomingCountLabel(){
        self.upcomingCountLabel.textColor = .darkGray
        self.upcomingCountLabel.textAlignment = .center
        self.upcomingCountLabel.font = UIFont.boldSystemFont(ofSize: 20)
        self.upcomingCountLabel.translatesAutoresizingMaskIntoConstraints = false
        self.topContainerView.addSubview(self.upcomingCountLabel)
    }
    
    func setupUpcomingLabel(){
        self.upcomingLabel.text = "upcoming".localized()
        self.upcomingLabel.textColor = .gray
        self.upcomingLabel.textAlignment = .center
        self.upcomingLabel.font = UIFont.systemFont(ofSize: 14)
        self.upcomingLabel.translatesAutoresizingMaskIntoConstraints = false
        self.topContainerView.addSubview(self.upcomingLabel)
    }
    
    func setupSegmentedControl(){
        self.segmentedControl = HMSegmentedControl(sectionTitles: dailyFantasyLobbySegmentedTitles)
        self.segmentedControl.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: 44)
        self.segmentedControl.selectionIndicatorHeight = 0
        self.segmentedControl.segmentEdgeInset = UIEdgeInsetsMake(0, 10, 0, 10)
        self.segmentedControl.titleTextAttributes = [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 14), NSForegroundColorAttributeName: UIColor.darkGray]
        self.segmentedControl.selectedTitleTextAttributes = [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 14), NSForegroundColorAttributeName: YHColor.orange]
        self.segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(segmentedControl)
    }
    
    func setupSeparators(){
        let verticalSeparators = [verticalSeparator1, verticalSeparator2]
        for separator in verticalSeparators{
            separator.backgroundColor = .lightGray
            separator.translatesAutoresizingMaskIntoConstraints = false
            self.topContainerView.addSubview(separator)
        }
        let horizontalSeparators = [horizontalSeparator1, horizontalSeparator2]
        for separator in horizontalSeparators{
            separator.backgroundColor = .lightGray
            separator.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(separator)
        }
    }
    
    func setupConstraints(){
        let spacerViewTop = UIView()
        spacerViewTop.isUserInteractionEnabled = false
        spacerViewTop.translatesAutoresizingMaskIntoConstraints = false
        self.topContainerView.addSubview(spacerViewTop)
        let spacerViewBottom = UIView()
        spacerViewBottom.isUserInteractionEnabled = false
        spacerViewBottom.translatesAutoresizingMaskIntoConstraints = false
        self.topContainerView.addSubview(spacerViewBottom)
        
        let viewDict = ["topContainerView": topContainerView, "segmentedControl": segmentedControl, "userButton": userButton, "winningCountLabel": winningCountLabel, "winningLabel": winningLabel, "liveCountLabel": liveCountLabel, "liveLabel": liveLabel, "upcomingCountLabel": upcomingCountLabel, "upcomingLabel": upcomingLabel, "verticalSeparator1": verticalSeparator1, "verticalSeparator2": verticalSeparator2, "horizontalSeparator1": horizontalSeparator1, "horizontalSeparator2": horizontalSeparator2, "spacerViewTop": spacerViewTop, "spacerViewBottom": spacerViewBottom] as [String : Any]
        //Width & Horizontal Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[topContainerView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[segmentedControl]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[horizontalSeparator1]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[horizontalSeparator2]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.topContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-12-[userButton(50)]-12-[winningLabel(==liveLabel)][verticalSeparator1(0.5)][liveLabel(==upcomingLabel)][verticalSeparator2(0.5)][upcomingLabel(==winningLabel)]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.topContainerView.addConstraints([NSLayoutConstraint.init(item: winningCountLabel, attribute: .centerX, relatedBy: .equal, toItem: self.winningLabel, attribute: .centerX, multiplier: 1, constant: 0)])
        self.topContainerView.addConstraints([NSLayoutConstraint.init(item: winningCountLabel, attribute: .width, relatedBy: .equal, toItem: self.winningLabel, attribute: .width, multiplier: 1, constant: 0)])
        self.topContainerView.addConstraints([NSLayoutConstraint.init(item: liveCountLabel, attribute: .centerX, relatedBy: .equal, toItem: self.liveLabel, attribute: .centerX, multiplier: 1, constant: 0)])
        self.topContainerView.addConstraints([NSLayoutConstraint.init(item: liveCountLabel, attribute: .width, relatedBy: .equal, toItem: self.liveLabel, attribute: .width, multiplier: 1, constant: 0)])
        self.topContainerView.addConstraints([NSLayoutConstraint.init(item: upcomingCountLabel, attribute: .centerX, relatedBy: .equal, toItem: self.upcomingLabel, attribute: .centerX, multiplier: 1, constant: 0)])
        self.topContainerView.addConstraints([NSLayoutConstraint.init(item: upcomingCountLabel, attribute: .width, relatedBy: .equal, toItem: self.upcomingLabel, attribute: .width, multiplier: 1, constant: 0)])
        //Height & Vertical Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[topContainerView(80)][horizontalSeparator1(0.5)][segmentedControl(44)][horizontalSeparator2(0.5)]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.topContainerView.addConstraints([NSLayoutConstraint.init(item: userButton, attribute: .centerY, relatedBy: .equal, toItem: self.topContainerView, attribute: .centerY, multiplier: 1, constant: 0)])
        self.topContainerView.addConstraints([NSLayoutConstraint.init(item: userButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 50)])
        self.topContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[spacerViewTop(==spacerViewBottom)][winningCountLabel][winningLabel][spacerViewBottom(==spacerViewTop)]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.topContainerView.addConstraints([NSLayoutConstraint.init(item: liveCountLabel, attribute: .centerY, relatedBy: .equal, toItem: self.winningCountLabel, attribute: .centerY, multiplier: 1, constant: 0)])
        self.topContainerView.addConstraints([NSLayoutConstraint.init(item: liveCountLabel, attribute: .height, relatedBy: .equal, toItem: winningCountLabel, attribute: .height, multiplier: 1, constant: 0)])
        self.topContainerView.addConstraints([NSLayoutConstraint.init(item: liveLabel, attribute: .centerY, relatedBy: .equal, toItem: self.winningLabel, attribute: .centerY, multiplier: 1, constant: 0)])
        self.topContainerView.addConstraints([NSLayoutConstraint.init(item: liveLabel, attribute: .height, relatedBy: .equal, toItem: winningLabel, attribute: .height, multiplier: 1, constant: 0)])
        self.topContainerView.addConstraints([NSLayoutConstraint.init(item: upcomingCountLabel, attribute: .centerY, relatedBy: .equal, toItem: self.winningCountLabel, attribute: .centerY, multiplier: 1, constant: 0)])
        self.topContainerView.addConstraints([NSLayoutConstraint.init(item: upcomingCountLabel, attribute: .height, relatedBy: .equal, toItem: winningCountLabel, attribute: .height, multiplier: 1, constant: 0)])
        self.topContainerView.addConstraints([NSLayoutConstraint.init(item: upcomingLabel, attribute: .centerY, relatedBy: .equal, toItem: self.winningLabel, attribute: .centerY, multiplier: 1, constant: 0)])
        self.topContainerView.addConstraints([NSLayoutConstraint.init(item: upcomingLabel, attribute: .height, relatedBy: .equal, toItem: winningLabel, attribute: .height, multiplier: 1, constant: 0)])
        self.topContainerView.addConstraints([NSLayoutConstraint.init(item: verticalSeparator1, attribute: .centerY, relatedBy: .equal, toItem: self.topContainerView, attribute: .centerY, multiplier: 1, constant: 0)])
        self.topContainerView.addConstraints([NSLayoutConstraint.init(item: verticalSeparator1, attribute: .height, relatedBy: .equal, toItem: self.topContainerView, attribute: .height, multiplier: 0.5, constant: 0)])
        self.topContainerView.addConstraints([NSLayoutConstraint.init(item: verticalSeparator2, attribute: .centerY, relatedBy: .equal, toItem: self.topContainerView, attribute: .centerY, multiplier: 1, constant: 0)])
        self.topContainerView.addConstraints([NSLayoutConstraint.init(item: verticalSeparator2, attribute: .height, relatedBy: .equal, toItem: self.verticalSeparator1, attribute: .height, multiplier: 1, constant: 0)])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.userButton.layer.cornerRadius = 50/cornerRadiusDivisor
    }
    
    func configure(user: DBUser?){
        if user?.image != nil{
            self.userButton.sd_setImage(with: URL(string: (user?.image)!), for: .normal, completed: nil)
        }
        else{
            self.userButton.setImage(UIImage(named: "userImagePlaceholder"), for: .normal)
        }
        self.winningCountLabel.text = "$0"
        self.liveCountLabel.text = "0"
        self.upcomingCountLabel.text = "0"
    }
}

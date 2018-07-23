//
//  DailyFantasyResearchHeader.swift
//  Yahoo Fantasy Sports
//
//  Created by Justin Wells on 7/17/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

class DailyFantasyResearchHeader: UIView{
    
    var leagueButton = UIButton()
    var leagueDropDownButton = UIButton()
    var dateBackwardButton = UIButton()
    var dateButton = UIButton()
    var dateForwardButton = UIButton()
    
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
        
        //Setup League Button
        self.setupLeagueButton()
        
        //Setup League DropDown Button
        self.setupLeagueDropDownButton()
        
        //Setup Date Backward Button
        self.setupDateBackwardButton()
        
        //Setup Date Button
        self.setupDateButton()
        
        //Setup Date Foreward Button
        self.setupDateForwardButton()
        
        //Setup Constraints
        self.setupConstraints()
    }
    
    func setupLeagueButton(){
        self.leagueButton.setTitleColor(.darkGray, for: .normal)
        self.leagueButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        self.leagueButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.leagueButton)
    }
    
    func setupLeagueDropDownButton(){
        self.leagueDropDownButton.setImage(UIImage(named: "arrowDown")?.withRenderingMode(.alwaysTemplate), for: .normal)
        self.leagueDropDownButton.tintColor = .darkGray
        self.leagueDropDownButton.imageEdgeInsets = UIEdgeInsetsMake(2, 2, 2, 2)
        self.leagueDropDownButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.leagueDropDownButton)
    }
    
    func setupDateBackwardButton(){
        self.dateBackwardButton.setImage(UIImage(named: "backward")?.withRenderingMode(.alwaysTemplate), for: .normal)
        self.dateBackwardButton.tintColor = .darkGray
        self.dateBackwardButton.imageEdgeInsets = UIEdgeInsetsMake(2, 2, 2, 2)
        self.dateBackwardButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.dateBackwardButton)
    }
    
    func setupDateButton(){
        self.dateButton.setTitleColor(.darkGray, for: .normal)
        self.dateButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        self.dateButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.dateButton)
    }
    
    func setupDateForwardButton(){
        self.dateForwardButton.setImage(UIImage(named: "forward")?.withRenderingMode(.alwaysTemplate), for: .normal)
        self.dateForwardButton.tintColor = .darkGray
        self.dateForwardButton.imageEdgeInsets = UIEdgeInsetsMake(2, 2, 2, 2)
        self.dateForwardButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.dateForwardButton)
    }
    
    func setupConstraints(){
        let spacerView = UIView()
        spacerView.isUserInteractionEnabled = false
        spacerView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(spacerView)
        
        let viewDict = ["leagueButton": leagueButton, "leagueDropDownButton": leagueDropDownButton, "dateBackwardButton": dateBackwardButton, "dateButton": dateButton, "dateForwardButton": dateForwardButton, "spacerView": spacerView] as [String : Any]
        //Width & Horizontal Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[leagueButton]-2-[leagueDropDownButton(20)][spacerView][dateBackwardButton(20)]-[dateButton]-[dateForwardButton(20)]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        //Height & Vertical Alignment
        self.addConstraint(NSLayoutConstraint.init(item: self.leagueButton, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint.init(item: self.leagueDropDownButton, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint.init(item: self.leagueDropDownButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 20))
        self.addConstraint(NSLayoutConstraint.init(item: self.dateBackwardButton, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint.init(item: self.dateBackwardButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 20))
        self.addConstraint(NSLayoutConstraint.init(item: self.dateButton, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint.init(item: self.dateForwardButton, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint.init(item: self.dateForwardButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 20))
        self.addConstraint(NSLayoutConstraint.init(item: spacerView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    }
    
    func configure(league: String?, date: Date){
        self.leagueButton.setTitle(league, for: .normal)
        self.dateButton.setTitle(date.monthDayAndYear(), for: .normal)
    }
}

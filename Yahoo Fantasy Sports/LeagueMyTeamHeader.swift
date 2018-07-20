//
//  LeagueMyTeamHeader.swift
//  Yahoo Fantasy Sports
//
//  Created by Justin Wells on 7/18/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

class LeagueMyTeamHeader: UIView{
    
    var dateBackwardButton = UIButton()
    var dateButton = UIButton()
    var dateForwardButton = UIButton()
    var separatorView = UIView()
    
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
        
        //Setup Date Backward Button
        self.setupDateBackwardButton()
        
        //Setup Date Button
        self.setupDateButton()
        
        //Setup Date Foreward Button
        self.setupDateForwardButton()
        
        //Setup Separator View
        self.setupSeparatorView()
        
        //Setup Constraints
        self.setupConstraints()
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
    
    func setupSeparatorView(){
        self.separatorView.backgroundColor = .lightGray
        self.separatorView.isUserInteractionEnabled = false
        self.separatorView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.separatorView)
    }
    
    func setupConstraints(){
        let viewDict = ["dateBackwardButton": dateBackwardButton, "dateButton": dateButton, "dateForwardButton": dateForwardButton, "separatorView": separatorView] as [String : Any]
        //Width & Horizontal Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[dateBackwardButton(20)]-[dateButton]-[dateForwardButton(20)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[separatorView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        //Height & Vertical Alignment
        self.addConstraint(NSLayoutConstraint.init(item: self.dateBackwardButton, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint.init(item: self.dateBackwardButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 20))
        self.addConstraint(NSLayoutConstraint.init(item: self.dateButton, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint.init(item: self.dateForwardButton, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint.init(item: self.dateForwardButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 20))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[separatorView(0.5)]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
    }
    
    func configure(date: Date?){
        self.dateButton.setTitle("Week 1", for: .normal)
    }
}

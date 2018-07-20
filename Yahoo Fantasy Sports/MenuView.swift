//
//  MenuView.swift
//  Yahoo Fantasy Sports
//
//  Created by Justin Wells on 7/16/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

class MenuView: UIView{
    
    var menuHeaderView = MenuHeaderView()
    var topTableView = UITableView()
    var topTableViewHeightConstraint = NSLayoutConstraint()
    var bottomTableView = UITableView()
    var bottomTableViewHeightConstraint = NSLayoutConstraint()
    var dropDownTableView = UITableView()
    var dropDownTableViewTopConstraint = NSLayoutConstraint()
    
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
        
        //Setup Top TableView
        self.setupTopTableView()
        
        //Setup Bottom TableView
        self.setupBottomTableView()
        
        //Setup DropDown TableView
        self.setupDropDownTableView()
        
        //Setup Menu Header View
        self.setupMenuHeaderView()
        
        //Setup Constraints
        self.setupConstraints()
    }
    
    func setupTopTableView(){
        topTableView = UITableView(frame: CGRect.zero, style: .plain)
        topTableView.backgroundColor = .white
        topTableView.separatorInset = .zero
        topTableView.isScrollEnabled = false
        topTableView.showsVerticalScrollIndicator = false
        topTableView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(topTableView)
    }
    
    func setupBottomTableView(){
        bottomTableView = UITableView(frame: CGRect.zero, style: .grouped)
        bottomTableView.backgroundColor = .white
        bottomTableView.separatorStyle = .none
        bottomTableView.alwaysBounceVertical = true
        bottomTableView.showsVerticalScrollIndicator = false
        bottomTableView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(bottomTableView)
    }
    
    func setupDropDownTableView(){
        dropDownTableView = UITableView(frame: CGRect.zero, style: .plain)
        dropDownTableView.backgroundColor = .white
        dropDownTableView.separatorInset = .zero
        dropDownTableView.isScrollEnabled = false
        dropDownTableView.tableFooterView = UIView(frame: .zero)
        dropDownTableView.showsVerticalScrollIndicator = false
        dropDownTableView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(dropDownTableView)
    }
    
    func setupMenuHeaderView(){
        menuHeaderView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(menuHeaderView)
    }
    
    func setupConstraints(){
        let viewDict = ["menuHeaderView": menuHeaderView, "dropDownTableView": dropDownTableView, "topTableView": topTableView, "bottomTableView": bottomTableView] as [String : Any]
        //Width & Horizontal Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[menuHeaderView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[dropDownTableView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[topTableView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[bottomTableView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        //Height & Vertical Alignment
        self.addConstraint(NSLayoutConstraint.init(item: self.menuHeaderView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint.init(item: self.menuHeaderView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 120))
        self.addConstraint(NSLayoutConstraint.init(item: self.topTableView, attribute: .top, relatedBy: .equal, toItem: self.menuHeaderView, attribute: .bottom, multiplier: 1, constant: 0))
        self.topTableViewHeightConstraint = NSLayoutConstraint.init(item: self.topTableView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 50)
        self.addConstraint(self.topTableViewHeightConstraint)
        self.addConstraint(NSLayoutConstraint.init(item: self.bottomTableView, attribute: .top, relatedBy: .equal, toItem: self.topTableView, attribute: .bottom, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint.init(item: self.bottomTableView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0))
        self.bottomTableViewHeightConstraint = NSLayoutConstraint.init(item: self.bottomTableView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 1, constant: -170)
        self.addConstraint(self.bottomTableViewHeightConstraint)
        self.dropDownTableViewTopConstraint = NSLayoutConstraint.init(item: self.dropDownTableView, attribute: .top, relatedBy: .equal, toItem: self.menuHeaderView, attribute: .bottom, multiplier: 1, constant: -1000)
        self.addConstraint(self.dropDownTableViewTopConstraint)
        self.addConstraint(NSLayoutConstraint.init(item: self.dropDownTableView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 1, constant: -120))
    }
}

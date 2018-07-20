//
//  LeagueMyTeamView.swift
//  Yahoo Fantasy Sports
//
//  Created by Justin Wells on 7/17/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

class LeagueMyTeamView: UIView{
    
    var dateHeader = LeagueMyTeamHeader()
    var tableView = UITableView()
    var refreshControl = UIRefreshControl()
    
    public override init(frame: CGRect){
        super.init(frame: frame)
        //Setup View
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
        self.backgroundColor = YHColor.faintGray
        
        //Setup Date Header
        self.setupDateHeader()
        
        //Setup TableView
        self.setupTableView()
        
        //Setup Constraints
        self.setupConstraints()
    }
    
    func setupDateHeader(){
        self.dateHeader = LeagueMyTeamHeader()
        self.dateHeader.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.dateHeader)
    }
    
    func setupTableView(){
        tableView = UITableView(frame: CGRect.zero, style: .plain)
        tableView.backgroundColor = YHColor.faintGray
        tableView.separatorInset = .zero
        tableView.alwaysBounceVertical = true
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.showsVerticalScrollIndicator = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(tableView)
        
        //Setup RefreshControl
        self.refreshControl.tintColor = .lightGray
        self.refreshControl.layer.zPosition = -1
        self.tableView.addSubview(refreshControl)
    }
    
    func setupConstraints(){
        let viewDict = ["dateHeader": dateHeader, "tableView": tableView] as [String : Any]
        //Width & Horizontal Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[dateHeader]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[tableView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        //Height & Vertical Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[dateHeader(50)][tableView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
    }
}


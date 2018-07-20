//
//  DailyFantasyLobbyContestCell.swift
//  Yahoo Fantasy Sports
//
//  Created by Justin Wells on 7/17/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

protocol DailyFantasyLobbyContestCellDelegate {
    func didPressLobbyContestCell(indexPath: IndexPath)
    func didPressLobbyContestFooter(sender: UIButton)
}

class DailyFantasyLobbyContestCell: UICollectionViewCell, UITableViewDataSource, UITableViewDelegate{
    
    var dailyFantasyLobbyContestCellDelegate: DailyFantasyLobbyContestCellDelegate!
    var tableView = UITableView()
    var tableViewHeader = DailyLobbyFantasyContestTableHeader()
    var tableViewFooter = DailyLobbyFantasyContestTableFooter()
    private let cellIdentifier = "cell"
    
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
        
        //Setup TableView
        self.setupTableView()
        
        //Setup TableView Header
        self.setupTableViewHeader()
        
        //Setup TableView Footer
        self.setupTableViewFooter()
        
        //Setup Constraints
        self.setupConstraints()
    }
    
    func setupTableView(){
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.backgroundColor = .white
        self.tableView.isScrollEnabled = false
        self.tableView.separatorInset = .zero
        self.tableView.register(DailyFantasyLobbyContestTableCell.self, forCellReuseIdentifier: cellIdentifier)
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.tableView)
    }
    
    func setupTableViewHeader(){
        self.tableViewHeader.frame.size.height = 40
        self.tableView.tableHeaderView = self.tableViewHeader
    }
    
    func setupTableViewFooter(){
        self.tableViewFooter.addTarget(self, action: #selector(footerButtonPressed(sender:)), for: .touchUpInside)
        self.tableViewFooter.frame.size.height = 40
        self.tableView.tableFooterView = self.tableViewFooter
    }
    
    func setupConstraints(){
        let viewDict = ["tableView": tableView] as [String : Any]
        //Width & Horizontal Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[tableView]-16-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        //Height & Vertical Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[tableView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
    }
    
    func configure(){
        self.tableViewHeader.configure(image: UIImage(named: "footballLeague"), title: "NFL Contests")
        //self.tableView.reloadData()
    }
    
    //TableView DataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! DailyFantasyLobbyContestTableCell
        cell.configure()
        return cell
    }
    
    //TableView Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dailyFantasyLobbyContestCellDelegate.didPressLobbyContestCell(indexPath: indexPath)
    }
    
    //Button Delegate
    func footerButtonPressed(sender: UIButton){
        dailyFantasyLobbyContestCellDelegate.didPressLobbyContestFooter(sender: sender)
    }
}

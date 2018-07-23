//
//  LeaguePlayersTransactionTrendsCell.swift
//  Yahoo Fantasy Sports
//
//  Created by Justin Wells on 7/19/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

protocol LeaguePlayersTransactionTrendsCellDelegate {
    func didPressLeaguePlayersTransactionTrendsCell(indexPath: IndexPath)
}

class LeaguePlayersTransactionTrendsCell: UICollectionViewCell, UITableViewDataSource, UITableViewDelegate{
    
    var leaguePlayersTransactionTrendsCellDelegate: LeaguePlayersTransactionTrendsCellDelegate!
    var headerView = LeaguePlayersTableHeader()
    private let cellIdentifier = "cell"
    var tableView = UITableView()
    var players = [Player]()
    
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
        
        //Setup Header
        self.setupHeaderView()
        
        //Setup TableView
        self.setupTableView()
        
        //Setup Constraints
        self.setupConstraints()
    }
    
    func setupTableView(){
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.backgroundColor = .white
        self.tableView.isScrollEnabled = false
        self.tableView.separatorInset = .zero
        self.tableView.register(LeaguePlayersPlayerTableCell.self, forCellReuseIdentifier: cellIdentifier)
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.tableView)
    }
    
    func setupHeaderView(){
        self.headerView.configure(title: "transactionTrends".localized())
        self.headerView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.headerView)
    }
    
    func setupConstraints(){
        let viewDict = ["headerView": headerView, "tableView": tableView] as [String : Any]
        //Width & Horizontal Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[headerView]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[tableView]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        //Height & Vertical Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[headerView(40)][tableView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
    }
    
    func configure(players: [Player]){
        self.players = players//.prefix(3)
        self.tableView.reloadData()
    }
    
    //TableView DataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.players.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 18
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = LeaguePlayersSectionView()
        headerView.configure(titles: ["Adds", "Drops", "Trades", "Ownership"])
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! LeaguePlayersPlayerTableCell
        cell.configure(player: players[indexPath.row], rank: nil)
        return cell
    }
    
    //TableView Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        leaguePlayersTransactionTrendsCellDelegate.didPressLeaguePlayersTransactionTrendsCell(indexPath: indexPath)
    }
}

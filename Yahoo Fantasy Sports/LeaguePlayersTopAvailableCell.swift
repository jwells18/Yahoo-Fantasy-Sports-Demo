//
//  LeaguePlayersTopAvailableCell.swift
//  Yahoo Fantasy Sports
//
//  Created by Justin Wells on 7/19/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit
import HMSegmentedControl

protocol LeaguePlayersTopAvailableCellDelegate {
    func didChangeleaguePlayersTopAvailableSegmentedControl(segmentedControl: HMSegmentedControl)
    func didPressLeaguePlayersTopAvailableCell(indexPath: IndexPath)
}

class LeaguePlayersTopAvailableCell: UICollectionViewCell, UITableViewDataSource, UITableViewDelegate{
    
    var leaguePlayersTopAvailableCellDelegate: LeaguePlayersTopAvailableCellDelegate!
    private let cellIdentifier = "cell"
    var tableView = UITableView()
    var headerView = LeaguePlayersTableHeader()
    var segmentedControl = HMSegmentedControl()
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
        
        //Setup Header View
        self.setupHeaderView()
        
        //Setup Segmented Control
        self.setupSegmentedControl()
        
        //Setup TableView
        self.setupTableView()
        
        //Setup Constraints
        self.setupConstraints()
    }
    
    func setupSegmentedControl(){
        self.segmentedControl = HMSegmentedControl(sectionTitles: topAvailablePlayersSegmentedTitles)
        self.segmentedControl.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: 44)
        self.segmentedControl.selectionIndicatorHeight = 0
        self.segmentedControl.titleTextAttributes = [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 14), NSForegroundColorAttributeName: UIColor.darkGray]
        self.segmentedControl.selectedTitleTextAttributes = [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 14), NSForegroundColorAttributeName: UIColor.orange]
        self.segmentedControl.addTarget(self, action: #selector(segmentedControlChangedValue), for: .valueChanged)
        self.segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(segmentedControl)
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
        self.headerView.configure(title: "topAvailablePlayers".localized())
        self.headerView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.headerView)
    }
    
    func setupConstraints(){
        let viewDict = ["headerView": headerView, "segmentedControl": segmentedControl, "tableView": tableView] as [String : Any]
        //Width & Horizontal Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[headerView]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[segmentedControl]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[tableView]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        //Height & Vertical Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[headerView(40)][segmentedControl(40)][tableView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
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
        return players.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 18
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = LeaguePlayersSectionView()
        headerView.configure(titles: ["Proj Rank", "Proj Pts", "Adds", "% Own"])
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! LeaguePlayersPlayerTableCell
        cell.configure(player: players[indexPath.row], rank: indexPath.row)
        return cell
    }
    
    //TableView Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        leaguePlayersTopAvailableCellDelegate.didPressLeaguePlayersTopAvailableCell(indexPath: indexPath)
    }
    
    //Segmented Control Delegate
    func segmentedControlChangedValue(segmentedControl: HMSegmentedControl){
        leaguePlayersTopAvailableCellDelegate.didChangeleaguePlayersTopAvailableSegmentedControl(segmentedControl: segmentedControl)
    }
}

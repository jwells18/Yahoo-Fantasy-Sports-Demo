//
//  YHSettingsCollectionCell.swift
//  Yahoo Fantasy Sports
//
//  Created by Justin Wells on 7/19/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

protocol YHSettingsCollectionCellDelegate {
    func didPressSettingsCollectionTableCell(indexPath: IndexPath)
}

class YHSettingsCollectionCell: UICollectionViewCell, UITableViewDataSource, UITableViewDelegate{
    
    var settingsCollectionCellDelegate: YHSettingsCollectionCellDelegate!
    var tableView = UITableView()
    private let cellIdentifier = "cell"
    var items = [YHSettingsItem]()
    
    public override init(frame: CGRect){
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
        
        //Setup Constraints
        self.setupConstraints()
    }
    
    func setupTableView(){
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.backgroundColor = .white
        self.tableView.isScrollEnabled = false
        self.tableView.separatorInset = .zero
        self.tableView.tableFooterView = UIView(frame:  .zero)
        self.tableView.register(YHSettingsTableCustomCell.self, forCellReuseIdentifier: cellIdentifier)
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.tableView)
    }
    
    func setupConstraints(){
        let viewDict = ["tableView": tableView] as [String : Any]
        //Width & Horizontal Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[tableView]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        //Height & Vertical Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[tableView(100)]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
    }
    
    func configure(items: [YHSettingsItem]){
        self.items = items
        self.tableView.reloadData()
    }
    
    //TableView DataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! YHSettingsTableCustomCell
        cell.configure(item: items[indexPath.row])
        return cell
    }
    
    //TableView Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.settingsCollectionCellDelegate.didPressSettingsCollectionTableCell(indexPath: indexPath)
    }
}

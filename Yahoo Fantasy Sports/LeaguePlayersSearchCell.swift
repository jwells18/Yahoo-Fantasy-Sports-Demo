//
//  LeaguePlayersSearchCell.swift
//  Yahoo Fantasy Sports
//
//  Created by Justin Wells on 7/19/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

protocol LeaguePlayersSearchCellDelegate {
    func didPressSearchButton(sender: UIButton)
    func didPressFilterButton(sender: UIButton)
}

class LeaguePlayersSearchCell: UICollectionViewCell{
    
    var leaguePlayersSearchCellDelegate: LeaguePlayersSearchCellDelegate!
    var searchImageView = UIImageView()
    var searchButton = UIButton()
    var filterButton = UIButton()
    
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
        
        //Setup Search ImageView
        self.setupSearchImageView()
        
        //Setup SearchButton
        self.setupSearchButton()
        
        //Setup Filter Button
        self.setupFilterButton()
        
        //Setup Constraints
        self.setupConstraints()
    }
    
    func setupSearchImageView(){
        self.searchImageView.image = UIImage(named: "search")?.withRenderingMode(.alwaysTemplate)
        self.searchImageView.tintColor = .darkGray
        self.searchImageView.clipsToBounds = true
        self.searchImageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.searchImageView)
    }
    
    func setupSearchButton(){
        self.searchButton.setTitle("searchByPlayerName".localized(), for: .normal)
        self.searchButton.setTitleColor(.gray, for: .normal)
        self.searchButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        self.searchButton.contentHorizontalAlignment = .left
        self.searchButton.addTarget(self, action: #selector(searchButtonPressed(sender:)), for: .touchUpInside)
        self.searchButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.searchButton)
    }
    
    func setupFilterButton(){
        self.filterButton.setTitle("filter".localized(), for: .normal)
        self.filterButton.setTitleColor(YHColor.blue, for: .normal)
        self.filterButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        self.filterButton.addTarget(self, action: #selector(filterButtonPressed(sender:)), for: .touchUpInside)
        self.filterButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.filterButton)
    }
    
    func setupConstraints(){
        let viewDict = ["searchImageView": searchImageView, "searchButton": searchButton, "filterButton": filterButton] as [String : Any]
        //Width & Horizontal Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[searchImageView(20)]-[searchButton(>=100)][filterButton]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        //Height & Vertical Alignment
        self.addConstraints([NSLayoutConstraint.init(item: searchImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)])
        self.addConstraints([NSLayoutConstraint.init(item: searchImageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 20)])
        self.addConstraints([NSLayoutConstraint.init(item: searchButton, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)])
        self.addConstraints([NSLayoutConstraint.init(item: searchButton, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 1, constant: 0)])
        self.addConstraints([NSLayoutConstraint.init(item: filterButton, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)])
        self.addConstraints([NSLayoutConstraint.init(item: filterButton, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 1, constant: 0)])
    }
    
    //Button Delegates
    func searchButtonPressed(sender: UIButton){
        leaguePlayersSearchCellDelegate.didPressSearchButton(sender: sender)
    }
    
    func filterButtonPressed(sender: UIButton){
        leaguePlayersSearchCellDelegate.didPressFilterButton(sender: sender)
    }
}


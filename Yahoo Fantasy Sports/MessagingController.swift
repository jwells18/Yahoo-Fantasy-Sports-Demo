//
//  MessagingController.swift
//  Yahoo Fantasy Sports
//
//  Created by Justin Wells on 7/16/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

class MessagingController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate{
    
    private let cellIdentifier = "cell"
    private var messagingView = MessagingView()
    private var searchBar = UISearchBar()
    private var profileButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Setup NavigationBar
        self.setupNavigationBar()
        
        //Setup View
        self.setupView()
    }
    
    func setupNavigationBar(){
        //Setup Navigation Items
        self.searchBar.delegate = self
        self.searchBar.backgroundImage = nil
        self.searchBar.backgroundColor = .clear
        self.searchBar.barTintColor = .clear
        self.searchBar.placeholder = "search".localized()
        self.navigationItem.titleView = self.searchBar
        
        let backBtn = YHBarButton(image: UIImage(named: "backward"))
        backBtn.addTarget(self, action: #selector(self.backButtonPressed(sender:)), for: .touchUpInside)
        let backButton = UIBarButtonItem(customView: backBtn)
        self.navigationItem.leftBarButtonItem = backButton
        
        let profileBtn = YHBarButton(image: UIImage(named: "profile1"))
        profileBtn.addTarget(self, action: #selector(self.profileButtonPressed(sender:)), for: .touchUpInside)
        self.profileButton = UIBarButtonItem(customView: profileBtn)
        self.navigationItem.rightBarButtonItem = self.profileButton
    }
    
    func setupView(){
        self.view.backgroundColor = YHColor.darkPurple
        
        //Setup Messaging View
        self.setupMessagingView()
        
        //SetupConstraints
        self.setupConstraints()
    }
    
    func setupMessagingView(){
        self.messagingView.tableView.dataSource = self
        self.messagingView.tableView.delegate = self
        self.messagingView.tableView.register(MessagingViewCell.self, forCellReuseIdentifier: cellIdentifier)
        self.messagingView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(messagingView)
    }
    
    func setupConstraints(){
        let viewDict = ["messagingView": messagingView] as [String : Any]
        //Width & Horizontal Alignment
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[messagingView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        //Height & Vertical Alignment
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[messagingView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
    }
    
    //TableView DataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! MessagingViewCell
        cell.configure()
        return cell
    }
    
    //TableView Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Show Feature Unavailable
        self.present(featureUnavailableAlert(), animated: true, completion: nil)
    }
    
    //UISearchBar Delegate
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        self.navigationItem.rightBarButtonItem = nil
        self.searchBar.showsCancelButton = true
        return true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.navigationItem.rightBarButtonItem = profileButton
        self.searchBar.showsCancelButton = false
        self.searchBar.resignFirstResponder()
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        self.navigationItem.rightBarButtonItem = profileButton
        self.searchBar.showsCancelButton = false
        return true
    }
    
    //Button Delegates
    func backButtonPressed(sender: UIButton){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let pageViewController = appDelegate.pageViewController
        let pageViewControllers = appDelegate.pageViewControllers
        pageViewController.setViewControllers([pageViewControllers[1]], direction: .reverse, animated: true, completion: nil)
    }
    
    func profileButtonPressed(sender: UIButton){
        //Show Feature Unavailable
        self.present(featureUnavailableAlert(), animated: true, completion: nil)
    }
}

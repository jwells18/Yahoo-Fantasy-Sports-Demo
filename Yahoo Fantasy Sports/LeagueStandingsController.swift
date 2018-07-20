//
//  LeagueStandingsController.swift
//  Yahoo Fantasy Sports
//
//  Created by Justin Wells on 7/16/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

class LeagueStandingsController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    var navigationTitleView = YHDetailTitleView()
    var standingsView = LeagueStandingsView()
    private let advertisementCellIdentifier = "advertisementCell"
    private let standingsCellIdentifier = "standingsCell"
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        self.tabBarItem.title = "standings".localized()
        self.tabBarItem.image = UIImage(named: "standings")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Setup NavigationBar
        self.setupNavigationBar()
        
        //Setup View
        self.setupView()
    }
    
    func setupNavigationBar(){
        //Setup Navigation Items
        self.navigationTitleView.frame = CGRect(x: 0, y: 0, width: 200, height: 44)
        self.navigationTitleView.configure(title: "Morgan Stanley Team", subTitle: "LA Accountants League")
        self.navigationItem.titleView = self.navigationTitleView
        
        let homeBtn = YHBarButton(image: UIImage(named: "home"))
        homeBtn.addTarget(self, action: #selector(self.homeButtonPressed(sender:)), for: .touchUpInside)
        let homeButton = UIBarButtonItem(customView: homeBtn)
        let dailyFantasyBtn = YHBarButton(image: UIImage(named: "dailyFantasyLogo"))
        dailyFantasyBtn.addTarget(self, action: #selector(self.dailyFantasyButtonPressed(sender:)), for: .touchUpInside)
        let dailyFantasyButton = UIBarButtonItem(customView: dailyFantasyBtn)
        self.navigationItem.leftBarButtonItems = [homeButton, dailyFantasyButton]
        
        let spacingBtn = YHBarButton()
        let spacingButton = UIBarButtonItem(customView: spacingBtn)
        let messageBtn = YHBarButton(image: UIImage(named: "message"))
        messageBtn.addTarget(self, action: #selector(self.messageButtonPressed(sender:)), for: .touchUpInside)
        let messageButton = UIBarButtonItem(customView: messageBtn)
        self.navigationItem.rightBarButtonItems = [messageButton, spacingButton]
    }
    
    func setupView(){
        self.view.backgroundColor = YHColor.faintGray
        
        //Setup Standings View
        self.setupStandingsView()
        
        //Setup Constraints
        self.setupConstraints()
    }
    
    func setupStandingsView(){
        self.standingsView.tableView.dataSource = self
        self.standingsView.tableView.delegate = self
        self.standingsView.tableView.register(YHAdvertisementTableCell.self, forCellReuseIdentifier: advertisementCellIdentifier)
        self.standingsView.tableView.register(LeagueStandingsCell.self, forCellReuseIdentifier: standingsCellIdentifier)
        self.standingsView.refreshControl.addTarget(self, action: #selector(self.refreshData), for: .valueChanged)
        self.standingsView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(standingsView)
    }
    
    func setupConstraints(){
        let viewDict = ["standingsView": standingsView] as [String : Any]
        //Width & Horizontal Alignment
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[standingsView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        //Height & Vertical Alignment
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[standingsView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
    }
    
    //Data
    func downloadData(){
        
    }
    
    func refreshData(){
        
    }
    
    //TableView DataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row{
        case 0:
            return 70
        case 1:
            return 50
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row{
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: advertisementCellIdentifier, for: indexPath) as! YHAdvertisementTableCell
            cell.configure()
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: standingsCellIdentifier, for: indexPath) as! LeagueStandingsCell
            cell.configure()
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: advertisementCellIdentifier, for: indexPath) as! YHAdvertisementTableCell
            cell.configure()
            return cell
        }
    }
    
    //TableView Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Show Feature Unavailable
        self.present(featureUnavailableAlert(), animated: true, completion: nil)
    }
    
    //Button Delegates
    func homeButtonPressed(sender: UIButton){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let pageViewController = appDelegate.pageViewController
        let pageViewControllers = appDelegate.pageViewControllers
        pageViewController.setViewControllers([pageViewControllers[0]], direction: .reverse, animated: true, completion: nil)
    }
    
    func dailyFantasyButtonPressed(sender: UIButton){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let pageViewController = appDelegate.pageViewController
        appDelegate.pageViewControllers.remove(at: 1)
        let dailyFantasyVC = appDelegate.setupDailyFantasyController()
        appDelegate.pageViewControllers.insert(dailyFantasyVC, at: 1)
        pageViewController.setViewControllers([appDelegate.pageViewControllers[1]], direction: .forward, animated: false, completion: nil)
    }
    
    func messageButtonPressed(sender: UIButton){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let pageViewController = appDelegate.pageViewController
        let pageViewControllers = appDelegate.pageViewControllers
        pageViewController.setViewControllers([pageViewControllers[2]], direction: .forward, animated: true, completion: nil)
    }
}

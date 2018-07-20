//
//  LeagueMyTeamController.swift
//  Yahoo Fantasy Sports
//
//  Created by Justin Wells on 7/16/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

class LeagueMyTeamController: UIViewController, UITableViewDataSource, UITableViewDelegate, LeagueMyTeamSummaryCellDelegate, YHSettingsTableCellDelegate{
    
    var navigationTitleView = YHDetailTitleView()
    var myTeamView = LeagueMyTeamView()
    private let summaryCellIdentifier = "summaryCell"
    private let draftTypeCellIdentifier = "draftTypeCell"
    private let settingsCellIdentifier = "settingsCell"
    private let advertisementCellIdentifier = "advertisementCell"
    private let playerCellIdentifier = "playerCell"

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        self.tabBarItem.title = "myTeam".localized()
        self.tabBarItem.image = UIImage(named: "myTeam")
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
        
        //Setup My Team View
        self.setupMyTeamView()
        
        //Setup Constraints
        self.setupConstraints()
    }
    
    func setupMyTeamView(){
        self.myTeamView.dateHeader.configure(date: nil)
        self.myTeamView.dateHeader.dateBackwardButton.addTarget(self, action: #selector(dateBackwardButtonPressed(sender:)), for: .touchUpInside)
        self.myTeamView.dateHeader.dateButton.addTarget(self, action: #selector(dateButtonPressed(sender:)), for: .touchUpInside)
        self.myTeamView.dateHeader.dateForwardButton.addTarget(self, action: #selector(dateForwardButtonPressed(sender:)), for: .touchUpInside)
        self.myTeamView.tableView.dataSource = self
        self.myTeamView.tableView.delegate = self
        self.myTeamView.tableView.estimatedRowHeight = 50
        self.myTeamView.tableView.rowHeight = UITableViewAutomaticDimension
        self.myTeamView.tableView.register(LeagueMyTeamSummaryCell.self, forCellReuseIdentifier: summaryCellIdentifier)
        self.myTeamView.tableView.register(LeagueMyTeamDraftTypeCell.self, forCellReuseIdentifier: draftTypeCellIdentifier)
        self.myTeamView.tableView.register(YHSettingsTableCell.self, forCellReuseIdentifier: settingsCellIdentifier)
        self.myTeamView.tableView.register(YHAdvertisementTableCell.self, forCellReuseIdentifier: advertisementCellIdentifier)
        self.myTeamView.tableView.register(LeagueMyTeamPlayerCell.self, forCellReuseIdentifier: playerCellIdentifier)
        self.myTeamView.refreshControl.addTarget(self, action: #selector(self.refreshData), for: .valueChanged)
        self.myTeamView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(myTeamView)
    }
    
    func setupConstraints(){
        let viewDict = ["myTeamView": myTeamView] as [String : Any]
        //Width & Horizontal Alignment
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[myTeamView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        //Height & Vertical Alignment
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[myTeamView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
    }
    
    //Data
    func downloadData(){
        
    }
    
    func refreshData(){
        
    }
    
    //TableView DataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch  section {
        case 0:
            return 4
        case 1:
            return 7
        case 2:
            return 1
        case 3:
            return 1
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch  section {
        case 0:
            return 0
        default:
            return 18
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch  section {
        case 0:
            return nil
        default:
            let sectionHeader = LeagueMyTeamPlayerSectionView()
            sectionHeader.configure(title: "Offense")
            return sectionHeader
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch  indexPath.section {
        case 0:
            switch indexPath.row{
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: summaryCellIdentifier, for: indexPath) as! LeagueMyTeamSummaryCell
                cell.leagueMyTeamSummaryCellDelegate = self
                cell.configure(league: nil)
                return cell
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: draftTypeCellIdentifier, for: indexPath) as! LeagueMyTeamDraftTypeCell
                cell.configure(title: "Offline draft")
                return cell
            case 2:
                let cell = tableView.dequeueReusableCell(withIdentifier: settingsCellIdentifier, for: indexPath) as! YHSettingsTableCell
                cell.settingsTableCellDelegate = self
                cell.configure(items: leagueMyTeamSettingsItems)
                return cell
            case 3:
                let cell = tableView.dequeueReusableCell(withIdentifier: advertisementCellIdentifier, for: indexPath) as! YHAdvertisementTableCell
                cell.configure()
                return cell
            default:
                let cell = tableView.dequeueReusableCell(withIdentifier: summaryCellIdentifier, for: indexPath) as! LeagueMyTeamSummaryCell
                cell.configure(league: nil)
                return cell
            }
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: playerCellIdentifier, for: indexPath) as! LeagueMyTeamPlayerCell
            cell.configure(image: nil, title: "Empty")
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
    
    func dateBackwardButtonPressed(sender: UIButton){
        //Show Feature Unavailable
        self.present(featureUnavailableAlert(), animated: true, completion: nil)
    }
    
    func dateButtonPressed(sender: UIButton){
        //Show Feature Unavailable
        self.present(featureUnavailableAlert(), animated: true, completion: nil)
    }
    
    func dateForwardButtonPressed(sender: UIButton){
        //Show Feature Unavailable
        self.present(featureUnavailableAlert(), animated: true, completion: nil)
    }
    
    func didPressMyTeamEditButton(sender: UIButton){
        //Show Feature Unavailable
        self.present(featureUnavailableAlert(), animated: true, completion: nil)
    }
    
    func didPressSettingsTableCell(indexPath: IndexPath){
        //Show Feature Unavailable
        self.present(featureUnavailableAlert(), animated: true, completion: nil)
    }
}

//
//  DailyFantasyLobbyController.swift
//  Yahoo Fantasy Sports
//
//  Created by Justin Wells on 7/16/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit
import HMSegmentedControl

class DailyFantasyLobbyController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, DailyFantasyLobbyContestCellDelegate{
    
    var currentDBUser: DBUser!
    private let contestCellIdentifier = "contestCell"
    private let createContestCellIdentifier = "createContestCell"
    private let disclaimerCellIdentifier = "disclaimerCell"
    private let leaguesCellIdentifier = "leaguesCell"
    private var navigationTitleView = YHDetailTitleView()
    private var lobbyView = DailyFantasyLobbyView()
    private var isInitialContestsDownload = true
    private var isInitialLeaguesDownload = true
    private var dailyFantasyContests = [[DailyFantasyContest]]()
    private var dailyFantasyLeagues = [DailyFantasyLeague]()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        self.tabBarItem.title = "lobby".localized()
        self.tabBarItem.image = UIImage(named: "lobby")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Set Current Employee
        let userManager = UserManager()
        self.currentDBUser = userManager.getCurrentDBUser()
        
        //Setup NavigationBar
        self.setupNavigationBar()
        
        //Setup View
        self.setupView()
        
        //Download Data
        self.downloadData()
    }
    
    func setupNavigationBar(){
        //Setup Navigation Items
        self.navigationTitleView.frame = CGRect(x: 0, y: 0, width: 200, height: 44)
        self.navigationTitleView.configure(title: "dailyFantasy".localized(), subTitle: String(format: "%@: %@", "balance".localized(), "$0.00"))
        self.navigationItem.titleView = self.navigationTitleView
        
        let homeBtn = YHBarButton(image: UIImage(named: "home"))
        homeBtn.addTarget(self, action: #selector(self.homeButtonPressed(sender:)), for: .touchUpInside)
        let homeButton = UIBarButtonItem(customView: homeBtn)
        self.navigationItem.leftBarButtonItem = homeButton
        
        let messageBtn = YHBarButton(image: UIImage(named: "message"))
        messageBtn.addTarget(self, action: #selector(self.messageButtonPressed(sender:)), for: .touchUpInside)
        let messageButton = UIBarButtonItem(customView: messageBtn)
        self.navigationItem.rightBarButtonItem = messageButton
    }
    
    func setupView(){
        self.view.backgroundColor = YHColor.faintGray
        
        //Setup Lobby View
        self.setupLobbyView()
        
        //Setup Constraints
        self.setupConstraints()
    }
    
    func setupLobbyView(){
        self.lobbyView.headerView.configure(user: self.currentDBUser)
        self.lobbyView.headerView.userButton.addTarget(self, action: #selector(headerUserButtonPressed(sender:)), for: .touchUpInside)
        self.lobbyView.headerView.segmentedControl.addTarget(self, action: #selector(segmentedControlChangedValue), for: .valueChanged)
        self.lobbyView.collectionView.dataSource = self
        self.lobbyView.collectionView.delegate = self
        self.lobbyView.collectionView.register(DailyFantasyLobbyContestCell.self, forCellWithReuseIdentifier: contestCellIdentifier)
        self.lobbyView.collectionView.register(DailyFantasyLobbyCreateContestCell.self, forCellWithReuseIdentifier: createContestCellIdentifier)
        self.lobbyView.collectionView.register(DailyFantasyLobbyDisclaimerCell.self, forCellWithReuseIdentifier: disclaimerCellIdentifier)
        self.lobbyView.collectionView.register(DailyFantasyLobbyLeaguesCell.self, forCellWithReuseIdentifier: leaguesCellIdentifier)
        self.lobbyView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.lobbyView)
    }
    
    func setupConstraints(){
        let viewDict = ["lobbyView": lobbyView] as [String : Any]
        //Width & Horizontal Alignment
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[lobbyView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        //Height & Vertical Alignment
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[lobbyView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
    }
    
    func downloadData(){
        switch lobbyView.headerView.segmentedControl.selectedSegmentIndex{
        case 0:
            switch isInitialContestsDownload{
            case true:
                self.downloadContestsData()
            case false:
                self.lobbyView.collectionView.reloadData()
            }
            break
        case 1:
            switch isInitialLeaguesDownload{
            case true:
                self.downloadLeaguesData()
            case false:
                self.lobbyView.collectionView.reloadData()
            }
            break
        default:
            break
        }
    }
    
    func downloadContestsData(){
        //Start Downloading ActivityView
        if isInitialContestsDownload{
            self.lobbyView.downloadingActivityView.startAnimating()
        }
        
        //Change Initial Download Bool
        isInitialContestsDownload = false
        
        let dailyFantasyManager = DailyFantasyManager()
        dailyFantasyManager.downloadDailyFantasyContests { (dailyFantasyContests) in
            
            //Stop Downloading ActivityView
            if(self.lobbyView.downloadingActivityView.isAnimating){
                self.lobbyView.downloadingActivityView.stopAnimating()
            }
            
            self.dailyFantasyContests = dailyFantasyContests
            
            //Show Empty View (if necessary)
            if self.dailyFantasyContests.count > 0{
                self.lobbyView.collectionView.backgroundView = nil
            }
            else{
                let emptyView = YHEmptyView(image: UIImage(), title: "Empty", tabBarHeight: self.tabBarController?.tabBar.frame.height)
                self.lobbyView.collectionView.backgroundView = emptyView
            }
            
            self.lobbyView.collectionView.reloadData()
        }
    }
    
    func downloadLeaguesData(){
        //Start Downloading ActivityView
        if isInitialLeaguesDownload{
            self.lobbyView.downloadingActivityView.startAnimating()
        }
        
        //Change Initial Download Bool
        isInitialLeaguesDownload = false
        
        let dailyFantasyManager = DailyFantasyManager()
        dailyFantasyManager.downloadDailyFantasyLeagues { (dailyFantasyLeagues) in
            
            //Stop Downloading ActivityView
            if(self.lobbyView.downloadingActivityView.isAnimating){
                self.lobbyView.downloadingActivityView.stopAnimating()
            }
            
            self.dailyFantasyLeagues = dailyFantasyLeagues
            print("daily leagues \(self.dailyFantasyLeagues)")
            //Show Empty View (if necessary)
            if self.dailyFantasyLeagues.count > 0{
                self.lobbyView.collectionView.backgroundView = nil
            }
            else{
                let emptyView = YHEmptyView(image: UIImage(), title: "Empty", tabBarHeight: self.tabBarController?.tabBar.frame.height)
                self.lobbyView.collectionView.backgroundView = emptyView
            }
            
            self.lobbyView.collectionView.reloadData()
        }
    }
    
    //CollectionView DataSource
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch lobbyView.headerView.segmentedControl.selectedSegmentIndex{
        case 0:
            switch self.dailyFantasyContests.count > 0{
            case true:
                return self.dailyFantasyContests.count+2
            case false:
                return 0
            }
        case 1:
            return self.dailyFantasyLeagues.count
        default:
            return 0
        }
    }
    
    func collectionView (_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        switch lobbyView.headerView.segmentedControl.selectedSegmentIndex{
        case 0:
            switch indexPath.item{
            case _ where indexPath.item <= self.dailyFantasyContests.count-1:
                return CGSize(width: collectionView.frame.width-16, height: 220)
            case _ where indexPath.item == self.dailyFantasyContests.count:
                return CGSize(width: collectionView.frame.width-16, height: 50)
            case _ where indexPath.item == self.dailyFantasyContests.count+1:
                return CGSize(width: collectionView.frame.width-16, height: 80)
            default:
                return .zero
            }
        case 1:
            return CGSize(width: collectionView.frame.width-16, height: 94)
        default:
            return .zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch lobbyView.headerView.segmentedControl.selectedSegmentIndex{
        case 0:
            switch indexPath.item{
            case _ where indexPath.item <= self.dailyFantasyContests.count-1:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: contestCellIdentifier, for: indexPath) as! DailyFantasyLobbyContestCell
                cell.dailyFantasyLobbyContestCellDelegate = self
                cell.configure(contests: dailyFantasyContests[indexPath.row])
                return cell
            case _ where indexPath.item == self.dailyFantasyContests.count:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: createContestCellIdentifier, for: indexPath) as! DailyFantasyLobbyCreateContestCell
                return cell
            case _ where indexPath.item == self.dailyFantasyContests.count+1:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: disclaimerCellIdentifier, for: indexPath) as! DailyFantasyLobbyDisclaimerCell
                return cell
            default:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: createContestCellIdentifier, for: indexPath) as! DailyFantasyLobbyCreateContestCell
                return cell
            }
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: leaguesCellIdentifier, for: indexPath) as! DailyFantasyLobbyLeaguesCell
            cell.configure(league: dailyFantasyLeagues[indexPath.row])
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: createContestCellIdentifier, for: indexPath) as! DailyFantasyLobbyCreateContestCell
            return cell
        }
    }
    
    //CollectionViewCell Delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //Show Feature Unavailable
        self.present(featureUnavailableAlert(), animated: true, completion: nil)
    }
    
    func didPressLobbyContestCell(indexPath: IndexPath) {
        //Show Feature Unavailable
        self.present(featureUnavailableAlert(), animated: true, completion: nil)
    }
    
    func didPressLobbyContestFooter(sender: UIButton) {
        //let touchPoint = sender.convert(CGPoint.zero, to: collectionView)
        //let indexPath = collectionView.indexPathForItem(at: touchPoint)
        //Show Feature Unavailable
        self.present(featureUnavailableAlert(), animated: true, completion: nil)
    }
    
    //Segmented Control Delegate
    func segmentedControlChangedValue(segmentedControl: HMSegmentedControl){
        self.downloadData()
    }
    
    //Button Delegates
    func homeButtonPressed(sender: UIButton){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let pageViewController = appDelegate.pageViewController
        let homeVC = HomeController()
        let navVC = HomeNavigationController.init(rootViewController: homeVC)
        pageViewController.setViewControllers([navVC], direction: .reverse, animated: true, completion: nil)
    }
    
    func messageButtonPressed(sender: UIButton){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let pageViewController = appDelegate.pageViewController
        let messagingVC = MessagingController()
        let navVC = MessagingNavigationController.init(rootViewController: messagingVC)
        pageViewController.setViewControllers([navVC], direction: .forward, animated: true, completion: nil)
    }
    
    func headerUserButtonPressed(sender: UIButton){
        //Show Feature Unavailable
        self.present(featureUnavailableAlert(), animated: true, completion: nil)
    }
}

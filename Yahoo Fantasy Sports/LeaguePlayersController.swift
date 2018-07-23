//
//  LeaguePlayersController.swift
//  Yahoo Fantasy Sports
//
//  Created by Justin Wells on 7/16/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit
import HMSegmentedControl

class LeaguePlayersController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, YHNavigationCollectionHeaderDelegate, LeaguePlayersSearchCellDelegate, LeaguePlayersTopAvailableCellDelegate, LeaguePlayersTransactionTrendsCellDelegate{
    
    var team: DBTeam!
    var navigationTitleView = YHDetailTitleView()
    var playersView = LeaguePlayersView()
    private let headerCellIdentifier = "headerCell"
    private let searchCellIdentifier = "searchCell"
    private let advertisementCellIdentifier = "advertisementCell"
    private let topAvailableCellIdentifier = "topAvailableCell"
    private let transactionTrendsCellIdentifier = "transactionTrendsCell"
    var isInitialDownload = true
    var topAvailablePlayers = [Player]()
    var transactionTrendsPlayers = [Player]()
    
    convenience init(team: DBTeam) {
        self.init()
        self.team = team
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        self.tabBarItem.title = "players".localized()
        self.tabBarItem.image = UIImage(named: "players")
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
        
        //Download Data
        self.downloadData()
    }
    
    func setupNavigationBar(){
        //Setup Navigation Items
        self.navigationTitleView.frame = CGRect(x: 0, y: 0, width: 200, height: 44)
        self.navigationTitleView.configure(title: String(format: "%@ %@", team.name, "team".localized()), subTitle: String(format: "%@ %@", team.leagueName, "league".localized()))
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
        
        //Setup Players View
        self.setupPlayersView()
        
        //Setup Constraints
        self.setupConstraints()
    }
    
    //Setup Players View
    func setupPlayersView(){
        self.playersView.collectionView.dataSource = self
        self.playersView.collectionView.delegate = self
        self.playersView.collectionView.register(YHNavigationCollectionHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerCellIdentifier)
        self.playersView.collectionView.register(LeaguePlayersSearchCell.self, forCellWithReuseIdentifier: searchCellIdentifier)
        self.playersView.collectionView.register(YHAdvertisementCollectionCell.self, forCellWithReuseIdentifier: advertisementCellIdentifier)
        self.playersView.collectionView.register(LeaguePlayersTopAvailableCell.self, forCellWithReuseIdentifier: topAvailableCellIdentifier)
        self.playersView.collectionView.register(LeaguePlayersTransactionTrendsCell.self, forCellWithReuseIdentifier: transactionTrendsCellIdentifier)
        self.playersView.refreshControl.addTarget(self, action: #selector(self.refreshData), for: .valueChanged)
        self.playersView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.playersView)
    }
    
    func setupConstraints(){
        let viewDict = ["playersView": playersView] as [String : Any]
        //Width & Horizontal Alignment
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[playersView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        //Height & Vertical Alignment
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[playersView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
    }
    
    //Data
    func downloadData(){
        //Start Downloading ActivityView
        if isInitialDownload{
            self.playersView.downloadingActivityView.startAnimating()
        }
        
        //Change Initial Download Bool
        isInitialDownload = false
        
        let playerManager = PlayerManager()
        playerManager.downloadTopAvailablePlayers { (players) in

            self.topAvailablePlayers = players
            
            playerManager.downloadTransactionTrendsPlayers(completionHandler: { (players) in
                //Stop Downloading ActivityView
                if(self.playersView.downloadingActivityView.isAnimating){
                    self.playersView.downloadingActivityView.stopAnimating()
                }
                
                self.transactionTrendsPlayers = players
                /*
                //TODO: Show Empty View (if necessary)
                if self.topAvailablePlayers.count > 0{
                    self.playersView.collectionView.backgroundView = nil
                }
                else{
                    let emptyView = YHEmptyView(image: UIImage(), title: "Empty", tabBarHeight: self.tabBarController?.tabBar.frame.height)
                    self.playersView.collectionView.backgroundView = emptyView
                }*/
                
                self.playersView.refreshControl.endRefreshing()
                self.playersView.collectionView.reloadData()
            })
        }
    }
    
    func refreshData(){
        downloadData()
    }
    
    //CollectionView DataSource
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        var reusableView : UICollectionReusableView? = nil
        
        //Setup Search Results Header
        if (kind == UICollectionElementKindSectionHeader) {
            let headerView: YHNavigationCollectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerCellIdentifier, for: indexPath as IndexPath) as! YHNavigationCollectionHeader
            headerView.configure(items: leaguePlayersNavigationItems)
            headerView.navigationCollectionHeaderDelegate = self
            reusableView = headerView
        }
        return reusableView!
    }
    
    func collectionView (_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        switch indexPath.row{
        case 0:
            return CGSize(width: collectionView.frame.width-16, height: 60)
        case 1:
            return CGSize(width: collectionView.frame.width-16, height: 70)
        case 2:
            return CGSize(width: collectionView.frame.width-16, height: 278)
        case 3:
            return CGSize(width: collectionView.frame.width-16, height: 238)
        default:
            return CGSize(width: collectionView.frame.width-16, height: 70)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.row{
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: searchCellIdentifier, for: indexPath) as! LeaguePlayersSearchCell
            cell.leaguePlayersSearchCellDelegate = self
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: advertisementCellIdentifier, for: indexPath) as! YHAdvertisementCollectionCell
            cell.configure()
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: topAvailableCellIdentifier, for: indexPath) as! LeaguePlayersTopAvailableCell
            cell.leaguePlayersTopAvailableCellDelegate = self
            cell.configure(players: self.topAvailablePlayers)
            return cell
        case 3:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: transactionTrendsCellIdentifier, for: indexPath) as! LeaguePlayersTransactionTrendsCell
            cell.leaguePlayersTransactionTrendsCellDelegate = self
            cell.configure(players: self.transactionTrendsPlayers)
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: advertisementCellIdentifier, for: indexPath) as! YHAdvertisementCollectionCell
            cell.configure()
            return cell
        }
    }
    
    //CollectionViewCell Delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //Show Feature Unavailable
        self.present(featureUnavailableAlert(), animated: true, completion: nil)
    }
    
    func didPressNavigationCollectionHeader(indexPath: IndexPath){
        //Show Feature Unavailable
        self.present(featureUnavailableAlert(), animated: true, completion: nil)
    }
    
    func didPressLeaguePlayersTopAvailableCell(indexPath: IndexPath) {
        //Show Feature Unavailable
        self.present(featureUnavailableAlert(), animated: true, completion: nil)
    }
    
    func didChangeleaguePlayersTopAvailableSegmentedControl(segmentedControl: HMSegmentedControl){
        //TODO: Update Data
    }
    
    func didPressLeaguePlayersTransactionTrendsCell(indexPath: IndexPath) {
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
    
    func didPressSearchButton(sender: UIButton) {
        //Show Feature Unavailable
        self.present(featureUnavailableAlert(), animated: true, completion: nil)
    }
    
    func didPressFilterButton(sender: UIButton) {
        //Show Feature Unavailable
        self.present(featureUnavailableAlert(), animated: true, completion: nil)
    }
}

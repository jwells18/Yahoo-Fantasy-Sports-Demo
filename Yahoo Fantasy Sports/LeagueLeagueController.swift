//
//  LeagueLeagueController.swift
//  Yahoo Fantasy Sports
//
//  Created by Justin Wells on 7/16/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

class LeagueLeagueController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, YHNavigationCollectionHeaderDelegate, YHSettingsCollectionCellDelegate, LeagueLeagueInviteCellDelegate{
    
    var team: DBTeam!
    var navigationTitleView = YHDetailTitleView()
    var leagueView = LeagueLeagueView()
    private let headerCellIdentifier = "headerCell"
    private let advertisementCellIdentifier = "advertisementCell"
    private let inviteCellIdentifier = "inviteCell"
    private let settingsCellIdentifier = "settingsCell"
    
    convenience init(team: DBTeam) {
        self.init()
        self.team = team
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        self.tabBarItem.title = "league".localized()
        self.tabBarItem.image = UIImage(named: "league")
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
        
        //Setup League View
        self.setupLeagueView()
        
        //Setup Constraints
        self.setupConstraints()
    }
    
    //Setup League View
    func setupLeagueView(){
        self.leagueView.collectionView.dataSource = self
        self.leagueView.collectionView.delegate = self
        self.leagueView.collectionView.register(YHNavigationCollectionHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerCellIdentifier)
        self.leagueView.collectionView.register(YHAdvertisementCollectionCell.self, forCellWithReuseIdentifier: advertisementCellIdentifier)
        self.leagueView.collectionView.register(LeagueLeagueInviteCell.self, forCellWithReuseIdentifier: inviteCellIdentifier)
        self.leagueView.collectionView.register(YHSettingsCollectionCell.self, forCellWithReuseIdentifier: settingsCellIdentifier)
        self.leagueView.refreshControl.addTarget(self, action: #selector(self.refreshData), for: .valueChanged)
        self.leagueView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.leagueView)
    }
    
    func setupConstraints(){
        let viewDict = ["leagueView": leagueView] as [String : Any]
        //Width & Horizontal Alignment
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[leagueView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        //Height & Vertical Alignment
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[leagueView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
    }
    
    //Data
    func downloadData(){
        //TODO: download data
    }
    
    func refreshData(){
        self.leagueView.refreshControl.endRefreshing()
    }
    
    //CollectionView DataSource
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        var reusableView : UICollectionReusableView? = nil
        
        //Setup Search Results Header
        if (kind == UICollectionElementKindSectionHeader) {
            let headerView: YHNavigationCollectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerCellIdentifier, for: indexPath as IndexPath) as! YHNavigationCollectionHeader
            headerView.configure(items: leagueLeagueNavigationItems)
            headerView.navigationCollectionHeaderDelegate = self
            reusableView = headerView
        }
        return reusableView!
    }
    
    func collectionView (_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        switch indexPath.item{
        case 0:
            return CGSize(width: collectionView.frame.width-16, height: 70)
        case 1:
            return CGSize(width: collectionView.frame.width-16, height: 226.5)
        case 2:
            return CGSize(width: collectionView.frame.width-16, height: 100)
        default:
            return CGSize(width: collectionView.frame.width-16, height: 70)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.item{
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: advertisementCellIdentifier, for: indexPath) as! YHAdvertisementCollectionCell
            cell.configure()
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: inviteCellIdentifier, for: indexPath) as! LeagueLeagueInviteCell
            cell.leagueLeagueInviteCellDelegate = self
            cell.configure()
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: settingsCellIdentifier, for: indexPath) as! YHSettingsCollectionCell
            cell.settingsCollectionCellDelegate = self
            cell.configure(items: leagueLeagueSettingsItems)
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
    
    func didPressCopyButton(sender: UIButton) {
        //Show Feature Unavailable
        self.present(featureUnavailableAlert(), animated: true, completion: nil)
    }
    
    func didPressShareButton(sender: UIButton) {
        //Show Feature Unavailable
        self.present(featureUnavailableAlert(), animated: true, completion: nil)
    }
    
    func didPressSettingsCollectionTableCell(indexPath: IndexPath) {
        //Show Feature Unavailable
        self.present(featureUnavailableAlert(), animated: true, completion: nil)
    }
}

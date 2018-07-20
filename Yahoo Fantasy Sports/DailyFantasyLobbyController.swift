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
    
    private let contestCellIdentifier = "contestCell"
    private let createContestCellIdentifier = "createContestCell"
    private let disclaimerCellIdentifier = "disclaimerCell"
    private let leaguesCellIdentifier = "leaguesCell"
    private var navigationTitleView = YHDetailTitleView()
    private var lobbyView = DailyFantasyLobbyView()
    
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
        //Setup NavigationBar
        self.setupNavigationBar()
        
        //Setup View
        self.setupView()
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
        self.lobbyView.headerView.configure()
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
    
    //CollectionView DataSource
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView (_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        switch lobbyView.headerView.segmentedControl.selectedSegmentIndex{
        case 0:
            switch indexPath.item{
            case 0:
                return CGSize(width: collectionView.frame.width-16, height: 220)
            case 1:
                return CGSize(width: collectionView.frame.width-16, height: 220)
            case 2:
                return CGSize(width: collectionView.frame.width-16, height: 50)
            case 3:
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
            case 0:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: contestCellIdentifier, for: indexPath) as! DailyFantasyLobbyContestCell
                cell.dailyFantasyLobbyContestCellDelegate = self
                cell.configure()
                return cell
            case 1:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: contestCellIdentifier, for: indexPath) as! DailyFantasyLobbyContestCell
                cell.dailyFantasyLobbyContestCellDelegate = self
                cell.configure()
                return cell
            case 2:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: createContestCellIdentifier, for: indexPath) as! DailyFantasyLobbyCreateContestCell
                return cell
            case 3:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: disclaimerCellIdentifier, for: indexPath) as! DailyFantasyLobbyDisclaimerCell
                return cell
            default:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: createContestCellIdentifier, for: indexPath) as! DailyFantasyLobbyCreateContestCell
                return cell
            }
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: leaguesCellIdentifier, for: indexPath) as! DailyFantasyLobbyLeaguesCell
            cell.configure(league: nil)
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
        self.lobbyView.collectionView.reloadData()
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

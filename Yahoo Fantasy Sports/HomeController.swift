//
//  HomeController.swift
//  Yahoo Fantasy Sports
//
//  Created by Justin Wells on 7/15/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

class HomeController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, HomeDailyFantasyCellDelegate, YHNavigationCollectionHeaderDelegate{
    
    private let headerCellIdentifier = "headerCell"
    private let footballLeagueCellIdentifier = "footballLeagueCell"
    private let dailyFantasyCellIdentifier = "dailyFantasyCell"
    private let advertisementCellIdentifier = "advertisementCell"
    private let settingsCellIdentifier = "settingsCell"
    private var homeView = HomeView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Setup NavigationBar
        self.setupNavigationBar()
        
        //Setup View
        self.setupView()
    }
    
    func setupNavigationBar(){
        //Setup Navigation Items
        self.navigationItem.title = "fantasy".localized().uppercased()
        
        let menuBtn = YHBarButton(image: UIImage(named: "menu"))
        menuBtn.addTarget(self, action: #selector(self.menuButtonPressed(sender:)), for: .touchUpInside)
        let menuButton = UIBarButtonItem(customView: menuBtn)
        self.navigationItem.leftBarButtonItem = menuButton
        
        let forwardBtn = YHBarButton(image: UIImage(named: "forward"))
        forwardBtn.addTarget(self, action: #selector(self.forwardButtonPressed(sender:)), for: .touchUpInside)
        let forwardButton = UIBarButtonItem(customView: forwardBtn)
        self.navigationItem.rightBarButtonItem = forwardButton
    }
    
    func setupView(){
        self.view.backgroundColor = .white
        
        //Setup HomeView
        self.setupHomeView()
        
        //Setup Constraints
        self.setupConstraints()
    }
    
    func setupHomeView(){
        self.homeView.collectionView.dataSource = self
        self.homeView.collectionView.delegate = self
        self.homeView.collectionView.register(YHNavigationCollectionHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerCellIdentifier)
        self.homeView.collectionView.register(HomeFantasyLeagueCell.self, forCellWithReuseIdentifier: footballLeagueCellIdentifier)
        self.homeView.collectionView.register(HomeDailyFantasyCell.self, forCellWithReuseIdentifier: dailyFantasyCellIdentifier)
        self.homeView.collectionView.register(YHAdvertisementCollectionCell.self, forCellWithReuseIdentifier: advertisementCellIdentifier)
        self.homeView.collectionView.register(HomeSettingsCell.self, forCellWithReuseIdentifier: settingsCellIdentifier)
        self.homeView.refreshControl.addTarget(self, action: #selector(self.refreshData), for: .valueChanged)
        self.homeView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(homeView)
    }
    
    func setupConstraints(){
        let viewDict = ["homeView": homeView] as [String : Any]
        //Width & Horizontal Alignment
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[homeView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        //Height & Vertical Alignment
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[homeView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
    }
    
    func refreshData(){
        
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
            headerView.navigationCollectionHeaderDelegate = self
            headerView.configure(items: homeNavigationItems)
            reusableView = headerView
        }
        return reusableView!
    }
    
    func collectionView (_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        switch indexPath.row{
        case 0:
            return CGSize(width: collectionView.frame.width-16, height: 125)
        case 1:
            return CGSize(width: collectionView.frame.width-16, height: 135)
        case 2:
            return CGSize(width: collectionView.frame.width-16, height: 70)
        case 3:
            return CGSize(width: collectionView.frame.width-16, height: 50)
        default:
            return .zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.row{
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: footballLeagueCellIdentifier, for: indexPath) as! HomeFantasyLeagueCell
            cell.configure(league: nil)
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: dailyFantasyCellIdentifier, for: indexPath) as! HomeDailyFantasyCell
            cell.homeDailyFantasyCellDelegate = self
            cell.configure(league: nil)
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: advertisementCellIdentifier, for: indexPath) as! YHAdvertisementCollectionCell
            cell.configure()
            return cell
        case 3:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: settingsCellIdentifier, for: indexPath) as! HomeSettingsCell
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: footballLeagueCellIdentifier, for: indexPath) as! HomeFantasyLeagueCell
            cell.configure(league: nil)
            return cell
        }
        
    }
    
    //CollectionViewCell Delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let pageViewController = appDelegate.pageViewController
        switch indexPath.row{
        case 0:
            appDelegate.pageViewControllers.remove(at: 1)
            let leagueVC = appDelegate.setupLeagueController()
            appDelegate.pageViewControllers.insert(leagueVC, at: 1)
            pageViewController.setViewControllers([appDelegate.pageViewControllers[1]], direction: .forward, animated: true, completion: nil)
        case 1:
            appDelegate.pageViewControllers.remove(at: 1)
            let dailyFantasyVC = appDelegate.setupDailyFantasyController()
            appDelegate.pageViewControllers.insert(dailyFantasyVC, at: 1)
            pageViewController.setViewControllers([appDelegate.pageViewControllers[1]], direction: .forward, animated: true, completion: nil)
        default:
            //Show Feature Unavailable
            self.present(featureUnavailableAlert(), animated: true, completion: nil)
            break;
        }
    }
    
    func didPressNavigationCollectionHeader(indexPath: IndexPath){
        switch indexPath.item{
        case 3:
            let url = URL(string: "fantasyShopURL".localized())!
            let webViewVC = YHWebViewController(url: url, navTitle: "fantasyShop".localized())
            let navVC = HomeNavigationController(rootViewController: webViewVC)
            self.present(navVC, animated: true, completion: nil)
            break
        default:
            //Show Feature Unavailable
            self.present(featureUnavailableAlert(), animated: true, completion: nil)
            break
        }
    }
    
    func didPressSettingsButton() {
        //Show Feature Unavailable
        self.present(featureUnavailableAlert(), animated: true, completion: nil)
    }
    
    //Button Delegates
    func menuButtonPressed(sender: UIButton){
        let menuVC = MenuController()
        self.present(menuVC, animated: false, completion: nil)
    }
    
    func forwardButtonPressed(sender: UIButton) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let pageViewController = appDelegate.pageViewController
        let pageViewControllers = appDelegate.pageViewControllers
        pageViewController.setViewControllers([pageViewControllers[1]], direction: .forward, animated: true, completion: nil)
    }
}


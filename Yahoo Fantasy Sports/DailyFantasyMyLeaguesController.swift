//
//  DailyFantasyMyLeaguesController.swift
//  Yahoo Fantasy Sports
//
//  Created by Justin Wells on 7/16/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit
import HMSegmentedControl

class DailyFantasyMyLeaguesController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    private let cellIdentifier = "cell"
    private var navigationTitleView = YHDetailTitleView()
    private var myLeaguesView = DailyFantasyMyLeaguesView()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        self.tabBarItem.title = "myLeagues".localized()
        self.tabBarItem.image = UIImage(named: "myLeagues")
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
        
        //Setup MyLeagues View
        self.setupMyLeaguesView()
        
        //Setup Constraints
        self.setupConstraints()
    }
    
    func setupMyLeaguesView(){
        self.myLeaguesView.collectionView.dataSource = self
        self.myLeaguesView.collectionView.delegate = self
        self.myLeaguesView.collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        self.myLeaguesView.segmentedControl.addTarget(self, action: #selector(segmentedControlChangedValue), for: .valueChanged)
        self.myLeaguesView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.myLeaguesView)
    }
    
    func setupConstraints(){
        let viewDict = ["myLeaguesView": myLeaguesView] as [String : Any]
        //Width & Horizontal Alignment
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[myLeaguesView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        //Height & Vertical Alignment
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[myLeaguesView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
    }
    
    //Data
    func downloadData(){
        //Set Empty View
        let emptyView = YHEmptyView(image: UIImage(named: "yahooDailyFantasyLogo"), title: "dailyFantasyMyLeaguesEmptyView".localized(), tabBarHeight: self.tabBarController?.tabBar.frame.height)
        self.myLeaguesView.collectionView.backgroundView = emptyView
        self.myLeaguesView.collectionView.reloadData()
    }
    
    //CollectionView DataSource
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView (_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath)
        return cell
    }
    
    //CollectionViewCell Delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    //Segmented Control Delegate
    func segmentedControlChangedValue(segmentedControl: HMSegmentedControl){
        
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
}

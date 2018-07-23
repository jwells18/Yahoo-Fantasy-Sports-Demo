//
//  LeagueMenuController.swift
//  Yahoo Fantasy Sports
//
//  Created by Justin Wells on 7/16/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

class LeagueMenuController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    var menuView = LeagueMenuView()
    private let leagueCellIdentifier = "leagueCell"
    private let dailyFantasyCellIdentifier = "dailyFantasyCell"
    private var teams = [DBTeam]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setup View
        self.setupView()

        //Download Data
        self.downloadData()
    }

    func setupView(){
        self.view.backgroundColor = UIColor.init(white: 0, alpha: 0.75)
        
        //Setup Menu View
        self.setupMenuView()
        
        //Setup Constraints
        self.setupConstraints()
    }
    
    func setupMenuView(){
        self.menuView.tapGestureRecognizer.addTarget(self, action: #selector(self.menuViewTapped))
        self.menuView.collectionView.dataSource = self
        self.menuView.collectionView.delegate = self
        self.menuView.collectionView.register(LeagueMenuLeagueCell.self, forCellWithReuseIdentifier: leagueCellIdentifier)
        self.menuView.collectionView.register(LeagueMenuDailyFantasyCell.self, forCellWithReuseIdentifier: dailyFantasyCellIdentifier)
        self.menuView.cancelButton.addTarget(self, action: #selector(self.cancelButtonPressed), for: .touchUpInside)
        self.menuView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(menuView)
    }
    
    func downloadData(){
        //Download User Teams
        let teamManager = TeamManager()
        teamManager.loadTeams(completionHandler: { (teams) in
            
            self.teams = Array(teams!)
            self.menuView.collectionView.reloadData()
            self.menuView.layoutSubviews()
        })
    }
    
    //CollectionView DataSource
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return teams.count+1
    }
    
    func collectionView (_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        return CGSize(width: collectionView.frame.width-16, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.row{
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: dailyFantasyCellIdentifier, for: indexPath) as! LeagueMenuDailyFantasyCell
            return cell
        case _ where indexPath.row <= teams.count:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: leagueCellIdentifier, for: indexPath) as! LeagueMenuLeagueCell
            cell.configure(team: teams[indexPath.item-1])
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: dailyFantasyCellIdentifier, for: indexPath) as! LeagueMenuDailyFantasyCell
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
            let dailyFantasyVC = appDelegate.setupDailyFantasyController()
            appDelegate.pageViewControllers.insert(dailyFantasyVC, at: 1)
            pageViewController.setViewControllers([appDelegate.pageViewControllers[1]], direction: .forward, animated: false, completion: nil)
        case _ where indexPath.row <= teams.count:
            appDelegate.pageViewControllers.remove(at: 1)
            let leagueVC = appDelegate.setupLeagueController(team: teams[indexPath.row-1])
            appDelegate.pageViewControllers.insert(leagueVC, at: 1)
            pageViewController.setViewControllers([appDelegate.pageViewControllers[1]], direction: .forward, animated: false, completion: nil)
        default:
            //Show Feature Unavailable
            self.present(featureUnavailableAlert(), animated: true, completion: nil)
            break;
        }
    }
    
    func setupConstraints(){
        let viewDict = ["menuView": menuView] as [String : Any]
        //Width & Horizontal Alignment
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[menuView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        //Height & Vertical Alignment
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[menuView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        DispatchQueue.main.async {
            //Size CollecionView to fit content
            self.menuView.collectionViewHeightConstraint.constant = self.menuView.collectionView.contentSize.height
            self.menuView.layoutIfNeeded()
        }
    }
    
    //Button Delegates
    func cancelButtonPressed(sender: UIButton){
         self.dismiss(animated: false, completion: nil)
    }
    
    //Gesture Delegates
    func menuViewTapped() {
        self.dismiss(animated: false, completion: nil)
    }
}

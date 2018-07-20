//
//  AppDelegate.swift
//  Yahoo Fantasy Sports
//
//  Created by Justin Wells on 7/15/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
    var pageViewControllers = [UIViewController]()
    var initialPage = 0

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //Setup Firebase
        FirebaseApp.configure()
        
        //Set Launch Controller
        let blankVC = UIViewController()
        blankVC.view.backgroundColor = .white
        let launchVC = HomeNavigationController(rootViewController: blankVC)
        self.setRootController(viewController: launchVC)
        
        //Setup Employee State Observer
        _ = Auth.auth().addStateDidChangeListener { (auth, user) in
            if Auth.auth().currentUser != nil {
                //Setup Realm
                self.setupRealm(uid: Auth.auth().currentUser?.uid)
                
                //Setup Data Observers
                self.setupDataObservers()
                
                //User is signed in. Set Initial View Controller
                self.setupPageViewController()
            }
            else{
                //User is not signed in.
                //For demo purposes, user will be signed in with a test account. In production, it would go to a welcome screen.
                let userManager = UserManager()
                userManager.signInAsTestUser()
            }
        }
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    //Setup Controllers
    func setupPageViewController(){
        //Setup First Controller
        let homeVC = HomeController()
        let firstVC = HomeNavigationController.init(rootViewController: homeVC)
        
        //Setup Second Controller
        let secondVC = self.setupDailyFantasyController()
        
        //Setup Third Controller
        let messagingVC = MessagingController()
        let thirdVC = MessagingNavigationController.init(rootViewController: messagingVC)
        
        self.pageViewControllers.append(firstVC)
        self.pageViewControllers.append(secondVC)
        self.pageViewControllers.append(thirdVC)
        pageViewController.setViewControllers([self.pageViewControllers[initialPage]], direction: .forward, animated: false, completion: nil)
        self.setRootController(viewController: pageViewController)
    }
    
    func setupDailyFantasyController() -> UIViewController{
        let blankVC = UIViewController()
        blankVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "footballLeaguePlaceholder")?.withRenderingMode(.alwaysOriginal), selectedImage: nil)
        blankVC.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        let navVC1 = YHGradientNavigationController.init(rootViewController: blankVC, colors: [YHColor.blue.cgColor, YHColor.green.cgColor])
        let dailyFantasyLobbyVC = DailyFantasyLobbyController()
        let navVC2 = YHGradientNavigationController.init(rootViewController: dailyFantasyLobbyVC, colors: [YHColor.blue.cgColor, YHColor.green.cgColor])
        let dailyFantasyMyContestsVC = DailyFantasyMyContestsController()
        let navVC3 = YHGradientNavigationController.init(rootViewController: dailyFantasyMyContestsVC, colors: [YHColor.blue.cgColor, YHColor.green.cgColor])
        let dailyFantasyMyLeaguesVC = DailyFantasyMyLeaguesController()
        let navVC4 = YHGradientNavigationController.init(rootViewController: dailyFantasyMyLeaguesVC, colors: [YHColor.blue.cgColor, YHColor.green.cgColor])
        let dailyFantasyResearchVC = DailyFantasyResearchController()
        let navVC5 = YHGradientNavigationController.init(rootViewController: dailyFantasyResearchVC,  colors: [YHColor.blue.cgColor, YHColor.green.cgColor])
        let tabBarVC = YHTabBarController()
        tabBarVC.viewControllers = [navVC1, navVC2, navVC3, navVC4, navVC5]
        tabBarVC.selectedIndex = 1
        
        return tabBarVC
    }
    
    func setupLeagueController() -> UIViewController{
        let blankVC = UIViewController()
        blankVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "footballLeaguePlaceholder")?.withRenderingMode(.alwaysOriginal), selectedImage: nil)
        blankVC.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        let navVC1 = YHGradientNavigationController.init(rootViewController: blankVC, colors: [YHColor.red.cgColor, YHColor.darkRed.cgColor])
        let leagueMyTeamVC = LeagueMyTeamController()
        let navVC2 = YHGradientNavigationController.init(rootViewController: leagueMyTeamVC, colors: [YHColor.red.cgColor, YHColor.darkRed.cgColor])
        let leagueStandingsVC = LeagueStandingsController()
        let navVC3 = YHGradientNavigationController.init(rootViewController: leagueStandingsVC, colors: [YHColor.red.cgColor, YHColor.darkRed.cgColor])
        let leaguePlayersVC = LeaguePlayersController()
        let navVC4 = YHGradientNavigationController.init(rootViewController: leaguePlayersVC, colors: [YHColor.red.cgColor, YHColor.darkRed.cgColor])
        let leagueLeagueVC = LeagueLeagueController()
        let navVC5 = YHGradientNavigationController.init(rootViewController: leagueLeagueVC, colors: [YHColor.red.cgColor, YHColor.darkRed.cgColor])
        let tabBarVC = YHTabBarController()
        tabBarVC.viewControllers = [navVC1, navVC2, navVC3, navVC4, navVC5]
        tabBarVC.selectedIndex = 1

        return tabBarVC
    }
    
    //Database Functions
    func setupRealm(uid: String?){
        //Setup Realm
        let manager = RealmManager()
        manager.setDefaultRealmForEmployee(uid: uid!)
    }
    
    func setupDataObservers(){
        //Setup Data Observers
        let userManager = UserManager()
        userManager.createDataObservers()
    }
    
    func setRootController(viewController: UIViewController){
        //Set TabBarController as Window
        window?.rootViewController = viewController
    }
}


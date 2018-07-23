//
//  MenuController.swift
//  Yahoo Fantasy Sports
//
//  Created by Justin Wells on 7/15/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

class MenuController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    var currentDBUser: DBUser!
    private let topTableCellIdentifier = "topTableCell"
    private let bottomTableCellIdentifier = "bottomTableCell"
    private let dropDownTableCellIdentifier = "dropDownTableCell"
    var menuView = MenuView()
    private var isShowingDropDownView = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Set Current User
        let userManager = UserManager()
        self.currentDBUser = userManager.getCurrentDBUser()
        
        //Setup View
        self.setupView()
    }
    
    func setupView(){
        self.view.backgroundColor = .white
        
        //Setup MenuView
        self.setupMenuView()
        
        //Setup Constraints
        self.setupConstraints()
    }
    
    func setupMenuView(){
        self.menuView = MenuView()
        self.menuView.menuHeaderView.configure(user: currentDBUser)
        self.menuView.menuHeaderView.dropDownButton.addTarget(self, action: #selector(self.dropDownButtonPressed(sender:)), for: .touchUpInside)
        self.menuView.menuHeaderView.cancelButton.addTarget(self, action: #selector(self.cancelButtonPressed(sender:)), for: .touchUpInside)
        self.menuView.menuHeaderView.accountButton.addTarget(self, action: #selector(self.accountButtonPressed(sender:)), for: .touchUpInside)
        self.menuView.topTableView.dataSource = self
        self.menuView.topTableView.delegate = self
        self.menuView.bottomTableView.dataSource = self
        self.menuView.bottomTableView.delegate = self
        self.menuView.dropDownTableView.dataSource = self
        self.menuView.dropDownTableView.delegate = self
        self.menuView.topTableView.register(MenuTopTableCell.self, forCellReuseIdentifier: topTableCellIdentifier)
        self.menuView.bottomTableView.register(MenuBottomTableCell.self, forCellReuseIdentifier: bottomTableCellIdentifier)
        self.menuView.dropDownTableView.register(MenuTopTableCell.self, forCellReuseIdentifier: dropDownTableCellIdentifier)
        self.menuView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(menuView)
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
            //Size TopTableView to fit content
            self.menuView.topTableViewHeightConstraint.constant = self.menuView.topTableView.contentSize.height
            self.menuView.bottomTableViewHeightConstraint.constant = -self.menuView.menuHeaderView.frame.height-self.menuView.topTableView.contentSize.height
            self.menuView.layoutIfNeeded()
        }
    }
    
    //TableView DataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.menuView.topTableView{
            return menuTopTableViewTitles.count
        }
        else if tableView == self.menuView.bottomTableView{
            return menuBottomTableViewTitles.count
        }
        else if tableView == self.menuView.dropDownTableView{
            return menuDropDownViewTitles.count
        }
        else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if tableView == self.menuView.bottomTableView{
            return 40
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if tableView == self.menuView.bottomTableView{
            let tableHeader = MenuBottomTableHeader()
            tableHeader.configure(title: "options".localized())
            return tableHeader
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if tableView == self.menuView.bottomTableView{
            return 100
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if tableView == self.menuView.bottomTableView{
            let tableFooter = MenuBottomTableFooter()
            tableFooter.mainButton.addTarget(self, action: #selector(tableFooterButtonPressed), for: .touchUpInside)
            return tableFooter
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.menuView.topTableView{
            let cell = tableView.dequeueReusableCell(withIdentifier: topTableCellIdentifier, for: indexPath) as! MenuTopTableCell
            cell.configure(image: menuTopTableViewImages[indexPath.row], title: menuTopTableViewTitles[indexPath.row])
            return cell
        }
        else if tableView == self.menuView.bottomTableView{
            let cell = tableView.dequeueReusableCell(withIdentifier: bottomTableCellIdentifier, for: indexPath) as! MenuBottomTableCell
            cell.configure(image: menuBottomTableViewImages[indexPath.row], title: menuBottomTableViewTitles[indexPath.row])
            return cell
        }
        else if tableView == self.menuView.dropDownTableView{
            let cell = tableView.dequeueReusableCell(withIdentifier: dropDownTableCellIdentifier, for: indexPath) as! MenuTopTableCell
            cell.configure(image: menuDropDownViewImages[indexPath.row], title: menuDropDownViewTitles[indexPath.row])
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: topTableCellIdentifier, for: indexPath) as! MenuTopTableCell
            cell.configure(image: nil, title: nil)
            return cell
        }
    }
    
    //TableView Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (tableView == self.menuView.bottomTableView){
            switch indexPath.row{
            case 1:
                let url = URL(string: "fantasyShopURL".localized())!
                let webViewVC = YHWebViewController(url: url, navTitle: "fantasyShop".localized())
                let navVC = HomeNavigationController(rootViewController: webViewVC)
                self.present(navVC, animated: true, completion: nil)
            case 3:
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(URL(string: "helpURL".localized())!, options: [:], completionHandler: nil)
                } else {
                    UIApplication.shared.openURL(URL(string:"helpURL".localized())!)
                }
                break
            case 5:
                //Rate This App
                let alert = UIAlertController(title: "rateThisApp".localized(), message: "rateThisAppMessage".localized(), preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "rateThisAppPositive".localized(), style: .default, handler: nil))
                alert.addAction(UIAlertAction(title: "rateThisAppNegative".localized(), style: .default, handler: nil))
                alert.addAction(UIAlertAction(title: "nevermind".localized(), style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
                break
            case 8:
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(URL(string:"yahooSportsAppURL".localized())!, options: [:], completionHandler: nil)
                } else {
                    UIApplication.shared.openURL(URL(string:"yahooSportsAppURL".localized())!)
                }
                break
            default:
                //Show Feature Unavailable
                self.present(featureUnavailableAlert(), animated: true, completion: nil)
                break
            }
        }
        else{
            //Show Feature Unavailable
            self.present(featureUnavailableAlert(), animated: true, completion: nil)
        }
    }
    
    //Button Delegates
    func dropDownButtonPressed(sender: UIButton){
        //Show Drop Down menu and update icon
        switch self.isShowingDropDownView{
        case true:
            UIView.animate(withDuration: 0.35, animations: {
                self.menuView.dropDownTableViewTopConstraint.constant = -self.menuView.dropDownTableView.frame.height-20
                self.menuView.menuHeaderView.dropDownButton.transform = CGAffineTransform.identity
                self.isShowingDropDownView = false
                self.view.layoutIfNeeded()
            })
        case false:
            UIView.animate(withDuration: 0.35, animations: {
                self.menuView.dropDownTableViewTopConstraint.constant = 0
                self.menuView.menuHeaderView.dropDownButton.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
                self.isShowingDropDownView = true
                self.view.layoutIfNeeded()
            })
        }
    }
    
    func cancelButtonPressed(sender: UIButton){
        self.dismiss(animated: false, completion: nil)
    }
    
    func accountButtonPressed(sender: UIButton){
        //Show Feature Unavailable
        self.present(featureUnavailableAlert(), animated: true, completion: nil)
    }
    
    func tableFooterButtonPressed(sender: UIButton){
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "termsOfServiceUpdated".localized(), style: .default, handler: { (completed) in
            //Show Feature Unavailable
            self.present(featureUnavailableAlert(), animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "privacyPolicyUpdated".localized(), style: .default, handler: { (completed) in
            //Show Feature Unavailable
            self.present(featureUnavailableAlert(), animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "credits".localized(), style: .default, handler: { (completed) in
            //Show Feature Unavailable
            self.present(featureUnavailableAlert(), animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "cancel".localized(), style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

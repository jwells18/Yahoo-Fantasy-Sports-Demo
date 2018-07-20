//
//  Constants.swift
//  Yahoo Fantasy Sports
//
//  Created by Justin Wells on 7/15/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

//Constant Values
var cornerRadiusDivisor: CGFloat = 2.2

//Custom Colors
struct YHColor{
    static let primary = UIColorFromRGB(0xFF6D91)
    static let faintGray = UIColor(white: 0.95, alpha: 1)
    static let orange = UIColorFromRGB(0xFF9500)
    static let faintOrange = UIColorFromRGB(0xFFF1E9)
    static let red = UIColorFromRGB(0xE84E3C)
    static let darkRed = UIColorFromRGB(0xBF392A)
    static let green = UIColorFromRGB(0x01BA68)
    static let blue = UIColorFromRGB(0x1483D0)
    static let mint = UIColorFromRGB(0x1ABD9C)
    static let darkMint = UIColorFromRGB(0x16A185)
    static let darkPurple = UIColorFromRGB(0x31004A)
}

public func UIColorFromRGB(_ rgbValue: UInt) -> UIColor {
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}

//Database Constants
var testUserEmail = "johnsmith@gmail.com"
var testUserPassword = "password1"
var userDatabase = "YHUser"
var userPrimaryKey = "objectId"
var leagueDatabase = "YHLeague"
var leaguePrimaryKey = "objectId"
var playerDatabase = "YHPlayer"
var playerPrimaryKey = "objectId"
var teamDatabase = "YHTeam"
var teamPrimaryKey = "objectId"
var dailyFantasyContestDatabase = "YHDailyFantasyContest"
var dailyFantasyContestPrimaryKey = "objectId"
var dailyFantasyLeagueDatabase = "YHDailyFantasyLeague"
var dailyFantasyLeaguePrimaryKey = "objectId"
var chatDatabase = "YHChat"
var chatPrimaryKey = "objectId"

//Arrays
var homeNavigationItems = [YHNavigationCollectionItem(image: UIImage(named: "news")!, title: "news".localized()), YHNavigationCollectionItem(image: UIImage(named: "draftCentral")!, title: "draftCentral".localized()), YHNavigationCollectionItem(image: UIImage(named: "addTeam")!, title: "addTeam".localized()), YHNavigationCollectionItem(image: UIImage(named: "fantasyShop")!, title: "fantasyShop".localized()), YHNavigationCollectionItem(image: UIImage(named: "profile")!, title: "profile".localized())]
var dailyFantasyLobbySegmentedTitles = ["contests".localized(), "leagues".localized()]
var dailyFantasyMyContestsSegmentedTitles = ["live".localized(), "upcoming".localized(), "completed".localized()]
var dailyFantasyMyLeaguesSegmentedTitles = ["active".localized(), "completed".localized()]
var menuTopTableViewTitles = ["accountKey".localized()]
var menuTopTableViewImages = [UIImage(named: "accountKey")]
var menuBottomTableViewTitles = ["wallet".localized(), "fantasyShop".localized(), "settings".localized(), "help".localized(), "sendFeedback".localized(), "rateThisApp".localized(), "privacyDashboard".localized(), "joinUs".localized(), "yahooSports".localized()]
var menuBottomTableViewImages = [UIImage(named: "wallet"), UIImage(named: "fantasyShop1"), UIImage(named: "settings1"), UIImage(named: "help"), UIImage(named: "sendFeedback"), UIImage(named: "rateThisApp"), UIImage(named: "privacyDashboard"), UIImage(named: "joinUs"), UIImage(named: "yahooSports")]
var menuDropDownViewTitles = ["manageAccounts".localized(), "accountKey".localized()]
var menuDropDownViewImages = [UIImage(named: "manageAccounts"), UIImage(named: "accountKey")]
var leaguePlayersNavigationItems = [YHNavigationCollectionItem(image: UIImage(named: "myWatchlist")!, title: "myWatchlist".localized()), YHNavigationCollectionItem(image: UIImage(named: "comparePlayers")!, title: "comparePlayers".localized()), YHNavigationCollectionItem(image: UIImage(named: "nflNews")!, title: "nflNews".localized()), YHNavigationCollectionItem(image: UIImage(named: "rotoArcade")!, title: "rotoArcade".localized())]
var leagueLeagueNavigationItems = [YHNavigationCollectionItem(image: UIImage(named: "transactions")!, title: "transactions".localized()), YHNavigationCollectionItem(image: UIImage(named: "proposeTrade")!, title: "proposeTrade".localized()), YHNavigationCollectionItem(image: UIImage(named: "draft")!, title: "draft".localized()), YHNavigationCollectionItem(image: UIImage(named: "messageBoard")!, title: "messageBoard".localized()), YHNavigationCollectionItem(image: UIImage(named: "tools")!, title: "tools".localized())]
var leagueMyTeamSettingsItems = [YHSettingsItem(image: UIImage(named: "messaging")!, title: "inviteYourFriends".localized()), YHSettingsItem(image: UIImage(named: "settings")!, title: "editLeagueSettings".localized())]
var leagueLeagueSettingsItems = [YHSettingsItem(image: UIImage(named: "settings")!, title: "editLeagueSettings".localized()), YHSettingsItem(image: UIImage(named: "settings")!, title: "editDraftTime".localized())]
var topAvailablePlayersSegmentedTitles = ["allPositions".localized(), "qb".localized(), "wr".localized(), "rb".localized(), "te".localized(), "w/r/t".localized(), "k".localized(), "def".localized()]

//Feature Not Available
public func featureUnavailableAlert() -> UIAlertController{
    //Show Alert that this feature is not available
    let alert = UIAlertController(title: "sorry".localized(), message: "featureUnavailableMessage".localized(), preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "ok".localized(), style: .default, handler: nil))
    return alert
}

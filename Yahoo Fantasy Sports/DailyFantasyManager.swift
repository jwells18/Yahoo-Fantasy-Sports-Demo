//
//  DailyFantasyManager.swift
//  Yahoo Fantasy Sports
//
//  Created by Justin Wells on 7/20/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import Foundation
import Firebase

class DailyFantasyManager: NSObject{
    
    var ref: DatabaseReference!
    
    func downloadDailyFantasyLatestContest(completionHandler:@escaping (DailyFantasyContest) -> Void){
        var dailyFantasyLatestContest = DailyFantasyContest()
        ref = Database.database().reference().child(dailyFantasyContestDatabase)
        var query = DatabaseQuery()
        
        query = ref.queryOrdered(byChild: "startDate").queryLimited(toLast: 1)
        query.observeSingleEvent(of: .value, with: { (snapshot) in
            if !snapshot.exists() {
                completionHandler(dailyFantasyLatestContest)
                return
            }
            
            for child in snapshot.children{
                //Create Contest
                let childSnapshot = child as? DataSnapshot
                let rawData = childSnapshot?.value as! [String: Any]
                dailyFantasyLatestContest = self.createDailyFantasyContest(rawData: rawData)
            }
            completionHandler(dailyFantasyLatestContest)
        })
    }
    
    func downloadDailyFantasyContests(completionHandler:@escaping ([[DailyFantasyContest]]) -> Void){
        let dailyFantasyContests = [[DailyFantasyContest]]()
        var unsortedDailyFantasyContests = [DailyFantasyContest]()
        ref = Database.database().reference().child(dailyFantasyContestDatabase)
        var query = DatabaseQuery()
        
        query = ref.queryOrdered(byChild: "startDate").queryLimited(toLast: paginationLimit)
        query.observeSingleEvent(of: .value, with: { (snapshot) in
            if !snapshot.exists() {
                completionHandler(dailyFantasyContests)
                return
            }
            
            for child in snapshot.children{
                //Create Contest
                let childSnapshot = child as? DataSnapshot
                let rawData = childSnapshot?.value as! [String: Any]
                let dailyFantasyContest = self.createDailyFantasyContest(rawData: rawData)
                unsortedDailyFantasyContests.insert(dailyFantasyContest, at: 0)
            }
            //Sort Contests by League
            completionHandler(self.sortContests(contests: unsortedDailyFantasyContests))
        })
    }
    
    func sortContests(contests: [DailyFantasyContest]) -> [[DailyFantasyContest]]{
        
        var contestArray = [[DailyFantasyContest]]()
        var nflContests = [DailyFantasyContest]()
        var mlbContests = [DailyFantasyContest]()
        var nbaContests = [DailyFantasyContest]()
        var nhlContests = [DailyFantasyContest]()
        var pgaContests = [DailyFantasyContest]()
        var mlsContests = [DailyFantasyContest]()

        for contest in contests{
            if(contest.sportsLeague != nil){
                switch contest.sportsLeague!{
                case .nfl:
                    nflContests.append(contest)
                case .mlb:
                    mlbContests.append(contest)
                case .nba:
                    nbaContests.append(contest)
                case .nhl:
                    nhlContests.append(contest)
                case .pga:
                    pgaContests.append(contest)
                case.mls:
                    mlsContests.append(contest)
                }
            }
        }

        let allLeagues = [nflContests, mlbContests, nbaContests, nhlContests, pgaContests, mlsContests]
        for league in allLeagues{
            if league.count > 0{
                contestArray.append(league)
            }
        }

        return contestArray
    }
    
    func downloadDailyFantasyLeagues(completionHandler:@escaping ([DailyFantasyLeague]) -> Void){
        var dailyFantasyLeagues = [DailyFantasyLeague]()
        ref = Database.database().reference().child(dailyFantasyLeagueDatabase)
        var query = DatabaseQuery()
        
        query = ref.queryOrdered(byChild: "startDate").queryLimited(toLast: paginationLimit)
        query.observeSingleEvent(of: .value, with: { (snapshot) in
            if !snapshot.exists() {
                completionHandler(dailyFantasyLeagues)
                return
            }
            
            for child in snapshot.children{
                //Create League
                let childSnapshot = child as? DataSnapshot
                let rawData = childSnapshot?.value as! [String: Any]
                let dailyFantasyLeague = self.createDailyFantasyLeague(rawData: rawData)
                dailyFantasyLeagues.insert(dailyFantasyLeague, at: 0)
            }
            completionHandler(dailyFantasyLeagues)
        })
    }
    
    func createDailyFantasyContest(rawData: [String: Any]) -> DailyFantasyContest{
        let dailyFantasyContest = DailyFantasyContest()
        dailyFantasyContest.objectId = rawData["objectId"] as? String
        let createdAt = rawData["createdAt"] as! Double
        dailyFantasyContest.createdAt = createdAt.dateValue()
        let updatedAt = rawData["updatedAt"] as! Double
        dailyFantasyContest.updatedAt = updatedAt.dateValue()
        dailyFantasyContest.name = rawData["name"] as? String
        let startDate = rawData["startDate"] as! Double
        dailyFantasyContest.startDate = startDate.dateValue()
        let endDate = rawData["endDate"] as! Double
        dailyFantasyContest.endDate = endDate.dateValue()
        dailyFantasyContest.entryFee = rawData["entryFee"] as? NSNumber
        dailyFantasyContest.totalPrize = rawData["totalPrize"] as? NSNumber
        dailyFantasyContest.entryCount = rawData["entryCount"] as? NSNumber
        dailyFantasyContest.entryLimit = rawData["entryLimit"] as? NSNumber
        let sport = rawData["sport"] as? String
        if sport != nil{
            dailyFantasyContest.sport = Sport(rawValue: sport!)
        }
        let sportsLeague = rawData["sportsLeague"] as? String
        if sportsLeague != nil{
            dailyFantasyContest.sportsLeague = SportsLeague(rawValue: sportsLeague!)
        }
        dailyFantasyContest.isGuaranteed = rawData["isGuaranteed"] as? NSNumber
        dailyFantasyContest.isMultiEntry = rawData["isMultiEntry"] as? NSNumber
        dailyFantasyContest.multiEntryLimit = rawData["multiEntryLimit"] as? NSNumber
        dailyFantasyContest.totalGames = rawData["totalGames"] as? NSNumber
        
        return dailyFantasyContest
    }
    
    func createDailyFantasyLeague(rawData: [String: Any]) -> DailyFantasyLeague{
        let dailyFantasyLeague = DailyFantasyLeague()
        
        dailyFantasyLeague.objectId = rawData["objectId"] as? String
        let createdAt = rawData["createdAt"] as! Double
        dailyFantasyLeague.createdAt = createdAt.dateValue()
        let updatedAt = rawData["updatedAt"] as! Double
        dailyFantasyLeague.updatedAt = updatedAt.dateValue()
        dailyFantasyLeague.name = rawData["name"] as? String
        let startDate = rawData["startDate"] as! Double
        dailyFantasyLeague.startDate = startDate.dateValue()
        let endDate = rawData["endDate"] as! Double
        dailyFantasyLeague.endDate = endDate.dateValue()
        dailyFantasyLeague.entryFee = rawData["entryFee"] as? NSNumber
        dailyFantasyLeague.totalPrize = rawData["totalPrize"] as? NSNumber
        dailyFantasyLeague.entryCount = rawData["entryCount"] as? NSNumber
        dailyFantasyLeague.entryLimit = rawData["entryLimit"] as? NSNumber
        let sport = rawData["sport"] as? String
        if sport != nil{
            dailyFantasyLeague.sport = Sport(rawValue: sport!)
        }
        let sportsLeague = rawData["sportsLeague"] as? String
        if sportsLeague != nil{
            dailyFantasyLeague.sportsLeague = SportsLeague(rawValue: sportsLeague!)
        }
        dailyFantasyLeague.currentRound = rawData["currentRound"] as? NSNumber
        dailyFantasyLeague.totalRounds = rawData["totalRounds"] as? NSNumber
        
        return dailyFantasyLeague
    }
}

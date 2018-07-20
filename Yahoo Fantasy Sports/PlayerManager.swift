//
//  PlayerManager.swift
//  Yahoo Fantasy Sports
//
//  Created by Justin Wells on 7/20/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import Foundation
import Firebase

class PlayerManager: NSObject{
    
    var ref: DatabaseReference!
    
    func downloadTopAvailablePlayers(completionHandler:@escaping ([Player]) -> Void){
        var players = [Player]()
        ref = Database.database().reference().child(playerDatabase)
        var query = DatabaseQuery()
        
        query = ref.queryOrdered(byChild: "nextGameProjPts").queryLimited(toLast: 3)
        query.observeSingleEvent(of: .value, with: { (snapshot) in
            if !snapshot.exists() {
                completionHandler(players)
                return
            }
            
            for child in snapshot.children{
                //Create Player
                let childSnapshot = child as? DataSnapshot
                let rawData = childSnapshot?.value as! [String: Any]
                let player = self.createPlayer(rawData: rawData)
                players.insert(player, at: 0)
            }
            completionHandler(players)
        })
    }
    
    func downloadTransactionTrendsPlayers(completionHandler:@escaping ([Player]) -> Void){
        var players = [Player]()
        ref = Database.database().reference().child(playerDatabase)
        var query = DatabaseQuery()
        
        query = ref.queryOrdered(byChild: "adds").queryLimited(toLast: 3)
        query.observeSingleEvent(of: .value, with: { (snapshot) in
            if !snapshot.exists() {
                completionHandler(players)
                return
            }
            
            for child in snapshot.children{
                //Create Player
                let childSnapshot = child as? DataSnapshot
                let rawData = childSnapshot?.value as! [String: Any]
                let player = self.createPlayer(rawData: rawData)
                players.insert(player, at: 0)
            }
            completionHandler(players)
        })
    }
    
    func createPlayer(rawData: [String: Any]) -> Player{
        let player = Player()
        player.objectId = rawData["objectId"] as? String
        let createdAt = rawData["createdAt"] as! Double
        player.createdAt = createdAt.dateValue()
        let updatedAt = rawData["updatedAt"] as! Double
        player.updatedAt = updatedAt.dateValue()
        player.firstName = rawData["firstName"] as? String
        player.lastName = rawData["lastName"] as? String
        player.image = rawData["image"] as? String
        let sport = rawData["sport"] as? String
        if sport != nil{
            player.sport = Sport(rawValue: sport!)
        }
        let sportsLeague = rawData["sportsLeague"] as? String
        if sportsLeague != nil{
            player.sportsLeague = SportsLeague(rawValue: sportsLeague!)
        }
        player.position = rawData["position"] as? String
        let nextGameDate = rawData["nextGameDate"] as! Double
        player.nextGameDate = nextGameDate.dateValue()
        player.nextGameTeam = rawData["nextGameTeam"] as? String
        player.adds = rawData["adds"] as? NSNumber
        player.ownedPercentage = rawData["ownedPercentage"] as? NSNumber
        player.drops = rawData["drops"] as? NSNumber
        player.trades = rawData["trades"] as? NSNumber
        let ownershipType = rawData["ownershipType"] as? String
        if ownershipType != nil{
            player.ownershipType = OwnershipType(rawValue: ownershipType!)
        }
        
        return player
    }
}

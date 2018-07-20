//
//  Player.swift
//  Yahoo Fantasy Sports
//
//  Created by Justin Wells on 7/20/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import Foundation

class Player: NSObject{
    var objectId: String!
    var createdAt: Date!
    var updatedAt: Date!
    var firstName: String!
    var lastName: String!
    var image: String!
    var sport: Sport!
    var sportsLeague: SportsLeague!
    var position: String!
    var nextGameDate: Date!
    var nextGameTeam: String!
    var nextGameProjPts: NSNumber!
    var adds: NSNumber!
    var ownedPercentage: NSNumber!
    var drops: NSNumber!
    var trades: NSNumber!
    var ownershipType: OwnershipType!
}

public enum OwnershipType: String{
    case freeAgent = "freeAgent"
}

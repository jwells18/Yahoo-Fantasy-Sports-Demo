//
//  League.swift
//  Yahoo Fantasy Sports
//
//  Created by Justin Wells on 7/15/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import Foundation

class League: NSObject{
    var objectId: String!
    var createdAt: Date!
    var updatedAt: Date!
    var name: String!
    var image: String!
    var sport: Sport!
    var sportsLeague: SportsLeague!
    var draftType: DraftType!
    var teams: [String]!
}

public enum Sport: String{
    case football = "football"
    case baseball = "baseball"
    case basketball = "basketball"
    case iceHockey = "iceHockey"
    case golf = "golf"
    case soccer = "soccer"
}

public enum SportsLeague: String{
    case nfl = "nfl"
    case mlb = "mlb"
    case nba = "nba"
    case nhl = "nhl"
    case pga = "pga"
    case mls = "mls"
}

public enum DraftType: String{
    case liveStandard = "liveStandard"
    case liveAuction = "liveAuction"
    case autopick = "autopick"
    case offline = "offline"
}



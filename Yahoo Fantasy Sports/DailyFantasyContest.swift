//
//  DailyFantasyContest.swift
//  Yahoo Fantasy Sports
//
//  Created by Justin Wells on 7/20/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import Foundation

class DailyFantasyContest: NSObject{
    var objectId: String!
    var createdAt: Date!
    var updatedAt: Date!
    var startDate: Date!
    var endDate: Date!
    var entryFee: NSNumber!
    var totalPrize: NSNumber!
    var entryCount: NSNumber!
    var entryLimit: NSNumber!
    var sport: Sport!
    var sportsLeague: SportsLeague!
    var isGuaranteed: NSNumber!
    var isMultiEntry: NSNumber!
    var multiEntryLimit: NSNumber!
    var totalGames: NSNumber!
}

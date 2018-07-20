//
//  Team.swift
//  Yahoo Fantasy Sports
//
//  Created by Justin Wells on 7/20/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import Foundation

class Team: NSObject{
    var objectId: String!
    var createdAt: Date!
    var updatedAt: Date!
    var name: String!
    var image: String!
    var leagueId: String!
    var leagueName: String!
    var points: NSNumber!
    var memberIds: [String]!
}

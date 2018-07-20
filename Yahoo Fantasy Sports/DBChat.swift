//
//  DBChat.swift
//  Yahoo Fantasy Sports
//
//  Created by Justin Wells on 7/20/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import Foundation
import RealmSwift

class DBChat: Object{
    dynamic var objectId: String!
    dynamic var createdAt = Double()
    dynamic var updatedAt = Double()
    dynamic var name: String!
    dynamic var image: String!
    dynamic var lastMessage: String!
    dynamic var leagueId: String!
    
    override static func primaryKey() -> String? {
        return chatPrimaryKey
    }
}

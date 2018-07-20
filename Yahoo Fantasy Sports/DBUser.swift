//
//  DBUser.swift
//  Yahoo Fantasy Sports
//
//  Created by Justin Wells on 7/20/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import Foundation
import RealmSwift

class DBUser: Object{
    dynamic var objectId: String!
    dynamic var createdAt = Double()
    dynamic var updatedAt = Double()
    dynamic var firstName: String!
    dynamic var lastName: String!
    dynamic var nickname: String!
    dynamic var gender: String!
    dynamic var email: String!
    dynamic var birthday = Double()
    dynamic var image: String!
    dynamic var contests: String!
    dynamic var teams: String!
    
    override static func primaryKey() -> String? {
        return userPrimaryKey
    }
}

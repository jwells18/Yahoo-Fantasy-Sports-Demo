//
//  User.swift
//  Yahoo Fantasy Sports
//
//  Created by Justin Wells on 7/20/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import Foundation

class User: NSObject{
    var objectId: String!
    var createdAt: Date!
    var updatedAt: Date!
    var firstName: String!
    var lastName: String!
    var nickname: String!
    var gender: Gender!
    var email: String!
    var birthday: Date!
    var image: String!
    var contests: [String]!
    var teams: [String]!
}

public enum Gender: String{
    case male = "male"
    case female = "female"
    case undefined = "undefined"
}

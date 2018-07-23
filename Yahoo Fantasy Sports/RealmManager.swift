//
//  RealmManager.swift
//  Yahoo Fantasy Sports
//
//  Created by Justin Wells on 7/20/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import Foundation
import RealmSwift

class RealmManager: NSObject{
    
    func setDefaultRealmForEmployee(uid: String) {
        var config = Realm.Configuration()
        
        //Realm default configuration for each user
        config.fileURL = config.fileURL!.deletingLastPathComponent().appendingPathComponent("\(uid).realm")
        Realm.Configuration.defaultConfiguration = config
    }
}

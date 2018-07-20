//
//  TeamManager.swift
//  Yahoo Fantasy Sports
//
//  Created by Justin Wells on 7/20/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import Foundation
import Firebase
import RealmSwift

class TeamManager: NSObject{
    
    var ref: DatabaseReference!
    
    func loadTeams(completionHandler:@escaping (Results<DBTeam>?) -> Void){
        //Load Jobs from Realm
        let realm = try! Realm()
        let dbTeams = realm.objects(DBTeam.self).sorted(byKeyPath: "updatedAt", ascending: false)
        completionHandler(dbTeams)
    }
}

extension TeamManager{
    
    func lastUpdatedAt() -> Double{
        //Return all DBTeams from Realm and return most recent updatedAt date
        let realm = try! Realm()
        let team = realm.objects(DBTeam.self).sorted(byKeyPath: "updatedAt", ascending: true).last
        if(team != nil){
            return (team?.updatedAt)!
        }
        else{
            return 0
        }
    }
}

extension TeamManager{
    
    func createDataObservers(){
        //Create Database Observers
        if(Auth.auth().currentUser != nil){
            if (ref == nil){
                self.createObservers()
            }
        }
    }
    
    func createObservers(){
        let lastUpdatedAt = self.lastUpdatedAt()
        let userId = Auth.auth().currentUser?.uid
        let ref = Database.database().reference(withPath: teamDatabase).child(userId!)
        let query: DatabaseQuery = ref.queryOrdered(byChild: "updatedAt").queryStarting(atValue: lastUpdatedAt+1)
        query.observe(.childAdded, with: { (snapshot) -> Void in
            let rawData = snapshot.value as! NSDictionary
            if(rawData["updatedAt"] != nil){
                self.updateRealm(rawData: rawData)
            }
        })
        
        query.observe(.childChanged, with: { (snapshot) -> Void in
            let rawData = snapshot.value as! NSDictionary
            if(rawData["updatedAt"] != nil){
                self.updateRealm(rawData: rawData)
            }
        })
        
        query.observe(.childRemoved, with: { (snapshot) -> Void in
            let rawData = snapshot.value as! NSDictionary
            if(rawData["updatedAt"] != nil){
                self.deleteInRealm(rawData: rawData)
            }
        })
    }
    
    func updateRealm(rawData: NSDictionary){
        let realm = try! Realm()
        try! realm.write{
            realm.create(DBTeam.self, value: rawData, update: true)
        }
    }
    
    func deleteInRealm(rawData: NSDictionary){
        let realm = try! Realm()
        let realmPredicate = NSPredicate(format: "objectId = %@", rawData["objectId"] as! String)
        let dbTeam = realm.objects(DBTeam.self).filter(realmPredicate).sorted(byKeyPath: "updatedAt", ascending: false)
        try! realm.write{
            realm.delete(dbTeam)
        }
    }
}

//
//  ChatManager.swift
//  Yahoo Fantasy Sports
//
//  Created by Justin Wells on 7/20/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import Foundation
import Firebase
import RealmSwift

class ChatManager: NSObject{
    
    var ref: DatabaseReference!
    
    func loadChats(completionHandler:@escaping (Results<DBChat>?) -> Void){
        //Load Jobs from Realm
        let realm = try! Realm()
        let dbChats = realm.objects(DBChat.self).sorted(byKeyPath: "updatedAt", ascending: false)
        completionHandler(dbChats)
    }
    
    func searchMessages(searchText: String, completionHandler:@escaping (Results<DBChat>?) -> Void){
        //Load Available Inventory
        let realm = try! Realm()
        let realmPredicate = NSPredicate(format: "name CONTAINS[cd] %@ OR lastMessage CONTAINS[cd] %@", searchText, searchText)
        let dbItems = realm.objects(DBChat.self).filter(realmPredicate).sorted(byKeyPath: "updatedAt", ascending: false)
        
        completionHandler(dbItems)
    }
}

extension ChatManager{
    
    func lastUpdatedAt() -> Double{
        //Return all DBChats from Realm and return most recent updatedAt date
        let realm = try! Realm()
        let chat = realm.objects(DBChat.self).sorted(byKeyPath: "updatedAt", ascending: true).last
        if(chat != nil){
            return (chat?.updatedAt)!
        }
        else{
            return 0
        }
    }
}

extension ChatManager{
    
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
        let ref = Database.database().reference(withPath: chatDatabase).child(userId!)
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
            realm.create(DBChat.self, value: rawData, update: true)
        }
    }
    
    func deleteInRealm(rawData: NSDictionary){
        let realm = try! Realm()
        let realmPredicate = NSPredicate(format: "objectId = %@", rawData["objectId"] as! String)
        let dbChat = realm.objects(DBChat.self).filter(realmPredicate).sorted(byKeyPath: "updatedAt", ascending: false)
        try! realm.write{
            realm.delete(dbChat)
        }
    }
}

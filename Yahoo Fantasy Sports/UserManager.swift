//
//  UserManager.swift
//  Yahoo Fantasy Sports
//
//  Created by Justin Wells on 7/20/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import Foundation
import Firebase
import RealmSwift

class UserManager: NSObject{
    
    var ref: DatabaseReference!
    
    func create(user: User, completionHandler:@escaping (Bool) -> Void) {
        let ref = Database.database().reference()
        var userData = Dictionary<String, Any>()
        userData["objectId"] = user.objectId
        userData["createdAt"] = ServerValue.timestamp()
        userData["updatedAt"] = ServerValue.timestamp()
        userData["firstName"] = user.firstName
        userData["lastName"] = user.lastName
        userData["email"] = user.email
        userData["image"] = user.image
        userData["birthday"] = user.birthday
        ref.child(userDatabase).child(user.objectId).child(user.objectId).setValue(userData) { (error:Error?, DatabaseReference) in
            if((error) != nil){
                print("Error uploading user")
            }
        }
    }
    
    func signInAsTestUser(){
        Auth.auth().signIn(withEmail: testUserEmail, password: testUserPassword) { (user, error) in
            if(error == nil){
                //Setup PageViewController - automatically triggered by user state observer in App Delegate
            }
            else{
                //Show Error Message
                let alert = UIAlertController(title: "sorry".localized(), message: "signInError".localized(), preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "ok".localized(), style: .default, handler: nil))
            }
        }
    }
    
    func getCurrentDBUser() -> DBUser?{
        let userId = Auth.auth().currentUser?.uid
        return self.loadUser(uid: userId ?? "")
    }
    
    func loadUser(uid: String) -> DBUser?{
        //Load User from Realm
        let realm = try! Realm()
        let realmPredicate = NSPredicate(format: "objectId = %@", uid)
        let dbUser = realm.objects(DBUser.self).filter(realmPredicate).sorted(byKeyPath: "updatedAt", ascending: false).first
        
        return dbUser
    }
    
    func signOutUser(){
        do{
            try Auth.auth().signOut()
            // Delete all objects from the realm
            let realm = try! Realm()
            try! realm.write {
                realm.deleteAll()
            }
        }
        catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
}

extension UserManager{
    
    func createDataObservers(){
        //Create Database Observers
        if(Auth.auth().currentUser != nil){
            if (ref == nil){
                self.createObservers()
            }
        }
    }
    
    func createObservers(){
        let userId = Auth.auth().currentUser?.uid
        ref = Database.database().reference(withPath: userDatabase).child(userId!)
        ref.observe(.childAdded, with: { (snapshot) -> Void in
            let rawData = snapshot.value as! [String: Any]
            if(rawData["updatedAt"] != nil){
                self.updateRealm(rawData: rawData)
            }
        })
        
        ref.observe(.childChanged, with: { (snapshot) -> Void in
            let rawData = snapshot.value as! [String: Any]
            if(rawData["updatedAt"] != nil){
                self.updateRealm(rawData: rawData)
            }
        })
        
        ref.observe(.childRemoved, with: { (snapshot) -> Void in
            let rawData = snapshot.value as! [String: Any]
            if(rawData["updatedAt"] != nil){
                self.deleteInRealm(rawData: rawData)
            }
        })
    }
    
    func updateRealm(rawData: [String: Any]){
        let realm = try! Realm()
        try! realm.write {
            realm.create(DBUser.self, value: rawData, update: true)
        }
    }
    
    func deleteInRealm(rawData: [String: Any]){
        let realm = try! Realm()
        let realmPredicate = NSPredicate(format: "objectId = %@", rawData["objectId"] as! String)
        let dbUser = realm.objects(DBUser.self).filter(realmPredicate).sorted(byKeyPath: "updatedAt", ascending: false)
        try! realm.write{
            realm.delete(dbUser)
        }
    }
}

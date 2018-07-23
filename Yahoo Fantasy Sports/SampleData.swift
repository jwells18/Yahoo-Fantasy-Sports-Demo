//
//  SampleData.swift
//  Yahoo Fantasy Sports
//
//  Created by Justin Wells on 7/20/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import Foundation
import Firebase

private var ref = Database.database().reference()
private var userManager = UserManager()
private var dateManager = DateManager()

func uploadTestUser(){
    var userData = Dictionary<String, Any>()
    userData["objectId"] = "zcaa1rM8t1R7BRc1KyPOn7y7Wud2"
    userData["createdAt"] = ServerValue.timestamp()
    userData["updatedAt"] = ServerValue.timestamp()
    userData["firstName"] = "John"
    userData["lastName"] = "Smith"
    userData["email"] = "johnsmith@gmail.com"
    userData["image"] = "https://firebasestorage.googleapis.com/v0/b/ticketmaster-23010.appspot.com/o/User%2Fzcaa1rM8t1R7BRc1KyPOn7y7Wud2%2FprofilePicture%2FsampleUserPicture1.jpg?alt=media&token=d49411c0-3849-4b1a-9352-816d60726657"
    userData["birthday"] = dateManager.createDate(string: "1995/04/13 00:00").timestamp()
    userData["gender"] = "male"
    //userData["contests"] = ""
    //userData["teams"] = ""
    ref.child(userDatabase).child(userData["objectId"] as! String).child(userData["objectId"] as! String).setValue(userData) { (error:Error?, DatabaseReference) in
        if((error) != nil){
            print("Error uploading user")
        }
    }
}

func uploadTestLeague(){
    var leagueData = Dictionary<String, Any>()
    leagueData["objectId"] = ref.childByAutoId().key
    leagueData["createdAt"] = ServerValue.timestamp()
    leagueData["updatedAt"] = ServerValue.timestamp()
    leagueData["name"] = "LA Accountants"
    leagueData["image"] = ""
    leagueData["sport"] = "football"
    leagueData["sportsLeague"] = "nfl"
    leagueData["draftType"] = "offline"
    //leagueData["teams"] = ""
    ref.child(leagueDatabase).child(leagueData["objectId"] as! String).setValue(leagueData) { (error:Error?, DatabaseReference) in
        if((error) != nil){
            print("Error uploading league")
        }
    }
}

func uploadTestTeam(){
    var teamData = Dictionary<String, Any>()
    teamData["objectId"] = ref.childByAutoId().key
    teamData["createdAt"] = ServerValue.timestamp()
    teamData["updatedAt"] = ServerValue.timestamp()
    teamData["name"] = "Morgan Stanley"
    teamData["image"] = "https://firebasestorage.googleapis.com/v0/b/ticketmaster-23010.appspot.com/o/YHTeam%2F-LHtsQxqU7JMluaSzTbA%2FmorganStanleyLogo.jpg?alt=media&token=2c4246a7-ddf6-406b-b388-a16e49cac3bc"
    //teamData["leagueId"] = ""
    teamData["leagueName"] = "LA Accountants"
    teamData["points"] = 0
    //teamData["memberIds"] = ""
    teamData["sport"] = "football"
    teamData["sportsLeague"] = "nfl"
    ref.child(teamDatabase).child("zcaa1rM8t1R7BRc1KyPOn7y7Wud2").child(teamData["objectId"] as! String).setValue(teamData) { (error:Error?, DatabaseReference) in
        if((error) != nil){
            print("Error uploading team")
        }
    }
}

func uploadTestChat(){
    var chatData = Dictionary<String, Any>()
    chatData["objectId"] = ref.childByAutoId().key
    chatData["createdAt"] = ServerValue.timestamp()
    chatData["updatedAt"] = ServerValue.timestamp()
    chatData["name"] = "Morgan Stanley"
    chatData["image"] = ""
    chatData["lastMessage"] = "Good luck everyone!"
    chatData["leagueId"] = ""
    ref.child(chatDatabase).child("zcaa1rM8t1R7BRc1KyPOn7y7Wud2").child(chatData["objectId"] as! String).setValue(chatData) { (error:Error?, DatabaseReference) in
        if((error) != nil){
            print("Error uploading chat")
        }
    }
}

func uploadTestDailyFantasyContests(){
    //Contest Data Array
    var contestDataArray = [Dictionary<String, Any>]()
    
    //Create Contest Data
    let ref = Database.database().reference()
    for i in stride(from: 0, to: contestNames.count, by: 1) {
        var contestData = Dictionary<String, Any>()
        contestData["objectId"] = ref.childByAutoId().key
        contestData["createdAt"] = ServerValue.timestamp()
        contestData["updatedAt"] = ServerValue.timestamp()
        contestData["name"] = contestNames[i]
        contestData["startDate"] = dateManager.createDate(string: contestStartDates[i]).timestamp()
        contestData["endDate"] = dateManager.createDate(string: contestEndDates[i]).timestamp()
        contestData["entryFee"] = contestEntryFees[i]
        contestData["totalPrize"] = contestTotalPrizes[i]
        contestData["entryCount"] = contestEntryCounts[i]
        contestData["entryLimit"] = contestEntryLimits[i]
        contestData["sport"] = contestSports[i]
        contestData["sportsLeague"] = contestSportsLeagues[i]
        contestData["isGuaranteed"] = contestIsGuaranteed[i]
        contestData["isMultiEntry"] = contestIsMultiEntry[i]
        contestData["multiEntryLimit"] = contestMultiEntryLimits[i]
        contestData["totalGames"] = contestTotalGames[i]
        contestDataArray.append(contestData)
    }
    
    //Upload Contest to Database
    for contestData in contestDataArray{
        ref.child(dailyFantasyContestDatabase).child(contestData["objectId"] as! String).setValue(contestData) { (error:Error?, DatabaseReference) in
            if((error) != nil){
                print("Error uploading contest")
            }
        }
    }
}

//Test Contest Raw Data
let contestNames = ["MLB $25K Guaranteed [$25k to 1st]", "MLB $5K Guaranteed [$1k to 1st]", "MLS $100 Guaranteed [Single Entry]", "MLS $100 Guaranteed [Single Entry]"]
let contestStartDates = ["2018/07/20 19:05", "2018/07/20 19:05", "2018/07/21 15:30", "2018/07/21 15:30"]
let contestEndDates = ["2018/07/20 23:59", "2018/07/20 23:59", "2018/07/21 23:59", "2018/07/21 23:59"]
let contestEntryFees = [ 7, 1, 1, 5]
let contestTotalPrizes = [25000, 5000, 100, 100]
let contestEntryCounts = [1100, 1900, 32, 4]
let contestEntryLimits = [4100, 5700, 114, 23]
let contestSports = ["baseball", "baseball", "soccer", "soccer"]
let contestSportsLeagues = ["MLB", "MLB", "MLS", "MLS"]
let contestIsGuaranteed = [ 1, 1, 1, 1]
let contestIsMultiEntry = [ 1, 1, 0, 0]
let contestMultiEntryLimits = [10, 10, 0, 0]
let contestTotalGames = [14, 14, 9, 9]


func uploadTestDailyFantasyLeagues(){
    //League Data Array
    var leagueDataArray = [Dictionary<String, Any>]()
    
    //Create League Data
    let ref = Database.database().reference()
    for i in stride(from: 0, to: leagueNames.count, by: 1) {
        var leagueData = Dictionary<String, Any>()
        leagueData["objectId"] = ref.childByAutoId().key
        leagueData["createdAt"] = ServerValue.timestamp()
        leagueData["updatedAt"] = ServerValue.timestamp()
        leagueData["name"] = leagueNames[i]
        leagueData["startDate"] = dateManager.createDate(string: leagueStartDates[i]).timestamp()
        leagueData["endDate"] = dateManager.createDate(string: leagueEndDates[i]).timestamp()
        leagueData["entryFee"] = leagueEntryFees[i]
        leagueData["totalPrize"] = leagueTotalPrizes[i]
        leagueData["entryCount"] = leagueEntryCounts[i]
        leagueData["entryLimit"] = leagueEntryLimits[i]
        leagueData["sport"] = leagueSports[i]
        leagueData["sportsLeague"] = leagueSportsLeagues[i]
        leagueData["currentRound"] = leagueCurrentRounds[i]
        leagueData["totalRounds"] = leagueTotalRounds[i]
        leagueDataArray.append(leagueData)
    }
    
    //Upload league to Database
    for leagueData in leagueDataArray{
        ref.child(dailyFantasyLeagueDatabase).child(leagueData["objectId"] as! String).setValue(leagueData) { (error:Error?, DatabaseReference) in
            if((error) != nil){
                print("Error uploading league")
            }
        }
    }
}

//Test Daily Fantasy League Raw Data
let leagueNames = ["MLB Yahoo Cup", "PGA Yahoo Cup", "NFL Yahoo Cup", "MLB $1 3-Team 72-Round League"]
let leagueStartDates = ["2018/07/20 0:00", "2018/07/20 0:00", "2018/09/09 0:00", "2018/07/20 7:05"]
let leagueEndDates = ["2018/07/31 23:59", "2018/07/31 23:59", "2018/09/10 23:59", "2018/07/31 23:59"]
let leagueEntryFees = [ 0, 0, 0, 0]
let leagueTotalPrizes = [50000, 50000, 150000, 3.06]
let leagueEntryCounts = [58300, 26900, 13700, 1]
let leagueEntryLimits = [1000000, 1000000, 1000000, 3]
let leagueSports = ["baseball", "golf", "football", "soccer"]
let leagueSportsLeagues = ["MLB", "PGA", "NFL", "MLB"]
let leagueCurrentRounds = [17, 6, 0, 0]
let leagueTotalRounds = [27, 21, 17, 72]

func uploadTestPlayers(){
    //Player Data Array
    var playerDataArray = [Dictionary<String, Any>]()
    
    //Create Player Data
    let ref = Database.database().reference()
    for i in stride(from: 0, to: playerFirstNames.count, by: 1) {
        var playerData = Dictionary<String, Any>()
        playerData["objectId"] = ref.childByAutoId().key
        playerData["createdAt"] = ServerValue.timestamp()
        playerData["updatedAt"] = ServerValue.timestamp()
        playerData["firstName"] = playerFirstNames[i]
        playerData["lastName"] = playerLastNames[i]
        playerData["image"] = playerImages[i]
        playerData["sport"] = playerSports[i]
        playerData["sportsLeague"] = playerSportsLeagues[i]
        playerData["position"] = playerPositions[i]
        playerData["nextGameDate"] = dateManager.createDate(string: playerNextGameDates[i]).timestamp()
        playerData["nextGameTeam"] = playerNextGameTeams[i]
        playerData["nextGameProjPts"] = playerNextGameProjPts[i]
        playerData["adds"] = playerAdds[i]
        playerData["ownedPercentage"] = playerOwnedPercentage[i]
        playerData["drops"] = playerDrops[i]
        playerData["trades"] = playerTrades[i]
        playerData["ownershipType"] = playerOwnershipTypes[i]
        playerDataArray.append(playerData)
    }
    
    //Upload player to Database
    for playerData in playerDataArray{
        ref.child(playerDatabase).child(playerData["objectId"] as! String).setValue(playerData) { (error:Error?, DatabaseReference) in
            if((error) != nil){
                print("Error uploading player")
            }
        }
    }
}

//Test Player Raw Data
let playerFirstNames = ["Aaron", "Deshaun", "Alvin", "Tavon", "Randall", "Jamaal"]
let playerLastNames = ["Rodgers", "Watson", "Kamara", "Austin", "Cobb", "Williams"]
let playerImages = ["https://firebasestorage.googleapis.com/v0/b/ticketmaster-23010.appspot.com/o/YHPlayer%2Fnfl%2F-LHtsQxwiO119T4SaTQx%2FaaronRodgers.png?alt=media&token=f7904ff0-68b2-4287-b9d6-e1e7794d6808", "https://firebasestorage.googleapis.com/v0/b/ticketmaster-23010.appspot.com/o/YHPlayer%2Fnfl%2F-LHtsQxwiO119T4SaTQy%2FdeshaunWatson.png?alt=media&token=e081c51d-78b7-49fa-a51f-5dbc85e3ed20", "https://firebasestorage.googleapis.com/v0/b/ticketmaster-23010.appspot.com/o/YHPlayer%2Fnfl%2F-LHtsQxxKXCDPHwI_ZUe%2FalvinKamara.png?alt=media&token=480f2fa1-88b5-4b57-9c4d-d38a45b19577", "https://firebasestorage.googleapis.com/v0/b/ticketmaster-23010.appspot.com/o/YHPlayer%2Fnfl%2F-LHtsQxxKXCDPHwI_ZUf%2FtavonAustin.png?alt=media&token=ef496818-97f7-49b6-8e09-c1df667b9e1a", "https://firebasestorage.googleapis.com/v0/b/ticketmaster-23010.appspot.com/o/YHPlayer%2Fnfl%2F-LHtsQxxKXCDPHwI_ZUg%2FrandallCobb.png?alt=media&token=5b32295e-6177-473c-bdca-e18136f274f0", "https://firebasestorage.googleapis.com/v0/b/ticketmaster-23010.appspot.com/o/YHPlayer%2Fnfl%2F-LHtsQxxKXCDPHwI_ZUh%2FjamaalWilliams.png?alt=media&token=cf795d65-cab2-408d-ac42-1802b04503f0"]
let playerSports = ["football", "football", "football", "football", "football", "football"]
let playerSportsLeagues = ["NFL", "NFL", "NFL", "NFL", "NFL", "NFL"]
let playerPositions = [ "QB", "QB", "RB", "WR", "WR", "RB"]
let playerNextGameDates = ["2018/09/09 20:20", "2018/09/09 13:00", "2018/09/09 13:00", "2018/09/09 16:25", "2018/09/09 20:20", "2018/09/09 20:20"]
let playerNextGameTeams = ["CHI", "NE", "TB", "CAR", "CHI", "CHI"]
let playerNextGameProjPts = [22.87, 22.34, 21.32, 4.23, 9.16, 9.42]
let playerAdds = [1, 2, 0, 67, 53, 40]
let playerOwnedPercentage = [0, 0, 0, 0, 0, 0]
let playerDrops = [0, 0, 0, 4, 8, 8]
let playerTrades = [0, 0, 0, 0, 0, 0]
let playerOwnershipTypes = ["freeAgent", "freeAgent", "freeAgent", "freeAgent", "freeAgent", "freeAgent"]

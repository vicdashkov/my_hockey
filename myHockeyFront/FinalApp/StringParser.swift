//
//  StringParser.swift
//  FinalApp
//
//  Created by viktor dashkov on 2016-06-15.
//  Copyright © 2016 viktor dashkov. All rights reserved.
//

import Foundation

class StringParser {
    
    static func returnBets(_ betsString: String) -> [Bet] {
        var betsToReturn = [Bet]()
        
        if betsString.characters.count > 1 {
            let arrayWithBetsString = betsString.components(separatedBy: "|")
            for betString in arrayWithBetsString {
                let separatedBetsStringArray = betString.components(separatedBy: ":")
                let bet = Bet()
                
                bet.iBetPoints = Int(separatedBetsStringArray[0])!
                bet.team1id = Int(separatedBetsStringArray[1])!
                bet.team2id = Int(separatedBetsStringArray[2])!
                bet.oddsForTeam1 = Double(separatedBetsStringArray[3])!
                bet.oddsForTeam2 = Double(separatedBetsStringArray[4])!
                bet.team1Scored = Int(separatedBetsStringArray[5])!
                bet.team2Scored = Int(separatedBetsStringArray[6])!

                bet.teamIBetOn = Int(separatedBetsStringArray[7].trim())!
                betsToReturn.append(bet)
            }
        } else {
            let bet = Bet()
            
            bet.iBetPoints = 0
            bet.team1id = 1
            bet.team2id = 1
            bet.oddsForTeam1 = 0
            bet.oddsForTeam2 = 0
            bet.team1Scored = 0
            bet.team2Scored = 0
            
            bet.teamIBetOn = 1
            betsToReturn.append(bet)
        }
        
        return betsToReturn
    }
    
    // [team1peoplebets,team2peoplebets]
    static func returnPeoplesBets(_ serverString: String) -> [Int] {
        let betsArray = serverString.trim().components(separatedBy: "|")
        var arrayToReturn = [Int]()
//        print(betsArray)
        
        if let team1bets = Int(betsArray[0]) {
            arrayToReturn += [team1bets]
        } else {
            arrayToReturn += [0]
        }
        
        if let team2bets = Int(betsArray[1]) {
            arrayToReturn += [team2bets]
        } else {
            arrayToReturn += [0]
        }
        
        return arrayToReturn
    }
    
    // Returns games from server
    static func returnGames(_ gamesString: String) -> [Game] {
        
        var gamesToReturn = [Game]()
        
        let arrayWirthGamesInStringForm = gamesString.components(separatedBy: "|")
        
        if gamesString.characters.count !=  0 {
            for gameString in arrayWirthGamesInStringForm {
                
                let separatedGameStringArray  = gameString.components(separatedBy: ":")
                
                let game = Game()
                
                game.team1 = Team(id: separatedGameStringArray[0])
                game.team2 = Team(id: separatedGameStringArray[1])
                game.gameId = Int(separatedGameStringArray[2])!
                game.team1odds = Double(separatedGameStringArray[3])!
                game.team2odds = Double(separatedGameStringArray[4])!
                game.stadiumId = Int(separatedGameStringArray[5])!
                game.setGameDateString = separatedGameStringArray[6]
                game.team1Scored = Int(separatedGameStringArray[7])!
                game.team2Scored = Int(separatedGameStringArray[8])!
                
                gamesToReturn.append(game)
            }
        } else {
            
            let game = Game()
            
            game.team1 = Team()
            game.team2 = Team()
            game.gameId = Int("0")!
            game.team1odds = Double("0")!
            game.team2odds = Double("0")!
            game.stadiumId = Int("0")!
            
            gamesToReturn.append(game)
        }
        
        return gamesToReturn
    }
    
    // Returns users for leaderboard
    static func returnUsersLeaderboard(_ usersString: String) -> [User] {
        var usersToReturn = [User]()
        
        let arrayWithUsersInString = usersString.components(separatedBy: "|")
        for userString in arrayWithUsersInString {
            let separatedUserStringArray = userString.components(separatedBy: ":")
            let user = User()
            user.nickname = separatedUserStringArray[0]
            user.points = Int(separatedUserStringArray[1])!
            usersToReturn.append(user)
        }
        
        return usersToReturn
    }
}

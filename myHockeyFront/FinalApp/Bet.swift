//
//  File.swift
//  FinalApp
//
//  Created by viktor dashkov on 2016-06-28.
//  Copyright © 2016 viktor dashkov. All rights reserved.
//

import Foundation

class Bet {
    
    // setting info from the db query
    var team1id = 0
    var team2id = 0
    var iBetPoints = 0
    var oddsForTeam1 = 0.00
    var oddsForTeam2 = 0.00
    var team1Scored = 0
    var team2Scored = 0
    var teamIBetOn = 0
    
    // 0 - for game not played or tie
    var winner: Int {
        get {
            if(team1Scored > team2Scored) {
                return team1id
            } else if (team1Scored < team2Scored) {
                return team2id
            } else {
                return 0
            }
        }
    }
    
    // 0 for tie or loose
    var myWinAmmount: Double {
        get {
            if winner == teamIBetOn {
                
                if winner == team1id {
                    return Double(iBetPoints) * oddsForTeam1
                } else {
                    return Double(iBetPoints) * oddsForTeam2
                }
            } else {
                return 0
            }
        }
    }
    
    var team1name: String {
        get {
            return Constants.TEAMS_AS_IN_DB[team1id]!
        }
    }
    
    var team2name: String {
        get {
            return Constants.TEAMS_AS_IN_DB[team2id]!
        }
    }

}
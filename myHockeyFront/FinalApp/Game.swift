//
//  Game.swift
//  FinalApp
//
//  Created by viktor dashkov on 2016-06-11.
//  Copyright © 2016 viktor dashkov. All rights reserved.
//

import Foundation

// Data class
class Game {

    
    // MARK: Main Instance Variables
    
    var team1: Team
    var team2: Team
    var gameId: Int
    
    // Not setting these vars below from the init
    var stadiumId: Int = 0
    var team1odds: Double = 0
    var team2odds: Double = 0
    var team1Scored = 0
    var team2Scored = 0
    
    
    var setGameDateString: String = "1980-01-01"
    var getGameDateString: String {
        get {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            dateFormatter
            let gameDate = dateFormatter.date(from: setGameDateString)!
            dateFormatter.dateStyle = .full
            return dateFormatter.string(from: gameDate)
        }
    }

    init(team1: Team, team2: Team, gameId: Int) {
        self.team1 = team1
        self.team2 = team2
        self.gameId = gameId
    }
    
    init() {
        team1 = Team()
        team2 = Team()
        gameId = 0
    }
}

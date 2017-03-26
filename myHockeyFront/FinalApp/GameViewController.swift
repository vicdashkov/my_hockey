//
//  ViewController.swift
//  FinalApp
//
//  Created by viktor dashkov on 2016-06-10.
//  Copyright © 2016 viktor dashkov. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    // MARK: Instance Variables
    
    var game: Game?
    var gamesInMemory: [Game]?
    
    // MARK: View Outlets
    @IBOutlet weak var gameDateLabel: UILabel!
    
    @IBOutlet weak var betTeam1View: UIButton!
    @IBOutlet weak var betTeam2View: UIButton!
    
    @IBOutlet weak var team1Logo: UIImageView!
    @IBOutlet weak var team2Logo: UIImageView!
    
    
    @IBOutlet weak var team1OddsLabel: UILabel!
    @IBOutlet weak var team2OddsLabel: UILabel!
   
    
    @IBOutlet weak var team1ChancesLabel: UILabel!
    @IBOutlet weak var team2ChancesLabel: UILabel!
    
    @IBOutlet weak var team1PeopleBet: UILabel!
    @IBOutlet weak var team2PeopleBet: UILabel!
    
    // MARK: Action Outlets
    
    @IBAction func betTeam1Button(_ sender: AnyObject) {
        promptForBetWithAlert { ammountEntered in
            self.sendBetToServer(ammountEntered, teamId: self.game!.team1.teamId, odds: self.game!.team1odds)
        }
        
    }
    @IBAction func betTeam2Button(_ sender: AnyObject) {
        promptForBetWithAlert { ammountEntered in
            self.sendBetToServer(ammountEntered, teamId: self.game!.team2.teamId, odds: self.game!.team2odds)
        }
    }
    
    // This function will create new alert and will call method we pass with entered ammount
    func promptForBetWithAlert(_ callbackFuncton: @escaping (_ ammountEtered: Int) -> Void) {
        
        let alert = UIAlertController(title: "Some Title", message: "Enter a text", preferredStyle: .alert)
        
        alert.addTextField(configurationHandler: { (textField) -> Void in
            textField.keyboardType = UIKeyboardType.numberPad
            textField.text = ""
        })
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            let textField = alert.textFields![0] as UITextField
            
            if let enteredAmount = Int(textField.text!) {
                callbackFuncton(enteredAmount)
            }
            
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    // MARK: Connectivity Methods
    
    // This method sends special string to server
    // This string contains information about bet
    // In case of success or error, massage will be printed to the console
    // Message format:
    // user_id:game_id:amount_points:team_id:odds
    func sendBetToServer(_ ammount: Int, teamId: Int, odds: Double) {
        
        let gameId = (game?.gameId)!
        
        let messageToSend = "\(Constants.userId):\(gameId):\(ammount):\(teamId):\(odds)"
        
        ServerConnector.dataRequest("placeBet", postMessage: messageToSend) { string in
            
            // This is the place where I can get message from "closeTheDay" function
            print(string)
            self.compareGamesAndSendFlashNotification()
        }
    }
    
    func compareGamesAndSendFlashNotification() {
        ServerConnector.dataRequest("returnUpcomingGames") { string in
            let newGames = StringParser.returnGames(string)
            
            // This is simplification based on the fact that only one game can be played a day.
            if self.gamesInMemory![0].gameId != newGames[0].gameId {
                ServerConnector.dataRequest("returnPastGames") { string in
                    DispatchQueue.main.async(execute: {

                        let gameThatWasPlayed = StringParser.returnGames(string)[0]
                        let team1Name = gameThatWasPlayed.team1.id
                        let team2Name = gameThatWasPlayed.team2.id
                        let team1Score = gameThatWasPlayed.team1Scored
                        let team2Score = gameThatWasPlayed.team2Scored
                        
                        TopNotificationManager.addMessageToFlash("\(team1Name) \(team1Score) - \(team2Score) \(team2Name)")
                    })
                }
            }
        }
    }
    
    // This will send request to server with game id to get amount of people
    // betting on the selected games.
    // If I have time, can add animation.
    func updatePeopleBetLabels() {
        ServerConnector.dataRequest("returnPeopleBet", postMessage: "\((game?.gameId)!)") { string in
            
            let bets = StringParser.returnPeoplesBets(string)
//            print(bets)
            DispatchQueue.main.async(execute: {
                self.team1PeopleBet.text = String(bets[0])
                self.team2PeopleBet.text = String(bets[1])
            })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        betTeam1View.setTitle("Bet on \(game!.team1.id)", for: UIControlState())
        betTeam2View.setTitle("Bet on \(game!.team2.id)", for: UIControlState())
        
        team1Logo.image = UIImage(named: game!.team1.id)
        team2Logo.image = UIImage(named: game!.team2.id)
        
        team1OddsLabel.text = String(Int((game?.team1odds)!))
        team2OddsLabel.text = String(Int((game?.team2odds)!))
                
        team1ChancesLabel.text = "\(String(100 / Int((game?.team1odds)!)))%"
        team2ChancesLabel.text = "\(String(100 / Int((game?.team2odds)!)))%"
        
        gameDateLabel.text = game?.getGameDateString
        
        updatePeopleBetLabels()
        
        
    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

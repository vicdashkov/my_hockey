//
//  TableViewController.swift
//  FinalApp
//
//  Created by viktor dashkov on 2016-06-10.
//  Copyright © 2016 viktor dashkov. All rights reserved.
//
import UIKit

class GamesTableViewController: UITableViewController {
    
    var games = [Game]()
    var segmentedControlSelected = 0
    weak var activityIndicatorView: UIActivityIndicatorView!

    
    @IBOutlet weak var segmentedControlView: UISegmentedControl!
    @IBAction func segmentedControlButton(_ sender: UISegmentedControl) {
        populateTablesAccordingToSegmentedControl(sender.selectedSegmentIndex)
    }
    
    func populateTablesAccordingToSegmentedControl(_ index: Int) {
        switch index {
        case 0:
            populateTableViewFromServer("future")
            segmentedControlSelected = 0
        case 1:
            populateTableViewFromServer("past")
            segmentedControlSelected = 1
        default:
            print("this option doesn't exist")
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        populateTablesAccordingToSegmentedControl(segmentedControlSelected)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        populateTableViewFromServer("future")
        
        refreshControl = UIRefreshControl()
        refreshControl!.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl!.addTarget(self, action: #selector(GamesTableViewController.refresh(_:)), for: UIControlEvents.valueChanged)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        // Playing with activity indicator
        let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        tableView.backgroundView = activityIndicatorView
        self.activityIndicatorView = activityIndicatorView
        activityIndicatorView.startAnimating()


    }

    // This function fetches games from server and updates rows based on result
    // "wichGames" parameter takes future or past as two possible options
    func populateTableViewFromServer(_ whichGames: String) {
        var fileName: String = ""
        if whichGames == "future" {
            fileName = "returnUpcomingGames"
        } else {
            fileName = "returnPastGames"
        }
        
        ServerConnector.dataRequest(fileName) { string in
            self.games = StringParser.returnGames(string)
            DispatchQueue.main.async(execute: {
                self.tableView.reloadData()
            })
            
            // Adding pull-to-refresh
            self.refreshControl!.endRefreshing()
            self.activityIndicatorView.stopAnimating()

        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PrototypeCell", for: indexPath) as! GameCell

        let game = games[indexPath.row]
        let team1 = games[indexPath.row].team1
        let team2 = games[indexPath.row].team2
        
        cell.team1Text.text = team1.id
        cell.team2Text.text = team2.id
        cell.team1Image.image = team1.image
        cell.team2Image.image = team2.image

        cell.oddsIndicatorTeam1.animateOdds(game.team1odds, cell.oddsIndicatorHeightConstraintTeam1)
        cell.oddsIndicatorTeam2.animateOdds(game.team2odds, cell.oddsIndicatorHeightConstraintTeam2)

        return cell
    }

    // Function needed for "pull to refresh" functionality
    func refresh(_ sender:AnyObject) {
        if segmentedControlView.selectedSegmentIndex == 0 {
            populateTableViewFromServer("future")
        }
        else {
            populateTableViewFromServer("past")
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        
        let destinationViewController = segue.destination as! GameViewController
        
        let selectedTeam = sender as! GameCell
        let indexPath = tableView.indexPath(for: selectedTeam)
        let arrayIndexForClickeCell = indexPath!.row
        
        let gameOfTheClickedCell = games[arrayIndexForClickeCell]
        
        destinationViewController.game = gameOfTheClickedCell
        destinationViewController.gamesInMemory = games
    }
    

}

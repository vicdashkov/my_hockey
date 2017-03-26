//
//  LeaderboardTableView.swift
//  FinalApp
//
//  Created by viktor dashkov on 2016-06-18.
//  Copyright © 2016 viktor dashkov. All rights reserved.
//

import UIKit

class LeaderboardTableView: UIViewController, UITableViewDataSource {

    @IBOutlet weak var playerPlaceLabel: UILabel!
    @IBOutlet weak var leaderboardTableView: UITableView!
    
    var refreshControl: UIRefreshControl!
    var leaders = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        leaderboardTableView.dataSource = self
        populateTableViewFromServer()
        
        // Adding pull to refresh functionality
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(LeaderboardTableView.refresh(_:)), for: UIControlEvents.valueChanged)
        leaderboardTableView.addSubview(refreshControl) // not required when using UITableViewController
    }
    
    func refresh(_ sender:AnyObject) {
        populateTableViewFromServer()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leaders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeaderboardCell", for: indexPath) as! LeaderboardCell
        
        cell.positionLabel.text = String(indexPath.row + 1)
        cell.nickanameLabel.text = leaders[indexPath.row].nickname
        cell.pointsLabel.text = String(leaders[indexPath.row].points)
        
        cell.backgroundColor = UIColor.white
        
        // Performing check to find user and change cell to hightlight the user
        if (leaders[indexPath.row].nickname == UserDefaultsManager.getUserNickName()) {
            cell.backgroundColor = UIColor.cyan
            playerPlaceLabel.text = "You are on the \(indexPath.row + 1) place"
        }
        
        return cell
    }
    
    // This function fetches leaders from server and updates rows based on result
    func populateTableViewFromServer() {
        ServerConnector.dataRequest("returnLeaders") { string in
            self.leaders = StringParser.returnUsersLeaderboard(string)
            DispatchQueue.main.async(execute: {
                self.leaderboardTableView.reloadData()
                
                // Adding pull-to-refresh 
                self.refreshControl.endRefreshing()
            })
        }
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}

//
//  AccountViewController.swift
//  FinalApp
//
//  Created by viktor dashkov on 2016-06-11.
//  Copyright © 2016 viktor dashkov. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var accountViewTable: UITableView!
    var bets = [Bet]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        accountViewTable.dataSource = self
        populateTableViewFromServer()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        populateTableViewFromServer()
    }
    
    func populateTableViewFromServer() {
        ServerConnector.dataRequest("returnUserBets", postMessage: String(Constants.userId)) { string in
            self.bets = StringParser.returnBets(string)
            DispatchQueue.main.async(execute: {
                self.accountViewTable.reloadData()
            })
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "betCell", for: indexPath) as! AccountTableCell
        
        cell.setupCell(bets[indexPath.row])
    
        return cell
    }
}

//
//  AccountTableCell.swift
//  FinalApp
//
//  Created by viktor dashkov on 2016-06-28.
//  Copyright © 2016 viktor dashkov. All rights reserved.
//

import UIKit

class AccountTableCell: UITableViewCell {

    @IBOutlet weak var team1Label: UILabel!
    @IBOutlet weak var team2Label: UILabel!
    @IBOutlet weak var yourBetNumberLabel: UILabel!
    @IBOutlet weak var yourWinNumberLabel: UILabel!
    
    func setupCell(_ bet: Bet) {
        team1Label.text = Constants.TEAMS_AS_IN_DB[bet.team1id]
        team2Label.text = Constants.TEAMS_AS_IN_DB[bet.team2id]
        yourBetNumberLabel.text = String(bet.iBetPoints)
        yourWinNumberLabel.text = String(bet.myWinAmmount)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

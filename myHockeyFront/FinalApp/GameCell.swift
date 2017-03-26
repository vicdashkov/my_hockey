//
//  GameCell.swift
//  FinalApp
//
//  Created by viktor dashkov on 2016-06-11.
//  Copyright © 2016 viktor dashkov. All rights reserved.
//

import UIKit

class GameCell: UITableViewCell {
    
    @IBOutlet weak var team1Text: UILabel!
    @IBOutlet weak var team2Text: UILabel!
    
    @IBOutlet weak var team1Image: UIImageView!
    @IBOutlet weak var team2Image: UIImageView!
    
    @IBOutlet weak var oddsIndicatorTeam1: OddsIndicatorView!
    @IBOutlet weak var oddsIndicatorTeam2: OddsIndicatorView!
    
    @IBOutlet weak var oddsIndicatorHeightConstraintTeam1: NSLayoutConstraint!
    @IBOutlet weak var oddsIndicatorHeightConstraintTeam2: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

//
//  Team.swift
//  FinalApp
//
//  Created by viktor dashkov on 2016-06-16.
//  Copyright © 2016 viktor dashkov. All rights reserved.
//

import Foundation
import UIKit

class Team {
    // Id as in Constants
    // You need to rename this field. No good
    var id: String
    var image: UIImage
    var teamId: Int
    
    init(id: String) {
        self.id = id
        // We use id to instatiate UIImage becaus according to our convention, id should match assets
        self.image = UIImage(named: id)!
        self.teamId = Constants.UNIVERSAL_ASSETS_NAMES.index(of: id)! + 1
    }
    
    init() {
        id = "No Games Scheduled"
        image = UIImage()
        teamId = 0
    }
}

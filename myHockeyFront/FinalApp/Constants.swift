//
//  TeamConstants.swift
//  FinalApp
//
//  Created by viktor dashkov on 2016-06-16.
//  Copyright © 2016 viktor dashkov. All rights reserved.
//

import Foundation
import UIKit

class Constants {
    
    // These names to be used for all assets names as identifiers and as general id
    // This is bad name and bad usage, but I don't have time to refactor
    static let UNIVERSAL_ASSETS_NAMES = ["Calgary","Edmonton","Montreal","Ottawa","Toronto","Vancouver","Winnipeg"]
    
    static let userId = UserDefaultsManager.getUserId()
    
    static let TEAMS_AS_IN_DB =
        [1: "Calgary", 2: "Edmonton", 3: "Montreal", 4: "Ottawa", 5: "Toronto", 6: "Vancouver", 7: "Winnipeg"]
    
    static let MAIN_WINDOW = UIApplication.shared.keyWindow
    
}

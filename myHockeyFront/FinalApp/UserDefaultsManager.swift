//
//  UserDefaultsManager.swift
//  FinalApp
//
//  Created by viktor dashkov on 2016-06-11.
//  Copyright © 2016 viktor dashkov. All rights reserved.
//

import Foundation

class UserDefaultsManager {
    fileprivate static func saveStringToUserDefaults(_ string: String) {
        let defaults = UserDefaults.standard
        
        defaults.set(string, forKey: "testKey")
        
    }
    
    fileprivate static func getStringStoredInUserDefaults() -> String {
        let defaults = UserDefaults.standard
        
        if let personJsonString = defaults.object(forKey: "testKey") as? String {
            return personJsonString
        }
        
        return ""
    }

    // This function suppose to fetch user id from the "userDefaults"
    static func getUserId() -> Int {
        return 1
    }
    
    // This function suppose to fetch
    static func getUserNickName() -> String {
        return "vicD"
    }
}
